variable "project" {
  description = "Project slug used in resource names and tags. Must stay short: it is part of a globally unique storage account name (24 characters, lowercase alphanumeric only)."
  type        = string
  default     = "sifap"

  validation {
    condition     = can(regex("^[a-z0-9]{2,10}$", var.project))
    error_message = "project must be 2-10 lowercase alphanumeric characters (storage account names allow nothing else)."
  }
}

variable "environment" {
  description = "Environment name used in resource names and tags. The backend is shared infrastructure, so 'shared' is the default rather than 'lab'."
  type        = string
  default     = "shared"

  validation {
    condition     = can(regex("^[a-z0-9]{2,10}$", var.environment))
    error_message = "environment must be 2-10 lowercase alphanumeric characters."
  }
}

variable "owner" {
  description = "Owner tag. GitHub handle or e-mail of whoever is accountable for the state backend."
  type        = string
}

variable "cost_center" {
  description = "Cost center tag used for chargeback reporting."
  type        = string
  default     = "workshop-legacy-modernization"
}

variable "location" {
  description = "Azure region for the state backend. Keep it in the same region as the workloads it serves to avoid cross-region latency on every plan."
  type        = string
  default     = "eastus2"
}

variable "location_short" {
  description = "Optional override for the short region code used in resource names. Leave empty to derive it from var.location (see locals.location_short in main.tf)."
  type        = string
  default     = ""
}

variable "state_container_name" {
  description = "Blob container that holds every module's state file. One container, one blob per module (the `key` in each backend block)."
  type        = string
  default     = "tfstate"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{2,62}$", var.state_container_name))
    error_message = "state_container_name must be 3-63 characters, lowercase alphanumeric or hyphen, starting with a letter or digit."
  }
}

variable "account_replication_type" {
  description = <<-EOT
    Replication for the state account. ZRS is the default on purpose: losing Terraform state
    means losing the ability to manage every resource it tracks, and ZRS survives a single
    availability-zone failure for a few cents more per month. Drop to LRS only if the region
    has no zone support.
  EOT
  type        = string
  default     = "ZRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "GZRS", "RAGRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, ZRS, GRS, GZRS, RAGRS, RAGZRS."
  }
}

variable "blob_retention_days" {
  description = "Soft-delete window, in days, for blobs and containers in the state account. This is the undo button for a corrupted or truncated state file."
  type        = number
  default     = 30

  validation {
    condition     = var.blob_retention_days >= 7 && var.blob_retention_days <= 365
    error_message = "blob_retention_days must be between 7 and 365."
  }
}

variable "allowed_ip_rules" {
  description = <<-EOT
    Optional public IP allow-list for the state account firewall, in CIDR form.

    Empty (the default) leaves the account on its open public endpoint, which is what a
    workshop needs: GitHub-hosted runners have no stable egress IP, so an allow-list would
    break every CI plan. The account is still protected by Entra-only auth
    (shared_access_key_enabled = false), TLS 1.2, and private containers.

    Set it when you run plans from a fixed set of addresses (self-hosted runners, an office
    range). Azure rejects /31 and /32 masks here, so pass ranges of /30 or wider.
  EOT
  type        = list(string)
  default     = []

  validation {
    condition = length([
      for c in var.allowed_ip_rules : c
      if contains(["0.0.0.0/0", "*", "::/0", "internet", "any"], lower(trimspace(c)))
    ]) == 0
    error_message = "Open-to-the-internet sources are rejected. Leave the list empty for an open endpoint instead of writing 0.0.0.0/0, which reads as a mistake."
  }
}

variable "state_writer_principal_ids" {
  description = <<-EOT
    Object IDs of the Entra principals that must read and write state: typically the
    federated CI application used by .github/workflows/deploy-lab.yml, plus any human
    who runs plans locally.

    Each one gets "Storage Blob Data Contributor" scoped to the state container only.
    Leave empty if you prefer to grant the role out of band (see README.md ->
    "Grant access to the state container"); creating role assignments requires
    Owner or User Access Administrator on the subscription.
  EOT
  type        = list(string)
  default     = []
}

variable "assign_deployer_blob_role" {
  description = <<-EOT
    Grant the identity running THIS module "Storage Blob Data Contributor" on the state
    container. Required to create the container at all, because shared account keys are
    disabled and Owner alone carries no data-plane rights on blobs.

    Set to false only when the role was already granted out of band; the apply then fails
    with a 403 on the container unless that grant exists.
  EOT
  type        = bool
  default     = true
}

variable "enable_delete_lock" {
  description = <<-EOT
    Put a CanNotDelete management lock on the state resource group, on top of the
    Terraform-side prevent_destroy guards. Belt and braces: prevent_destroy only stops
    Terraform, a lock also stops the portal and the CLI.

    Off by default because creating locks needs Microsoft.Authorization/locks/write
    (Owner or User Access Administrator), which many workshop tenants withhold.
  EOT
  type        = bool
  default     = false
}
