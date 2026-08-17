# Terraform Remote State Bootstrap

> **Track:** [Team Kit](../../README.md) › [Infrastructure](../adabas-natural-lab/README.md) › **State Bootstrap**

**Creates the Azure Storage account that every other Terraform module in this repository uses as its remote backend.**

![Runbook Type](https://img.shields.io/badge/Type-Runbook-171717?style=flat-square) ![Run Once](https://img.shields.io/badge/Frequency-Run%20Once-737373?style=flat-square) ![Azure Subscription Cost](https://img.shields.io/badge/Cost-Azure%20Subscription-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | DevOps Engineer, or whoever owns the Azure subscription |
| **Prerequisites** | Azure subscription, authenticated Azure CLI, Terraform 1.14.x, Owner (or Contributor + User Access Administrator) |
| **Estimated time** | 5 minutes, run once per subscription |
| **Stage** | Prerequisite for every module under `infra/` |
| **Expected result** | A hardened storage account and container, plus the three values the lab module and CI need |

---

## Why this module exists

Terraform state is the map between your configuration and the real resources in Azure. Before this module existed, the lab module wrote that map to `terraform.tfstate` on one laptop. Three consequences followed:

| Local state | Remote state |
|---|---|
| Only the laptop that ran `apply` can run `destroy` | Anyone holding the role can take over |
| Two people applying at once silently corrupt each other | The backend takes a blob lease; the second apply waits |
| A lost laptop means orphaned, still-billing Azure resources | State survives the laptop |

CI cannot deploy at all without a shared backend, so this is the first thing to run.

## Why this module keeps local state

This module creates the backend, so it cannot consume it. That is the chicken-and-egg, and the resolution is deliberate:

- **`infra/bootstrap/` runs on local state.** Its own `terraform.tfstate` stays on the operator's machine and is gitignored.
- **Every other module uses the remote backend** this one produces.

Losing the bootstrap state is recoverable and low impact: the storage account keeps existing and keeps serving every other module. You would only need to `terraform import` the resources back if you wanted to change the backend itself. Losing a *workload* module's state is the expensive failure, and that is exactly the one this module removes.

## What gets created

| Resource | Name pattern | Why it is configured this way |
|---|---|---|
| Resource group | `sifap-shared-rg-tfstate-eus2` | `prevent_destroy` — deleting it orphans every managed resource in the repo |
| Storage account | `sifaptfstate<6-random>` | Globally unique name; hardened settings below |
| Blob container | `tfstate` | Private; one blob per module, addressed by the backend `key` |
| Role assignments | — | `Storage Blob Data Contributor` for the operator and for the CI identity |
| Management lock | `sifap-shared-tfstate-nodelete` | Optional (`enable_delete_lock`); stops portal and CLI deletion too |

Storage account hardening, and the reason for each setting:

| Setting | Value | Reason |
|---|---|---|
| `shared_access_key_enabled` | `false` | No account key exists, so no connection string can leak. Callers use their own Entra identity |
| `min_tls_version` | `TLS1_2` | Refuses downgraded transport |
| `allow_nested_items_to_be_public` | `false` | A container cannot be flipped to anonymous read |
| `https_traffic_only_enabled` | `true` | No plaintext data plane |
| `versioning_enabled` | `true` | Every state write keeps the previous version |
| `delete_retention_policy` | 30 days | A deleted state blob is restorable |
| `container_delete_retention_policy` | 30 days | A deleted container is restorable |
| `account_replication_type` | `ZRS` | State loss is unrecoverable; a zone failure should not cause it |

> [!IMPORTANT]
> Because `shared_access_key_enabled = false`, **Owner on the subscription grants nothing on the blobs themselves**. Data-plane access is a separate role assignment. That is why this module assigns `Storage Blob Data Contributor` to the caller, and why every consuming backend block sets `use_azuread_auth = true`.

---

## Run it

- [ ] **Step 1 — Select the subscription.** The provider reads it from the environment; it is not a Terraform variable.

```bash
az login
az account show --query id -o tsv
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION-ID>"
```

- [ ] **Step 2 — Create your variables file.**

```bash
cd infra/bootstrap
cp terraform.tfvars.example terraform.tfvars
```

Set `owner`. If you already know the object ID of the CI application that `deploy-lab.yml` federates as, add it to `state_writer_principal_ids` now — that saves a second apply.

- [ ] **Step 3 — Initialize, plan, apply.**

```bash
terraform init
terraform plan -out=bootstrap.tfplan
terraform apply bootstrap.tfplan
```

- [ ] **Step 4 — Read the outputs.** Three values matter downstream.

```bash
terraform output storage_account_name
terraform output -raw backend_config_command
terraform output github_variables
```

> [!NOTE]
> Role assignments in Entra are eventually consistent. The module waits 60 seconds (`time_sleep.wait_for_blob_role`) before creating the container. If the apply still fails with `403` / `AuthorizationPermissionMismatch` on the container, wait a minute and re-run — the module is idempotent.

---

## Point the lab module at the backend

`infra/adabas-natural-lab/versions.tf` carries a **partial** backend configuration: the container name, the blob key, and the auth mode are committed; the resource group and account name are not, because the account name contains a random suffix that only exists after this module runs.

Supply the missing two on `init`:

```bash
terraform -chdir=../adabas-natural-lab init \
  -backend-config="resource_group_name=$(terraform output -raw resource_group_name)" \
  -backend-config="storage_account_name=$(terraform output -raw storage_account_name)"
```

Or write them to a gitignored `backend.hcl` once:

```bash
terraform output -raw backend_config_file > ../adabas-natural-lab/backend.hcl
terraform -chdir=../adabas-natural-lab init -backend-config=backend.hcl
```

`backend.hcl` is covered by the root `.gitignore`. It holds no secret — only two resource names — but keeping it untracked avoids pinning one team's account name into a public repository.

## Grant access to the state container

The CI identity needs the same data-plane role you have. Either declare it in `terraform.tfvars`:

```hcl
state_writer_principal_ids = [
  "00000000-0000-0000-0000-000000000000",
]
```

Or grant it out of band, which is what the `grant_state_access_command` output prints:

```bash
az role assignment create \
  --assignee "<CI-APP-OBJECT-ID>" \
  --role "Storage Blob Data Contributor" \
  --scope "<STORAGE-ACCOUNT-RESOURCE-ID>"
```

## Feed GitHub Actions

`.github/workflows/deploy-lab.yml` reads these as **repository variables**, never as secrets — none of them is one:

```bash
gh variable set TFSTATE_RESOURCE_GROUP  --body "$(terraform output -raw resource_group_name)"
gh variable set TFSTATE_STORAGE_ACCOUNT --body "$(terraform output -raw storage_account_name)"
gh variable set TFSTATE_CONTAINER       --body "$(terraform output -raw container_name)"
```

---

## Terraform version alignment

Every module in this repository pins `required_version = "~> 1.14.0"`, and both workflows install the same exact patch. Version drift between a laptop and CI is not cosmetic: the state file records the version that wrote it, and an older Terraform refuses to read state written by a newer one. That failure surfaces mid-apply, against the shared backend, with a lease held.

```bash
terraform version   # must report v1.14.x
```

---

## Cost

A state account holding a few hundred kilobytes of blobs costs cents per month. Versioning and 30-day soft delete multiply a very small number. There is no compute here and nothing to deallocate.

## Teardown

There is no routine teardown. `prevent_destroy` is set on the resource group, the storage account, and the container, so `terraform destroy` fails by design.

To retire a subscription entirely, in this order:

- [ ] **Step 1 — Destroy every workload module first**, while its state is still readable.
- [ ] **Step 2 — Remove the guards.** Delete the three `lifecycle { prevent_destroy = true }` blocks in `main.tf`, and set `enable_delete_lock = false` if you enabled it.
- [ ] **Step 3 — Destroy.**

```bash
terraform destroy
```

> [!CAUTION]
> Doing this while any workload module still has state in the container orphans those Azure resources. They keep billing, and nothing knows how to find them any more.

---

## Troubleshooting

| Symptom | Likely cause | Resolution |
|---|---|---|
| `403 AuthorizationPermissionMismatch` on the container | Role assignment has not propagated yet | Wait 60 seconds and re-run `terraform apply` |
| `KeyBasedAuthenticationNotPermitted` | A caller is trying to use an account key | The account has none by design; set `use_azuread_auth = true` in the backend block and `storage_use_azuread = true` in the provider |
| `AuthorizationFailed` on `Microsoft.Authorization/roleAssignments/write` | The caller is Contributor, not Owner | Set `assign_deployer_blob_role = false` and have an Owner run the grant out of band |
| Storage account name already taken | The 6-character random suffix collided globally | Taint `random_string.account_suffix` and re-apply |
| `Error acquiring the state lock` in another module | A previous run was interrupted | Confirm nothing is running, then `terraform force-unlock <LOCK-ID>` |
| A lock blocks a legitimate change | `enable_delete_lock = true` | Set it to `false`, apply, make the change, set it back |

---

## Completion criteria

- [ ] `terraform output storage_account_name` returns an account name.
- [ ] `az storage account show -n <ACCOUNT> --query allowSharedKeyAccess` returns `false`.
- [ ] The lab module runs `terraform init` against the backend without a key or SAS token.
- [ ] `TFSTATE_RESOURCE_GROUP`, `TFSTATE_STORAGE_ACCOUNT`, and `TFSTATE_CONTAINER` exist as GitHub repository variables.
- [ ] No `terraform.tfstate` from this module is tracked by git.

---

## References

| Resource | Location |
|---|---|
| Kit infrastructure conventions | [`.github/instructions/infrastructure.instructions.md`](../../.github/instructions/infrastructure.instructions.md) |
| CI/CD conventions | [`.github/instructions/cicd.instructions.md`](../../.github/instructions/cicd.instructions.md) |
| Adabas + Natural lab module | [`infra/adabas-natural-lab/README.md`](../adabas-natural-lab/README.md) |
| Deploy workflow | [`.github/workflows/deploy-lab.yml`](../../.github/workflows/deploy-lab.yml) |

---

### Continue reading

| Previous | Next |
|---|---|
| [Team Kit index](../../README.md)<br/><sub>Workshop overview.</sub> | [Adabas + Natural Lab](../adabas-natural-lab/README.md)<br/><sub>The module that consumes this backend.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
