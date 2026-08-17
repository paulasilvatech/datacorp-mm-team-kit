---
name: "user-story-refine"
description: "Use when refining backlog items, splitting epics, or validating INVEST criteria. Triggers include \"refine story\", \"split epic\", \"acceptance criteria\", \"user story\", and \"INVEST\"."
---
# User story refinement

## When to invoke

- "This story is too big. Help me split it."
- "Turn this feature description into user stories with acceptance criteria."
- "Check if these stories are INVEST-compliant."

## Required inputs

- Feature or epic description
- Persona / user type
- Business objective served by the feature
- Any known constraints (regulatory, technical, UX)

## Refinement steps

1. **Confirm the outcome**. Every story must answer: which persona, what outcome, and why it matters.
2. **Apply INVEST** (Independent, Negotiable, Valuable, Estimable, Small, Testable) to every draft.
3. **Split vertically**, never horizontally. Prefer splits by workflow step, data variation, CRUD operation, happy path vs. edge path, business rule, or acceptance criterion.
4. **Write acceptance criteria in Given/When/Then format**. Include a happy path, an edge case, and a failure case.
5. **Trace to a REQ-ID**. Every story links to at least one requirement.

## Splitting patterns

Use these when a story is too large to finish in one iteration:

| Pattern | Split a story by... | Example |
|---|---|---|
| Workflow steps | Each step of a multi-step flow | Submit vs review vs approve |
| Business rule | One rule per story | Standard rate vs exempt rate |
| Data variation | Each input type or format | Domestic vs international address |
| CRUD operation | Create, read, update, and delete separately | Add record before edit record |
| Happy vs edge | Core path first, then edge cases | Valid input before rejected input |
| Research spike | Split off the unknown as a timeboxed spike | Prototype the integration first |

## Antipatterns

- Stories written as tasks ("Add a button").
- Acceptance criteria that describe UI instead of behavior.
- Horizontal splits ("backend story" + "frontend story" for the same feature).
- Missing REQ-ID link.

## Output template

```markdown
### US-NNN: <short title>
**As a** <persona>
**I want** <capability>
**So that** <business outcome>

**Acceptance criteria**
- Given <context>, when <action>, then <result>
- Given <edge>, when <action>, then <result>

**Traces to**: REQ-001, REQ-042
**Effort**: S / M / L
**Dependencies**: US-NNN (if any)
```

## Quality gate

- [ ] The story satisfies every INVEST criterion.
- [ ] Acceptance criteria are written in Given/When/Then and cover happy, edge, and failure paths.
- [ ] The story is split vertically, not by architectural layer.
- [ ] The story traces to at least one REQ-ID, and each linked REQ-ID carries a `source_legacy:` line (enforced by the `legacy-traceability` CI job).
