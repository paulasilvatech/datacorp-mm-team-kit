---
name: "azure-resource-health-diagnose"
description: "Use when the user reports that a deployed Azure resource is failing, degraded, throttling, or unhealthy, or asks to troubleshoot or investigate one. Diagnoses a specific resource from its logs, metrics, and telemetry, then produces a prioritized remediation plan. Requires the resource to be deployed and emitting telemetry. Triggers include \"resource is unhealthy\", \"troubleshoot Azure\", \"why is this failing\", \"diagnose throttling\", and \"investigate degraded resource\"."
---
# Azure Resource Health and Issue Diagnosis

This workflow analyzes a specific Azure resource to assess its health, diagnose issues using logs and telemetry, and develop a remediation plan for any problems discovered.

> [!NOTE]
> This skill depends on the **Azure MCP server** (or the `az` CLI) and requires the target resource to be deployed and emitting telemetry. Prefer Azure MCP tools (`azmcp-*`) over direct Azure CLI when both are available.

## When to invoke

- "Our App Service is returning 500s — diagnose it."
- "Investigate why this Cosmos DB is throttling."
- "The storage account looks degraded; find the root cause."
- "Troubleshoot this VM and give me a remediation plan."

## Prerequisites

- Azure MCP server configured and authenticated.
- Target Azure resource identified (name, and optionally resource group/subscription).
- The resource must be deployed and running so it generates logs and telemetry.

## Workflow steps

### Step 1: Get Azure best practices

Retrieve diagnostic and troubleshooting best practices with the Azure best-practices tool. Focus on health monitoring, log analysis, and issue-resolution patterns, and use them to inform the diagnostic approach and remediation recommendations.

### Step 2: Resource discovery and identification

1. **Locate the resource**:
   - If only a name is provided, search across subscriptions (`azmcp-subscription-list`, or `az resource list --name <resource-name>`).
   - If multiple matches are found, prompt the user to specify subscription/resource group.
   - Gather resource type and status, location, tags, configuration, and dependencies.
2. **Detect the resource type** to choose the right diagnostics:

| Resource type | Primary diagnostics |
|---|---|
| Web Apps / Function Apps | Application logs, performance metrics, dependency tracking |
| Virtual Machines | System logs, performance counters, boot diagnostics |
| Cosmos DB | Request metrics, throttling, partition statistics |
| Storage Accounts | Access logs, performance metrics, availability |
| SQL Database | Query performance, connection logs, resource utilization |
| Application Insights | Application telemetry, exceptions, dependencies |
| Key Vault | Access logs, certificate status, secret usage |
| Service Bus | Message metrics, dead-letter queues, throughput |

### Step 3: Health status assessment

1. **Basic health check**: provisioning state and operational status, service availability, recent deployment or configuration changes, and current utilization (CPU, memory, storage).
2. **Service-specific indicators**:

| Resource type | Health indicators |
|---|---|
| Web Apps | HTTP response codes, response times, uptime |
| Databases | Connection success rate, query performance, deadlocks |
| Storage | Availability percentage, request success rate, latency |
| VMs | Boot diagnostics, guest OS metrics, network connectivity |
| Functions | Execution success rate, duration, error frequency |

### Step 4: Log and telemetry analysis

1. **Find monitoring sources**: identify Log Analytics workspaces (`azmcp-monitor-workspace-list`), associated Application Insights instances, and relevant log tables (`azmcp-monitor-table-list`).
2. **Execute diagnostic queries** with `azmcp-monitor-log-query`, choosing KQL based on the resource type.

General error analysis:

```kql
union isfuzzy=true
    AzureDiagnostics,
    AppServiceHTTPLogs,
    AppServiceAppLogs,
    AzureActivity
| where TimeGenerated > ago(24h)
| where Level == "Error" or ResultType != "Success"
| summarize ErrorCount=count() by Resource, ResultType, bin(TimeGenerated, 1h)
| order by TimeGenerated desc
```

Performance analysis:

```kql
Perf
| where TimeGenerated > ago(7d)
| where ObjectName == "Processor" and CounterName == "% Processor Time"
| summarize avg(CounterValue) by Computer, bin(TimeGenerated, 1h)
| where avg_CounterValue > 80
```

