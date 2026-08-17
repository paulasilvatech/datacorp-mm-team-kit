output "resource_group_name" {
  description = "Resource group holding the Terraform state account."
  value       = azurerm_resource_group.state.name
}

output "storage_account_name" {
  description = "Storage account that holds every module's remote state. Feed it to `terraform init -backend-config`."
  value       = azurerm_storage_account.state.name
}

output "container_name" {
  description = "Blob container holding the state files."
  value       = azurerm_storage_container.state.name
}

# No access key, no connection string and no SAS is emitted here, and none exists:
# shared_access_key_enabled is false on the account. Callers authenticate with their own
# Entra identity, which is why nothing in this file needs `sensitive = true`.
output "backend_config_command" {
  description = "Ready-to-run init for the lab module, with the generated account name filled in."
  value       = <<-EOT
    terraform -chdir=../adabas-natural-lab init \
      -backend-config="resource_group_name=${azurerm_resource_group.state.name}" \
      -backend-config="storage_account_name=${azurerm_storage_account.state.name}"
  EOT
}

output "backend_config_file" {
  description = "Contents for infra/adabas-natural-lab/backend.hcl (gitignored) if you prefer a file over -backend-config flags."
  value       = <<-EOT
    resource_group_name  = "${azurerm_resource_group.state.name}"
    storage_account_name = "${azurerm_storage_account.state.name}"
  EOT
}

output "github_variables" {
  description = "Repository-level GitHub Actions variables that .github/workflows/deploy-lab.yml reads."
  value = {
    TFSTATE_RESOURCE_GROUP  = azurerm_resource_group.state.name
    TFSTATE_STORAGE_ACCOUNT = azurerm_storage_account.state.name
    TFSTATE_CONTAINER       = azurerm_storage_container.state.name
  }
}

output "grant_state_access_command" {
  description = "Grants a principal the data-plane role needed to read and write state, for when var.state_writer_principal_ids was left empty."
  value       = <<-EOT
    az role assignment create \
      --assignee <PRINCIPAL-OBJECT-ID> \
      --role "Storage Blob Data Contributor" \
      --scope ${azurerm_storage_account.state.id}
  EOT
}
