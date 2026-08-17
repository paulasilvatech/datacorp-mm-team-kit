---
name: "azure-container-registry-cli"
description: "Use when working with Azure Container Registry, running az acr commands, or pushing, importing, building, or purging container images in Azure. Covers registries, cloud builds, ACR Tasks, authentication, tokens, geo-replication, and networking. Triggers include \"az acr\", \"push image to ACR\", \"build image in Azure\", \"ACR authentication\", and \"container registry\"."
---
# Azure Container Registry CLI

Manage Azure Container Registry (ACR) resources with the `az acr` command group of the Azure CLI. `az acr` ships with the core Azure CLI — no extension is required (the `acrtransfer` extension is only needed for export/import pipelines).

> [!NOTE]
> This skill depends on the **`az` CLI** being installed and authenticated. For this kit, provision the registry itself as Terraform (`azurerm_container_registry`, with the required `project`, `environment`, and `owner` tags) under `infra/`; use `az acr` for operational tasks — building, importing, tagging, and diagnosing images — not as the system of record for infrastructure.

## When to invoke

- "Push our Spring Boot image to Azure Container Registry."
- "Build a container image in Azure without a local Docker daemon."
- "How do I let AKS pull from this registry without the admin user?"
- "Clean up old tags to reduce ACR storage cost."

## Prerequisites

Install the Azure CLI, then sign in and select a subscription:

```bash
brew install azure-cli                                     # macOS
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash     # Linux
winget install Microsoft.AzureCLI                          # Windows
az login
az account set --subscription {subscription-id}
```

## Quick start

```bash
az acr create --resource-group {rg} --name {registry} --sku Standard          # SKU: Basic | Standard | Premium
az acr login --name {registry}                                                # authenticate Docker/Podman
az acr build --registry {registry} --image app:v1 .                           # cloud build, no local Docker
az acr import --name {registry} --source mcr.microsoft.com/hello-world:latest  # server-side copy
az acr repository list --name {registry} --output table
az acr repository show-tags --name {registry} --repository app --orderby time_desc
az acr check-health --name {registry} --yes                                   # diagnose connectivity
```

## Key principles

- **Prefer `az acr build` / ACR Tasks** over local `docker build` + `docker push`: builds run in Azure, work without a local daemon, and integrate with triggers.
- **Prefer `az acr import`** to move images between registries: it is server-side, faster, and needs no local storage.
- **Never enable the admin user for production.** Use Microsoft Entra identities (RBAC roles `AcrPull`/`AcrPush`, or `Container Registry Repository Reader`/`Writer` on ABAC-enabled registries), repository-scoped tokens, or managed identities.
- **Premium-only features**: geo-replication, private endpoints, retention policies, connected registries, and agent pools. Repository-scoped tokens work in all tiers; zone redundancy is automatic in supported regions.

## CLI structure

```text
az acr
├── create / delete / list / show / update   Registry lifecycle
├── login                  Docker credential helper (or --expose-token)
├── check-health / check-name / show-usage    Diagnostics and quota
├── build                  Cloud image build (quick task)
├── run                    Run a command or multi-step task once
├── task                   ACR Tasks (triggers, timers, logs, runs)
├── agentpool              Dedicated task agent pools (Premium)
├── import                 Server-side image copy into the registry
├── repository             List/show/delete/untag repos and tags, lock images
├── manifest               Manifest metadata, delete, OCI referrers
├── credential             Admin user credentials (avoid in production)
├── token / scope-map      Repository-scoped tokens (Premium)
├── replication            Geo-replication (Premium)
├── network-rule           IP network rules
├── private-endpoint-connection   Private Link approvals
├── config                 content-trust, retention, soft-delete, ...
├── cache / credential-set Artifact cache (pull-through cache) rules
├── webhook                Push/delete event webhooks
├── connected-registry     On-premises / IoT connected registries
└── export-pipeline / import-pipeline / pipeline-run   acrtransfer extension
```

## Reference files

Read the relevant reference file based on the task. Each contains complete command syntax and examples for its domain.

| File | When to read | Covers |
|---|---|---|
| [references/auth-and-security.md](references/auth-and-security.md) | Login failures, permissions, CI/CD or AKS pull access | `az acr login` (incl. `--expose-token`), Entra RBAC roles, service principals, managed identities, `--attach-acr` for AKS, repository-scoped tokens and scope maps, admin user, content trust |
| [references/build-and-tasks.md](references/build-and-tasks.md) | Building images in Azure, automation, CI triggers | `az acr build`, `az acr run`, multi-step task YAML, `az acr task` (git/base-image/timer triggers, logs, runs), agent pools |
| [references/images-and-artifacts.md](references/images-and-artifacts.md) | Managing repos, tags, cleanup, storage cost | `az acr import`, repository and manifest commands, untag vs delete, purge (`acr purge`), image locking, retention policy, soft delete, artifact cache, `show-usage` |
| [references/networking-and-geo.md](references/networking-and-geo.md) | Multi-region, private access, edge scenarios | Geo-replication, zone redundancy, private endpoints, network rules, dedicated data endpoints, connected registries, registry transfer pipelines |

## Output template

Deliver a runnable command plan with the identity model made explicit:

```bash
az acr create --resource-group rg-sifap --name sifapregistry --sku Standard
az acr build --registry sifapregistry --image sifap-backend:$(git rev-parse --short HEAD) .
az acr repository show-tags --name sifapregistry --repository sifap-backend --output table
az role assignment create \
  --assignee <aks-kubelet-identity-object-id> \
  --role AcrPull \
  --scope $(az acr show --name sifapregistry --query id --output tsv)
```

Summarize what was done and the security posture:

```text
Registry: sifapregistry (Standard) in rg-sifap
Image: sifap-backend:<git-sha> built in Azure (no local Docker)
Access: AcrPull granted to the AKS kubelet managed identity; admin user disabled
```

## Quality gate

- [ ] The registry SKU matches the need (Premium only when geo-replication, private endpoints, or scoped tokens are required).
- [ ] Images are built with `az acr build` / ACR Tasks rather than local `docker build` + `docker push` where feasible.
- [ ] The admin user is disabled; access uses an Entra identity (`AcrPull`/`AcrPush`), a managed identity, or a repository-scoped token.
- [ ] `az acr check-health --name {registry}` reports no errors.
- [ ] Cross-registry image moves use `az acr import` (server-side), not local pull/push.
- [ ] The registry resource is captured in Terraform under `infra/` with the required `project`, `environment`, and `owner` tags.
