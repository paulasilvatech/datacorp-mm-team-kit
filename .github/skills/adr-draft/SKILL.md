---
name: "adr-draft"
description: "Use when drafting Architecture Decision Records, evaluating alternatives, or documenting technical trade-offs. Triggers include \"ADR\", \"architecture decision\", \"trade-off\", \"pick between\", and \"why did we choose\"."
---
# ADR draft

## When to invoke

- "Draft an ADR for choosing PostgreSQL over MongoDB."
- "Document our decision to adopt event-driven architecture."
- "Revisit ADR-007 - we need to supersede it."

## When to write an ADR

Write an ADR when a decision:

- Is difficult or expensive to reverse.
- Affects more than one team.
- Restricts future choices (technology lock-in).
- Will probably be questioned in 6 months.

Do not write an ADR for a local refactor or a reversible configuration change.

## Writing tips

- Write in the present tense ("We use X").
- Include at least 2 rejected alternatives.
- Name consequences that you know will be painful. Your future self will thank you.
- Supersede, never delete. The history provides value.

## Antipatterns

- ADRs written after the fact to justify a decision already made.
- One ADR that groups 5 unrelated decisions.
- No alternatives section, which signals that no trade-off analysis occurred.
- Status stuck at "proposed" for months.

## Output template

Save the ADR to `docs/adr/NNNN-<slug>.md`. The repo's canonical template is [`docs/adr/0000-template.md`](../../../docs/adr/0000-template.md); the condensed shape is:

```markdown
# ADR-NNN: <Decision title in imperative>

**Status**: proposed | accepted | superseded by ADR-NNN | deprecated
**Date**: YYYY-MM-DD
**Deciders**: <names>
**Context tags**: security, performance, cost

## Context
2-4 paragraphs. What is the forcing function? What constraints apply?

## Decision
One paragraph. "We will <decision>."

## Alternatives considered
- **Option A**: <summary>. Pros: ... Cons: ...
- **Option B**: <summary>. Pros: ... Cons: ...
- **Option C (chosen)**: <summary>. Pros: ... Cons: ...

## Consequences
### Positive
- ...
### Negative
- ...
### Neutral
- ...

## Follow-ups
- [ ] Update REQ-NNN
- [ ] Migrate <system>
- [ ] Revisit in Q<N>

## References
- Source 1
- Source 2
```

## Quality gate

- [ ] The ADR has Context, Decision, Alternatives considered, and Consequences sections.
- [ ] At least two rejected alternatives are documented with their trade-offs.
- [ ] Status is set (proposed, accepted, superseded, or deprecated), not left blank.
- [ ] The file is saved as `docs/adr/NNNN-<slug>.md` and linked from the REQ-IDs it affects.
