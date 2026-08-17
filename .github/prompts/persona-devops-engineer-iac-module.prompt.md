---
name: "iac-module"
agent: "devops-engineer"
description: "Create or refactor a single Terraform module for SIFAP 2.0 Azure infrastructure with tags, variables, outputs, and validation."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /iac-module

## Objective

You are the DevOps engineer producing or updating a **single Terraform module** in `infra/modules/` for SIFAP 2.0. Modules are scoped to one Azure service area (networking, compute, database, monitoring, or security). The deliverable passes `terraform fmt`, `terraform validate`, `tflint`, and `checkov` without errors and includes an example.

## Inputs

Ask the user for anything that is missing.

- The module name and Azure service (for example, `postgres` for `azurerm_postgresql_flexible_server`).
- The linked `REQ-ID` in `specs/<NNN>-<feature>/spec.md` (usually a non-functional or operational requirement).
- The target environments (`dev`, `stage`, `prod`) and any environment-specific overrides.
- The existing baseline: are we creating a new module or modifying `infra/modules/<name>/`?

## Process

1. **Read the constitution and existing modules.** Open `.specify/memory/constitution.md` for non-negotiable rules (managed identity, Key Vault for secrets, no public IPs, etc.) and review existing modules for patterns to follow.
2. **Choose a Microsoft-supported provider version.** Use `azurerm ~> 4.x` and pin it through `required_providers`. Reference [Azure Verified Modules](https://aka.ms/avm) where applicable.
3. **Write the module skeleton.** At least five files:

- `main.tf` — resources only, with no `provider` block.
- `variables.tf` — every input typed and documented, with `validation` blocks where ranges matter.
- `outputs.tf` — IDs, names, and FQDNs needed by callers; never secrets.
- `versions.tf` — `terraform` and `required_providers`.
- `README.md` — purpose, inputs, outputs, and usage example.

4. **Apply the standard SIFAP tags** to every taggable resource:

 ```hcl
 tags = merge(var.tags, {
 project = "sifap"
 environment = var.environment
 owner = var.owner
 module = "<name>"
 managed_by = "terraform"
 })
 ```

5. **Secrets discipline.** No secrets in variables, no secrets in outputs, and no secrets in state files when they can be avoided. Connection strings come from `azurerm_key_vault_secret` data sources or are returned as URIs that callers can resolve at runtime.
6. **Identity discipline.** Use `system-assigned` or `user-assigned` managed identities; never put service principal credentials in code.
7. **Network discipline.** Do not use `public_network_access_enabled = true` without an exception in `.specify/memory/constitution.md`. Use private endpoints by default.
8. **Add an `examples/` folder.** Include a minimal `examples/basic/main.tf` that consumes the module—used by `tflint` and reviewers.
9. **Validate locally.** Run:

 ```
 terraform fmt -check -recursive
 terraform init -backend=false
 terraform validate
 tflint --recursive
 checkov -d . --soft-fail false
 ```

 All commands must pass.

## Output

Your final response must include:

- **Module summary** — name, purpose, REQ-ID.
- **All five files** with complete content.
- **Example consumer** — `examples/basic/main.tf`.
- **Validation report** — paste the output from `fmt`, `validate`, `tflint`, and `checkov`.
- **Cost note** — link to [Azure pricing](https://azure.microsoft.com/pricing/) for the selected SKU(s), with a one-line monthly estimate per environment.

## Anti-patterns

- Hard-coded subscription IDs, resource group names, or regions. Pass them as variables.
- `provider` blocks inside modules. Providers belong in root modules.
- Using `count = var.create ? 1 : 0` to make resources optional. Use separate modules or feature flags.
- Outputs that leak secrets (`administrator_password`, connection strings).
- `public_network_access_enabled = true` without an explicit exception in `.specify/memory/constitution.md`.
- Tagging some resources but not others. Tag everything that supports tags.
- Skipping `validation` blocks on numeric inputs—this produces cryptic Azure errors during apply.
- Mixing a module update with a feature change in the same PR. Module changes are delivered independently.

## Success Criteria

- [ ] `terraform fmt -check`, `terraform validate`, `tflint`, and `checkov` pass.
- [ ] Every taggable resource carries the standard tag set.
- [ ] No secrets in variables, outputs, or default values.
- [ ] Public network access is disabled unless an exception in `.specify/memory/constitution.md` is referenced.
- [ ] Managed identity is used; no SP credentials appear in code.
- [ ] A consumer in `examples/basic/` compiles and validates.
- [ ] The README documents inputs, outputs, and an example.
- [ ] The linked `REQ-ID` is cited in the module README.
