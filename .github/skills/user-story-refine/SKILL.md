---
name: "user-story-refine"
description: "Use when refining backlog items, splitting epics, or validating INVEST criteria. Triggers include \"refine story\", \"split epic\", \"acceptance criteria\", \"user story\", and \"INVEST\"."
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# User Story Refinement

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

## Antipatterns

- Stories written as tasks ("Add a button").
- Acceptance criteria that describe UI instead of behavior.
- Horizontal splits ("backend story" + "frontend story" for the same feature).
- Missing REQ-ID link.

## Quality gate

Reject any story that fails INVEST or lacks Given/When/Then acceptance criteria.
