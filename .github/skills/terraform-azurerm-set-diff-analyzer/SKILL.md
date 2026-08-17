---
name: "terraform-azurerm-set-diff-analyzer"
description: "Use when a Terraform plan for AzureRM resources shows many changes but you only added or removed one element, to separate false-positive Set-ordering diffs from real changes. Covers Application Gateway, Load Balancer, Firewall, Front Door, and NSG. Triggers include \"terraform plan noise\", \"Set-type diff\", \"all elements changed\", \"spurious diff\", and \"filter false positives in CI\"."
---
# Terraform AzureRM Set diff analyzer

Identify **false-positive diffs** in Terraform plans caused by the AzureRM provider's Set-type attributes, and distinguish them from real changes. This kit's IaC is Terraform (`azurerm ~> 3.x`), so this skill applies directly to the `infra/` tree the team builds in Stage 3.

## When to invoke

- "`terraform plan` shows dozens of changes but I only added one NSG rule."
- "My Application Gateway plan says every routing rule changed — is that real?"
- "How do I stop Set-ordering noise from blocking my plan review in CI?"
- "Which of these Load Balancer diffs are actually going to modify the resource?"

## Background

Terraform's Set type compares elements by position rather than by a stable key, so adding or removing one element can make every element render as "changed". This is a general Terraform behavior, but it is especially visible on AzureRM resources that rely heavily on Set-type attributes — Application Gateway, Load Balancer, Firewall, Front Door, and NSG. These false-positive diffs do not change the deployed resource, but they bury the real changes and make plan review error-prone.

## Prerequisites

- Python 3.8+ (standard library only; no third-party packages).

If Python is unavailable, install it via your package manager (`brew install python3`, `apt install python3`) or from [python.org](https://www.python.org/downloads/).

## Basic usage

```bash
terraform plan -out=plan.tfplan                 # 1. capture the plan
terraform show -json plan.tfplan > plan.json    # 2. export it as JSON
python scripts/analyze_plan.py plan.json        # 3. classify the diffs
```

The analyzer reads the JSON plan, inspects Set-type attributes on supported AzureRM resources, and reports which resources show only order-only (false-positive) changes versus real additions, removals, or modifications.

## Interpreting results

| Signal | Meaning | Action |
|---|---|---|
| Order-only change on a Set attribute | False positive — no real change | Safe to ignore; note it in the PR |
| Element added or removed | Real change | Review before apply |
| Attribute value modified | Real change | Review before apply |
| Resource not in the supported list | Not analyzed | Inspect manually |

The supported resources and their Set-type attributes are listed in [references/azurerm_set_attributes.md](references/azurerm_set_attributes.md). Full CLI options, output formats, exit codes, and CI/CD examples are in [scripts/README.md](scripts/README.md).

## Troubleshooting

| Issue | Solution |
|---|---|
| `python: command not found` | Use `python3`, or install Python 3.8+ |
| `ModuleNotFoundError` | The script uses only the standard library; confirm Python 3.8+ is active |
| A resource is not classified | Confirm it appears in `references/azurerm_set_attributes.md`; otherwise review manually |

## Output template

Report the classification as a table plus a one-line verdict:

```markdown
## Set-diff analysis — plan.json

| Resource | Set attribute | Verdict | Real changes |
|---|---|---|---|
| azurerm_application_gateway.main | request_routing_rule | False positive (order-only) | 0 |
| azurerm_network_security_group.web | security_rule | Real change | +1 / -0 |

Total: 2 resources analyzed, 1 false positive, 1 with real changes.
Verdict: review the NSG rule change before apply; the gateway diff is safe to ignore.
```

## Quality gate

- [ ] A JSON plan was produced with `terraform show -json` before analysis.
- [ ] `scripts/analyze_plan.py` ran against the JSON plan under Python 3.8+.
- [ ] Every flagged resource is classified as false positive (order-only) or real change.
- [ ] Real changes are reviewed before `terraform apply`; false positives are documented as safe to ignore.
- [ ] Any resource outside the supported list was reviewed manually.
