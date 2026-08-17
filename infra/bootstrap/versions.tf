terraform {
  # Pinned to the same minor line as every other module in this repository and as
  # the Terraform version the CI workflows install. See README.md
  # ("Terraform version alignment") before bumping this.
  required_version = "~> 1.14.0"

  # NO `backend` BLOCK ON PURPOSE.
  #
  # This is the chicken-and-egg module: it CREATES the storage account that every
  # other module uses as its remote backend. It therefore has to run on local
  # state. The state file it produces is small, contains no secrets, and is only
  # needed again if you ever want to change or destroy the backend itself.
  # See README.md -> "Why this module keeps local state".

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
  }
}

provider "azurerm" {
  # Required: the state storage account sets shared_access_key_enabled = false, so the
  # provider cannot fall back to listing account keys for data-plane calls (creating the
  # blob container). It must use the caller's Entra identity instead.
  storage_use_azuread = true

  features {
    resource_group {
      # State storage must never be removed by a stray `destroy` that only meant to
      # clean up the resource group.
      prevent_deletion_if_contains_resources = true
    }
  }
}
