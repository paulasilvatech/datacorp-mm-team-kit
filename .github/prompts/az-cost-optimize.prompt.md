---
name: "az-cost-optimize"
description: "Analyze Azure resources and Terraform IaC for cost savings and open tracking GitHub issues, deferring the workflow to the az-cost-optimize skill."
argument-hint: "rg=<resource-group> repo=<owner/name>"
agent: "agent"
tools: ["read", "search", "execute"]
---
# /az-cost-optimize

## What This Does

Analyzes deployed Azure resources and their Infrastructure-as-Code to produce evidence-based cost-optimization recommendations, then opens one GitHub issue per opportunity plus a coordinating EPIC. The full workflow lives in the [`az-cost-optimize`](../skills/az-cost-optimize/SKILL.md) skill; this prompt is a thin wrapper that defers to it and adds this kit's guardrails.

## When to Use

During Stage 4 (Evolution), once the team has provisioned Azure resources and wants to track cost reductions as GitHub issues.

## Steps

1. Provide the target resource group and the GitHub repository.
2. Follow the [`az-cost-optimize`](../skills/az-cost-optimize/SKILL.md) skill end to end.
3. Honor the kit constraints below.

## Kit Constraints

- IaC in this kit is **Terraform only** (`*.tf`, Azure provider `~> 3.x`). The skill's Bicep and ARM references (`*.bicep`, `*template*.json`) are **out of scope** — the source of truth is the Terraform under `infra/`.
- The modern `infra/` is created by the team in Stage 3/4. If no Terraform exists yet, report that and stop rather than inventing resources.
- Track work as GitHub issues (GitHub is the kit's source of truth); prefer the `gh` CLI.
- Every recommendation must be evidence-based (validated SKU/tier and pricing) before an issue is opened.
