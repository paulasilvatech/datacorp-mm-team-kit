locals {
  # Short region codes for the regions this kit is realistically deployed to. The map keeps
  # names readable (sifap-shared-rg-tfstate-eus2) without hardcoding a region anywhere;
  # anything not listed falls back to a compacted form of the region name so a new region
  # still produces a valid, if uglier, suffix.
  location_short_map = {
    eastus2        = "eus2"
    eastus         = "eus"
    westus2        = "wus2"
    westus3        = "wus3"
    centralus      = "cus"
    southcentralus = "scus"
    brazilsouth    = "brs"
    northeurope    = "neu"
    westeurope     = "weu"
    uksouth        = "uks"
    swedencentral  = "sec"
  }

  location_short = var.location_short != "" ? var.location_short : lookup(
    local.location_short_map,
    var.location,
    substr(replace(lower(var.location), "/[^a-z0-9]/", ""), 0, 6)
  )

  name_prefix = "${var.project}-${var.environment}"

  tags = {
    project     = var.project
    environment = var.environment
    owner       = var.owner
    cost-center = var.cost_center
    workload    = "terraform-remote-state"
    managed-by  = "terraform"
  }
}

data "azurerm_client_config" "current" {}

# ---------------------------------------------------------------------------
# Resource group
# ---------------------------------------------------------------------------

resource "azurerm_resource_group" "state" {
  name     = "${local.name_prefix}-rg-tfstate-${local.location_short}"
  location = var.location
  tags     = local.tags

  lifecycle {
    # Deleting this group destroys the state of every other module in the repository.
    # There is no lab-style "destroy and forget" path here on purpose.
    prevent_destroy = true
  }
}

# ---------------------------------------------------------------------------
# State storage account
# ---------------------------------------------------------------------------

# Storage account names are globally unique, 3-24 characters, lowercase alphanumeric only.
# "sifap" + "tfstate" + 6 random = 18 characters, which leaves room for a longer project slug.
resource "random_string" "account_suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

# ACCEPTED RISK: trivy AVD-AZU-0012 wants network rules with default_action = "Deny".
# GitHub-hosted runners have no stable egress IP, so a default-Deny firewall with an empty
# allow-list would lock CI out of its own state on the first plan. The compensating controls
# are stronger than an IP list: shared keys are disabled so no credential exists to steal,
# every caller authenticates as itself through Entra, and the container is private. Set
# var.allowed_ip_rules to switch this to default-Deny when you run plans from fixed
# addresses (self-hosted runners or an office range).
#trivy:ignore:AVD-AZU-0012
resource "azurerm_storage_account" "state" {
  name                = "${var.project}tfstate${random_string.account_suffix.result}"
  resource_group_name = azurerm_resource_group.state.name
  location            = azurerm_resource_group.state.location
  tags                = local.tags

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type

  # --- security posture -----------------------------------------------------
  # No shared keys: every caller authenticates with its own Entra identity, so a leaked
  # connection string cannot exist. This is what makes `use_azuread_auth = true` mandatory
  # in every consuming backend block.
  shared_access_key_enabled = false
  min_tls_version           = "TLS1_2"
  # Belt and braces against a container accidentally flipped to public.
  allow_nested_items_to_be_public = false
  https_traffic_only_enabled      = true
  # State blobs are read and written by CI over the public endpoint; the firewall below
  # narrows that when var.allowed_ip_rules is set.
  public_network_access_enabled = true

  # --- durability -----------------------------------------------------------
  # Versioning plus soft delete is the recovery story for "someone ran the wrong apply".
  # Every write produces a new version, and a deleted blob or container can be restored
  # for var.blob_retention_days.
  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true

    delete_retention_policy {
      days = var.blob_retention_days
    }

    container_delete_retention_policy {
      days = var.blob_retention_days
    }
  }

  # Only rendered when var.allowed_ip_rules is non-empty; an empty allow-list with
  # default_action = "Deny" would lock everyone out, including this very apply.
  dynamic "network_rules" {
    for_each = length(var.allowed_ip_rules) > 0 ? [1] : []
    content {
      default_action = "Deny"
      ip_rules       = var.allowed_ip_rules
      bypass         = ["AzureServices"]
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "state" {
  name                  = var.state_container_name
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"

  # Containers are not taggable ARM resources; the tagged object is the account above.

  depends_on = [time_sleep.wait_for_blob_role]

  lifecycle {
    prevent_destroy = true
  }
}

# ---------------------------------------------------------------------------
# Data-plane access
#
# shared_access_key_enabled = false means Owner on the subscription grants NOTHING on the
# blobs themselves. Both the operator running this module and the CI identity need an
# explicit data-plane role, scoped to the account (not the subscription).
# ---------------------------------------------------------------------------

resource "azurerm_role_assignment" "deployer_blob" {
  count = var.assign_deployer_blob_role ? 1 : 0

  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "state_writers" {
  for_each = toset(var.state_writer_principal_ids)

  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

# Entra role assignments are eventually consistent: the container create below routinely
# fails with 403 if it fires the instant the assignment is written. If the apply still 403s,
# wait a minute and re-run - the module is idempotent.
resource "time_sleep" "wait_for_blob_role" {
  create_duration = "60s"

  depends_on = [
    azurerm_role_assignment.deployer_blob,
    azurerm_role_assignment.state_writers,
  ]

  triggers = {
    storage_account_id = azurerm_storage_account.state.id
  }
}

# ---------------------------------------------------------------------------
# Optional hard lock
# ---------------------------------------------------------------------------

# Management locks are not taggable; the tagged object is the group they protect.
resource "azurerm_management_lock" "state" {
  count = var.enable_delete_lock ? 1 : 0

  name       = "${local.name_prefix}-tfstate-nodelete"
  scope      = azurerm_resource_group.state.id
  lock_level = "CanNotDelete"
  notes      = "Terraform remote state. Removing this group orphans every managed resource in the repository."
}
