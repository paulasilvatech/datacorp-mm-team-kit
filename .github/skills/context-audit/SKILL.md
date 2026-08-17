---
name: "context-audit"
description: "Use when a new engineer joins the team, during onboarding to an unfamiliar codebase, or when auditing whether the team shares a common understanding. Triggers include \"onboard\", \"context\", \"knowledge gap\", \"bus factor\", and \"team understanding\"."
---
# Context audit

## When to invoke

- "A new developer starts Monday. What do they need to know in week 1?"
- "Audit whether the team truly understands why we chose X."
- "Our bus factor is 1 for the billing module. Fix it."

## Objective

Measure the team's shared understanding, expose knowledge concentrated in one person, and create a week 1 ramp-up path for new team members.

## Audit questions (ask each team member privately)

1. Can you draw the system architecture on a whiteboard in 5 minutes?
2. What are the 3 most important invariants this system must preserve?
3. Where is the riskiest code? Who understands it best?
4. What would you never change without senior review? Why?
5. Which parts do you personally avoid changing? Why?

If the answers differ significantly, the team has a context gap.

## Output template

### 1. Shared architecture map (1 page)

- Mermaid diagram of services and data flow
- List of external integrations and their owners
- List of invariants (business rules that must remain intact)

### 2. Risk heat map

```
| Module | Criticality | Bus factor | Last refactor | Owner |
|----------|-------------|------------|----------------|-------|
| billing | high | 1 (Alex) | 2y ago | Alex |
| auth | high | 3 | 6mo ago | team |
```

Any row with a bus factor of 1 for a high-criticality module requires a P0 action.

### 3. Week 1 runbook for a new team member

- Day 1: read these 5 ADRs and run the stack locally.
- Day 2: pair with Alex on billing and submit a documentation improvement.
- Day 3: shadow the on-call rotation.
- Day 4: take a "starter" ticket with paired review.
- Day 5: hold a retrospective with the tech lead. What is still unclear?

## Antipatterns

- "Onboarding is just our READMEs." (Insufficient because READMEs omit tacit knowledge.)
- A week 1 plan with no coding or system operation.
- No mention of invariants or failure modes.
- Knowledge held only by senior engineers, with no documentation trail.

## Quality gate

- [ ] The shared architecture map, risk heat map, and week 1 runbook all exist.
- [ ] Every high-criticality module with a bus factor of 1 has a P0 remediation action.
- [ ] The runbook includes coding and system-operation tasks, not only reading.
- [ ] A new engineer can deliver a low-risk change by the end of week 1 with paired review.
