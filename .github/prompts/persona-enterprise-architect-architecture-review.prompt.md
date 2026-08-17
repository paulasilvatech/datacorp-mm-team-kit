---
name: "architecture-review"
agent: "enterprise-architect"
description: "Review a plan.md against the Well-Architected pillars"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /architecture-review

## Task

Review `specs/<NNN>-<feature>/plan.md` (or a proposed architectural change) against the Microsoft Azure Well-Architected pillars and produce a prioritized list of findings.

## Steps

1. Load `plan.md` and any relevant ADRs.
2. Score the design against each pillar using concrete evidence:

- Reliability: SLO, redundancy, failure modes, retry policies
- Security: identity, network, data, secrets, threat model
- Cost: right-sizing, reserved capacity, idle resources
- Operational Excellence: IaC, observability, runbooks
- Performance Efficiency: scaling, caching, data access patterns

3. Classify each finding as: Critical (blocks go-live), Major (fix before GA), or Minor (backlog).
4. Reference the specific architectural decision or diagram that triggers the finding.
5. Propose a concrete remediation for each finding, with an effort estimate (S/M/L).

## Output

- Scorecard table: `Pillar | Score (1-5) | Top Finding | Remediation`
- Prioritized list of findings grouped by severity
- Three alternative options for the most critical finding

## Quality Gate

- [ ] All pillars reviewed; none skipped
- [ ] Every finding cites a specific artifact (diagram, ADR, paragraph)
- [ ] Remediations are specific, not generic best-practice statements
- [ ] At least one cost-optimization finding identified (or marked as "already optimal")
