---
name: "azure-role-selector"
description: "Use when the user asks which Azure RBAC role to assign to an identity, how to grant least-privilege permissions, or how to author a custom role when no built-in role fits. Recommends the narrowest built-in role, then emits the assignment as Terraform (azurerm_role_assignment), this kit's IaC. Triggers include \"which Azure role\", \"least privilege\", \"role assignment\", \"custom role definition\", and \"grant permissions\"."
---
# Azure role selector

Recommend the **least-privilege** Azure RBAC role for an identity given the actions it must perform, then express the assignment as Terraform (`azurerm_role_assignment`), which is this kit's IaC. Always prefer a built-in role at the narrowest scope; author a custom role definition only when no built-in role fits.

This skill teaches you how to choose and apply a role. It does not decide which identity or scope your workload needs — that comes from the specification and the team's own investigation.

> [!NOTE]
> This skill depends on the **Azure MCP server** (or the `az` CLI) to look up role definitions and generate assignment commands. If neither is installed, say so and fall back to the public Azure built-in role documentation.

## When to invoke

- "Which Azure role should I assign to this managed identity?"
- "Grant this service principal read-only access to one storage account, least privilege."
- "No built-in role fits — help me write a custom role definition."
- "Give the app's identity permission to read secrets from Key Vault."

## Selection procedure

1. **Capture the required actions.** List the exact operations the identity must perform (for example: read blobs, list secrets, send to a queue). Separate control-plane `actions` from data-plane `dataActions`.
2. **Pick the narrowest scope.** Assign at the smallest scope that satisfies the requirement: resource before resource group, resource group before subscription, subscription before management group.
3. **Match a built-in role.** Use the Azure MCP documentation tool to find the built-in role whose `actions`/`dataActions` cover the requirement with the least excess. Prefer data-plane roles (for example `Storage Blob Data Reader`) over broad management roles (`Contributor`).
4. **Fall back to a custom role only if needed.** When no built-in role fits, use the Azure MCP `extension_cli_generate` tool to draft a custom role definition that lists only the required `actions`/`dataActions` and an explicit `assignableScopes`.
5. **Generate the assignment.** Use the Azure MCP `extension_cli_generate` tool for the `az role assignment create` command, then translate it to Terraform for the kit deliverable.
6. **Prefer managed identity.** For service-to-service authentication, assign the role to a managed identity — never distribute secrets, keys, or connection strings.

## Least-privilege decision table

| Situation | Choose |
|---|---|
| A built-in role matches the actions exactly | The built-in role at the narrowest scope |
| A built-in role is close but slightly broad | Prefer the built-in role unless the extra permissions are sensitive; document the gap |
| No built-in role covers the actions | A custom role definition containing only the required actions |
| An Azure service must call another Azure service | A managed identity plus a role assignment, never a secret |
| The identity only reads data | A data-plane `... Data Reader` role, not `Reader` or `Contributor` |

> [!WARNING]
> Never assign `Owner` or `Contributor` at subscription or management-group scope to a workload identity. Those roles include `Microsoft.Authorization/*`, which lets the identity grant itself further access.

## Bicep and ARM — out of scope

A Bicep or ARM role-assignment snippet (via the Azure MCP `bicepschema` and `get_bestpractices` tools) is optional and **out of scope** for this kit's deliverables. Produce Terraform; use Bicep only for exploration or comparison.

## Output template

Deliver the recommendation plus a ready-to-commit Terraform snippet. Role assignments and role definitions do not support `tags`, so the kit's tagging rule does not apply to these resources.

```hcl
resource "azurerm_role_assignment" "app_blob_reader" {
  scope                = azurerm_storage_account.data.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.app.principal_id
}
```

When no built-in role fits, deliver a custom role definition alongside the assignment:

```hcl
resource "azurerm_role_definition" "read_one_container" {
  name        = "SIFAP Read Single Blob Container"
  scope       = azurerm_storage_account.data.id
  description = "Read-only access to a single blob container, least privilege."

  permissions {
    actions      = ["Microsoft.Storage/storageAccounts/blobServices/containers/read"]
    data_actions = ["Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read"]
    not_actions  = []
  }

  assignable_scopes = [azurerm_storage_account.data.id]
}
```

Summarize the choice in prose:

```text
Recommended role: Storage Blob Data Reader (built-in)
Scope: storage account azurerm_storage_account.data (narrowest that works)
Principal: user-assigned managed identity app
Why: covers blob read data-plane action with no excess; no custom role needed.
```

## Quality gate

- [ ] The recommended role is the narrowest built-in role that covers every required action.
- [ ] The assignment scope is the smallest scope that satisfies the requirement.
- [ ] A custom role is proposed only when no built-in role fits, and lists only the required actions with explicit `assignable_scopes`.
- [ ] The assignment is expressed as Terraform `azurerm_role_assignment` (Bicep/ARM left out of scope).
- [ ] Service-to-service authentication uses a managed identity, never a secret or connection string.
- [ ] No `Owner`/`Contributor` at subscription or management-group scope for a workload identity.

## License

Bundled material in this skill is provided under the [MIT License](LICENSE.txt).
