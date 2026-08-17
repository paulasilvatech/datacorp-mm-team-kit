---
name: "azure-resource-health-diagnose"
description: "Diagnose an Azure resource's health from logs and telemetry and produce a remediation plan, deferring the workflow to the azure-resource-health-diagnose skill."
argument-hint: "resource=<name> rg=<resource-group>"
agent: "agent"
tools: ["read", "search", "execute"]
---
# /azure-resource-health-diagnose

## What This Does

Assesses the health of a specific Azure resource, analyzes its logs and telemetry, classifies issues by severity, and produces a prioritized remediation plan. The full workflow lives in the [`azure-resource-health-diagnose`](../skills/azure-resource-health-diagnose/SKILL.md) skill; this prompt is a thin wrapper that defers to it.

## When to Use

During Stage 4 (Evolution), when a deployed Azure resource behaves unexpectedly and the team needs a structured diagnosis before acting.

## Steps

1. Provide the resource name (and, if known, its resource group or subscription).
2. Follow the [`azure-resource-health-diagnose`](../skills/azure-resource-health-diagnose/SKILL.md) skill end to end.
3. Honor the kit constraints below.

## Kit Constraints

- The modern SIFAP 2.0 backend targets **Azure Database for PostgreSQL 16** and containerized Spring Boot services — focus the diagnosis on those resource types first.
- Service-to-service authentication uses **Managed Identity**; flag any resource still relying on shared keys or connection strings.
- Confirm any remediation change against the Terraform under `infra/` — resources are managed as code, not by hand.
