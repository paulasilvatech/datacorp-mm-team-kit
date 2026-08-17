---
name: "azure-well-architected-review"
description: "Use when the user asks for an Azure Well-Architected Framework review, an architecture assessment, or a reliability, security, cost, performance, or operational-excellence audit of an Azure workload. Reviews the five WAF pillars against the workload's IaC (Terraform for this kit; Bicep/ARM also readable) and deployed resources, then opens GitHub issues for the findings. Triggers include \"WAF review\", \"well-architected\", \"architecture assessment\", \"reliability audit\", and \"security review of Azure\"."
---
# Azure Well-Architected Review

This workflow performs a structured Azure Well-Architected Framework (WAF) review against a workload's IaC files and deployed infrastructure. It identifies risks across all five WAF pillars and creates GitHub issues to track remediation.

> [!NOTE]
> This kit's IaC is **Terraform (`azurerm ~> 3.x`)**. The review reads whatever IaC exists (Terraform, Bicep, or ARM), but remediation examples are written as Terraform. Bicep/ARM snippets are illustrative only and out of scope for the kit's deliverables. This skill also depends on the **`az` CLI** and the **GitHub MCP server** (or `gh`) being authenticated.

## When to invoke

- "Run a Well-Architected review on our Azure workload."
- "Audit this architecture for reliability and security risks."
- "Are we following Azure best practices across the five pillars?"
- "Open GitHub issues for the WAF gaps in our infrastructure."

## Prerequisites

- Azure CLI (`az`) configured and authenticated.
- IaC files present in the repository (Terraform preferred; Bicep or ARM also readable).
- GitHub MCP server (or `gh`) configured and authenticated.

## Workflow steps

### Step 1: Load Well-Architected Framework reference

Fetch current Azure WAF best practices:

- `https://learn.microsoft.com/en-us/azure/well-architected/`
- Service guides for the Azure services in use (`https://learn.microsoft.com/en-us/azure/well-architected/service-guides/`)
- Workload-specific guidance relevant to the workload type (SaaS, mission-critical, AI, and similar)

If the `microsoft.docs.mcp` MCP server is available, use it to query the latest pillar checklists and service-specific recommendations.

### Step 2: Discover IaC and architecture

Establish the review scope, then inventory both the code and the live environment:

1. **Confirm the Azure scope**: ask the user which subscription(s)/resource group(s) are in scope, or infer them from IaC parameters and confirm.
2. **Scan the repository for IaC files**:
   - Terraform: `**/*.tf` (azurerm/azapi providers) — this kit's primary IaC
   - Bicep: `**/*.bicep`, `bicepconfig.json`
   - ARM templates: `**/azuredeploy*.json`, `**/*.template.json`, files with `$schema` containing `deploymentTemplate`
3. **Inventory live resources** (always, even when IaC exists): `az resource list --resource-group <rg> --output json` (or subscription-wide), plus targeted `az <service> show` calls for the configuration details the pillar checks need.
4. **Compare IaC with live inventory**: flag drift — resources present in Azure but absent from IaC (portal-created), resources defined in IaC but not deployed, and configuration mismatches. Record drift findings for Step 3 (they typically map to the Operational Excellence pillar).

Identify the key Azure services in use (compute, data, networking, security, observability) and generate a Mermaid architecture diagram.

### Step 3: Pillar-by-pillar review

#### Pillar 1: Reliability

- [ ] Availability zones enabled for zonal services (VMs, VMSS, AKS node pools, App Service, SQL, Storage ZRS)
- [ ] Production SKUs support the required SLA (no Basic/Free tiers on critical paths)
- [ ] Azure SQL / Cosmos DB backup and point-in-time restore configured with appropriate retention
- [ ] Geo-redundancy configured where RPO requires it (GRS/RA-GRS storage, SQL failover groups, Cosmos DB multi-region)
- [ ] Autoscale rules configured for App Service plans, VMSS, AKS (no fixed single instance for production)
- [ ] Health probes configured on Load Balancer / Application Gateway / Front Door backends
- [ ] Dead-lettering enabled for Service Bus queues/subscriptions and Event Grid subscriptions
- [ ] Retry policies with exponential backoff implemented for transient fault handling
- [ ] Disaster recovery plan defined (documented RTO/RPO, tested failover)