Application-specific queries:

```kql
requests
| where timestamp > ago(24h)
| where success == false
| summarize FailureCount=count() by resultCode, bin(timestamp, 1h)
| order by timestamp desc
```

3. **Recognize patterns**: recurring errors or anomalies, correlation with deployment/configuration changes, performance degradation trends, and dependency or external-service failures.

### Step 5: Issue classification and root-cause analysis

1. **Classify severity**:

| Severity | Meaning |
|---|---|
| Critical | Service unavailable, data loss, security breach |
| High | Performance degradation, intermittent failures, high error rate |
| Medium | Warnings, suboptimal configuration, minor performance issues |
| Low | Informational alerts, optimization opportunities |

2. **Determine the root-cause category**: configuration issue, resource constraint (CPU/memory/disk/throttling), network issue, application issue (bug, memory leak, inefficient query), external dependency, or security issue (auth failure, certificate expiration).
3. **Assess impact**: affected users/systems, data integrity and security implications, and recovery-time priorities.

### Step 6: Generate a remediation plan

1. **Immediate actions** (Critical): emergency fixes to restore availability, temporary workarounds, escalation procedures.
2. **Short-term fixes** (High/Medium): configuration adjustments, resource scaling, patches, monitoring improvements.
3. **Long-term improvements**: architectural changes for resilience, preventive measures, documentation.
4. **Implementation steps**: prioritized items with specific Azure CLI commands, testing/validation, rollback plans, and post-change monitoring.

### Step 7: User confirmation and report generation

Present a summary and gate remediation on user approval:

```text
Azure Resource Health Assessment

Resource Overview:
- Resource: [Name] ([Type])
- Status: [Healthy/Warning/Critical]
- Location: [Region]
- Last Analyzed: [Timestamp]

Issues Identified:
- Critical: X issues requiring immediate attention
- High: Y issues affecting performance/reliability
- Medium: Z issues for optimization
- Low: N informational items

Top Issues:
1. [Issue Type]: [Description] - Impact: [High/Medium/Low]

Remediation Plan:
- Immediate Actions: X items
- Short-term Fixes: Y items
- Long-term Improvements: Z items
- Estimated Resolution Time: [Timeline]

Proceed with detailed remediation plan? (y/n)
```

On approval, generate the detailed report using the Output template below.

## Error handling

| Situation | Action |
|---|---|
| Resource not found | Ask for the exact name/location |
| Authentication issues | Guide the user through Azure authentication setup |
| Insufficient permissions | List the required read-only RBAC roles |
| No logs available | Suggest enabling diagnostic settings and waiting for data |
| Query timeouts | Break the analysis into smaller time windows |
| Service-specific gaps | Provide a generic health assessment and note the limitations |

## Output template

The skill writes a health report. Below its H1 title (`Azure Resource Health Report: <resource>`) it contains:

````markdown
## Executive Summary

<overview of health status and key findings>

## Health Metrics

- Availability: X% over last 24h
- Error Rate: X% over last 24h
- Resource Utilization: CPU/Memory/Storage percentages

## Issues Identified

### Critical Issues

- <Issue>: root cause, business impact, immediate action

### High Priority Issues

- <Issue>: root cause, reliability impact, recommended fix

## Remediation Plan

### Phase 1: Immediate Actions (0-2 hours)

```bash
<Azure CLI commands to restore service, with explanations>
```

### Phase 2: Short-term Fixes (2-24 hours)

```bash
<Azure CLI commands for reliability improvements>
```

### Phase 3: Long-term Improvements (1-4 weeks)

```bash
<Azure CLI and configuration changes>
```

## Validation Steps

- [ ] Verify issue resolution through logs
- [ ] Confirm performance improvements
- [ ] Test application functionality
- [ ] Update monitoring and alerting
````

## Quality gate

- [ ] Resource health status accurately assessed from logs, metrics, and telemetry.
- [ ] All significant issues identified and classified by severity.
- [ ] Root-cause analysis completed for every Critical and High finding.
- [ ] Remediation plan provides specific Azure CLI steps with validation and rollback.
- [ ] Issues prioritized by business impact, with monitoring and prevention recommendations.
- [ ] Detailed remediation actions taken only after explicit user confirmation.