#### Pillar 2: Security

- [ ] Managed identities used instead of service principals with secrets or connection strings
- [ ] No hardcoded credentials, keys, or connection strings in IaC or code
- [ ] Secrets stored in Azure Key Vault with RBAC authorization (not access policies)
- [ ] Storage accounts deny public blob access and disallow shared key access where possible
- [ ] Private endpoints (or at minimum service endpoints + firewall rules) for PaaS data services
- [ ] NSGs restrict inbound traffic to the minimum required ports/CIDRs (no `*` to `*` allow rules)
- [ ] TLS 1.2+ enforced on all endpoints (`minimumTlsVersion`, `httpsOnly`)
- [ ] Azure RBAC follows least privilege (no Owner/Contributor at subscription scope for workload identities)
- [ ] Microsoft Defender for Cloud enabled on relevant resource types (`az security pricing list`)
- [ ] Azure WAF (Application Gateway or Front Door) configured for public-facing web endpoints
- [ ] Diagnostic settings send security logs to Log Analytics / Microsoft Sentinel

#### Pillar 3: Cost Optimization

- [ ] Reservations or savings plans evaluated for steady-state compute (VMs, App Service, SQL)
- [ ] Storage lifecycle management policies move blobs to cool/archive tiers
- [ ] Right-sized SKUs based on actual utilization (no oversized VMs/App Service plans)
- [ ] Dev/test environments use auto-shutdown schedules and Dev/Test pricing where eligible
- [ ] Azure Budgets and cost alerts configured (`az consumption budget list`)
- [ ] Unattached managed disks and orphaned public IPs identified and removed
- [ ] Consumption/serverless tiers used for spiky or low-volume workloads (Functions, Container Apps, SQL serverless)
- [ ] Log Analytics retention and data-cap settings tuned to avoid ingestion overruns

#### Pillar 4: Operational Excellence

- [ ] All infrastructure defined as IaC (no manual portal changes; deny assignments or policy where feasible)
- [ ] Consistent tagging strategy applied across all resources (owner, environment, cost center)
- [ ] Azure Monitor alerts defined for key metrics and service health
- [ ] Automated deployment pipeline present (GitHub Actions / Azure Pipelines, no manual deployments)
- [ ] Azure Activity Log and resource diagnostic settings routed to Log Analytics
- [ ] Application Insights (or OpenTelemetry equivalent) instrumented for application workloads
- [ ] Azure Policy assignments enforce organizational standards (allowed locations, SKUs, tags)
- [ ] Runbooks or operational documentation present

#### Pillar 5: Performance Efficiency

- [ ] Right-sized compute SKUs validated against load requirements
- [ ] Caching implemented where beneficial (Azure Cache for Redis, CDN/Front Door caching)
- [ ] Azure Front Door or CDN used for global static content delivery
- [ ] Autoscale based on load metrics rather than fixed instance counts
- [ ] Database performance tier appropriate (DTU vs vCore, elastic pools, Cosmos DB RU autoscale)
- [ ] Premium/zone-redundant storage used for latency-sensitive disk workloads
- [ ] Connection pooling and async patterns used for database and HTTP clients

### Step 4: Risk classification

For each finding, classify:

| Risk | Meaning |
|---|---|
| High | Security vulnerability, single point of failure, no backup/recovery |
| Medium | Suboptimal reliability, cost inefficiency, performance concern |
| Low | Best-practice deviation, minor optimization opportunity |

### Step 5: User confirmation

Present the summary and gate on explicit approval before creating any GitHub issues:

```text
Azure Well-Architected Review Summary

Review Results:
- IaC Files Analyzed: X
- Azure Services Identified: Y
- Total Findings: Z
  - High Risk: A (immediate action required)
  - Medium Risk: B (should address soon)
  - Low Risk: C (nice to have)

Top High Risk Findings:
1. [Pillar]: [Finding] - [Why it matters]
2. [Pillar]: [Finding] - [Why it matters]

This will create Z individual GitHub issues plus 1 EPIC issue.

Proceed with creating GitHub issues? (y/n)
```

> [!IMPORTANT]
> Only proceed to Steps 6-7 if the user gives an explicit affirmative response (for example "y", "yes"). On a negative, ambiguous, or missing response, do **not** create any GitHub issues — output the full findings as formatted markdown to the console and stop.

### Step 6: Create individual finding issues

Label with `well-architected` and the pillar name (for example `security`, `reliability`).

Title: `[WAF-<PILLAR>] <Brief Finding> - <Risk Level>`

Body:

````markdown
## Well-Architected Finding: <Brief Title>

**Pillar**: <Name> | **Risk Level**: <High/Medium/Low> | **Effort**: <Low/Medium/High>

### Description
<Clear explanation of the finding and why it matters>

### Remediation

IaC fix (preferred, Terraform — this kit's IaC):
```hcl
resource "azurerm_storage_account" "data" {
  name                            = "sifapdata"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  account_tier                    = "Standard"
  account_replication_type        = "ZRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false

  tags = {
    project     = "sifap"
    environment = "prod"
    owner       = "platform-team"
  }
}
```

Azure CLI fallback:
```bash
az storage account update --name <name> --resource-group <rg> \
  --min-tls-version TLS1_2 --allow-blob-public-access false --https-only true
```

### Azure reference
- <WAF best-practice link>
- <Microsoft Learn documentation link>

### Validation
- [ ] Change implemented in Terraform and applied
- [ ] Azure Policy compliance passes (if applicable)
- [ ] Microsoft Defender for Cloud recommendation resolved (if applicable)

**Well-Architected Recommendation**: <WAF checklist item this maps to>
````

### Step 7: Create EPIC tracking issue

Label with `well-architected` and `epic`.

Title: `[EPIC] Azure Well-Architected Review - X findings across 5 pillars`

Body: an executive summary with a pillar breakdown table (finding counts by pillar and risk level), a Mermaid architecture diagram, a prioritized checklist linking all individual issues (High to Medium to Low), and success criteria:

- All High-risk findings resolved
- Medium findings have accepted mitigation plans
- No regression in existing Azure Monitor alerts or Azure Policy compliance

## Error handling

| Situation | Action |
|---|---|
| No IaC files found | Limit the review to live resource discovery via `az resource list` and note the gap |
| Insufficient Azure permissions | List the required read-only roles (Reader, Security Reader) |
| GitHub creation failure | Output all findings as formatted markdown to the console |

## Output template

When issue creation is skipped (or as the console summary), deliver the findings as a table grouped by pillar:

```markdown
## Well-Architected Review — <workload>

| Pillar | Finding | Risk | Remediation |
|---|---|---|---|
| Security | Storage allows public blob access | High | Set allow_nested_items_to_be_public = false |
| Reliability | App Service runs a single instance | Medium | Enable autoscale, minimum 2 instances |
| Cost | Log Analytics has no data cap | Low | Set a daily cap and retention policy |

Totals: High 1, Medium 1, Low 1 across 5 pillars.
Verdict: address High-risk security finding before the next release.
```

## Quality gate

- [ ] All five WAF pillars reviewed against both IaC and live infrastructure.
- [ ] Every finding classified by risk level and mapped to a pillar.
- [ ] Each finding has an actionable Terraform remediation (Bicep/ARM only as illustration).
- [ ] Drift between IaC and deployed resources recorded as Operational Excellence findings.
- [ ] GitHub issues created only after explicit user approval; otherwise findings printed to the console.
- [ ] A Mermaid architecture diagram and Microsoft Learn references are included.
