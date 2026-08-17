# Architecture Decision Records (ADR)

> **Path:** [Team Kit](../README.md) › [Concepts](00-README.md) › **Architecture Decision Records**

**An Architecture Decision Record (ADR) is a short document that records a significant architecture decision: the context that prompted it, the decision made, the alternatives considered, and the consequences. It ensures that today's reasoning remains understandable to anyone who works on the system in the future.**

![Concept 06](https://img.shields.io/badge/Concept-06-171717?style=flat-square) ![Stage 2](https://img.shields.io/badge/Stage-2%20%C2%B7%20Specification-737373?style=flat-square) ![Duration 20 min](https://img.shields.io/badge/Duration-20%20min-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Software Architect, Enterprise Architect, Technical Lead, Product Owner |
| **Prerequisites** | [Spec-Driven Development](01-spec-driven-development.md) |
| **Estimated time** | 20 minutes |
| **Stage** | Stage 2 — Specification |
| **Expected outcome** | Know when and how to write a valid ADR for SIFAP 2.0 |

---

## Concept

An architecture decision is any technical choice that affects the system's structure, contracts, or long-term operation. Examples include selecting an architecture pattern, defining how to represent Adabas multiple-value fields in the relational model, or choosing an authentication strategy.

Undocumented technical decisions become "tribal knowledge" that depends on who was in the room. When this knowledge is not recorded, future teams make contradictory decisions, introduce redundancy, or discard work because they lack context.

An ADR formalizes the reasoning in a Markdown file stored in the repository alongside the code it governs.

---

## Why it matters in SIFAP

SIFAP is 29 years old. SIFAP 2.0 must last at least as long. Decisions made during the workshop—such as how to represent Adabas periodic groups (PE), structure bounded contexts, or version the API—must be recorded so that future maintainers understand why the system was built this way.

Without ADRs, maintenance costs increase every time the team changes.

---

## ADR anatomy

```markdown
# ADR-NNN: Decision title

**Status:** Proposed | Accepted | Rejected | Superseded by ADR-NNN
**Date:** YYYY-MM-DD
**Authors:** [names]

## Context

Describe the situation requiring a decision: evidence, constraints,
risks, and what happens if no decision is made now.

## Decision

One sentence. "We chose X using Y."

## Alternatives considered

- **Alternative A:** <description and reason to accept or reject>
- **Alternative B:** <description and reason to accept or reject>

## Consequences

- Positive: <expected benefit>
- Negative: <accepted cost or risk>
- Note: <condition that would make this decision obsolete>
```

---

## ADR lifecycle

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
stateDiagram-v2
    [*] --> Proposed : team identifies a required decision
    Proposed --> Accepted : consensus recorded
    Proposed --> Rejected : alternative selected
    Accepted --> Superseded : new decision replaces this one
    Superseded --> [*]
    Rejected --> [*]
```

> [!IMPORTANT]
> Never delete an ADR. When a decision is replaced, update its status to `Superseded by ADR-NNN` and create a new ADR explaining the new decision. The reasoning history is valuable.

---

## When to write an ADR

Use the three-question test:

1. Does the decision **affect multiple files, modules, or people**?
2. Would **reversing** the decision cost more than one day of work?
3. Would someone on the team ask, "Why did we do it this way?" six months from now?

If two or more answers are yes, write an ADR.

### Examples

| Decision | ADR required | Rationale |
|---|---|---|
| Use Spring Boot 3.3 instead of Quarkus | Yes | Affects every module and is irreversible within the workshop timeframe |
| Represent Adabas MU fields as a child table | Yes | Affects the data model and JPA mappings in multiple modules |
| Adopt a Modular Monolith instead of microservices | Yes | Structural decision with project-wide impact |
| Version the API with the `/api/v1` prefix | Yes | Affects every API contract |
| Replace `final` with `var` in a local variable | No | Local, reversible, and has no external impact |
| Add Lombok as a dependency | Yes | Affects every module that adopts it |
| Use `@Autowired` versus constructor injection | Yes, if it becomes the team standard | Affects every Spring component |

---

## SIFAP example

The following is a realistic ADR that the team could write in Stage 2 for a data-mapping decision:

```markdown
# ADR-003: Representing Adabas Periodic Groups (PE) in the relational model

**Status:** Accepted
**Date:** 2026-08-12
**Authors:** Software Architect, DBA

## Context

The HISTORICO_PAGAMENTOS.ddm DDM defines a periodic group (PE) with up to
12 monthly occurrences within each beneficiary record.
The PostgreSQL 16 relational model does not support periodic groups natively.
We must decide how to preserve the occurrences and their order in the modern model.

## Decision

Map each PE occurrence to a row in the historico_pagamentos table,
with a foreign key to beneficiarios and a competencia (DATE) column
to preserve chronological order.

## Alternatives considered

- **JSONB column:** Store the 12 occurrences as a JSON array.
  Rejected: makes querying and indexing by period difficult and violates the principle
  of not reproducing legacy complexity in the new model.
- **Child table (selected):** Each occurrence becomes a row with an FK.
  Accepted: simple queries, indexable, and compatible with JPA.

## Consequences

- Positive: efficient queries by period; natural JPA mapping.
- Negative: beneficiary records with complete histories generate 12 rows per
  beneficiary—a higher row count than in Adabas.
- Note: if the volume exceeds 10 million rows, evaluate partitioning
  by year in a future ADR.
```

---

## Completed ADR checklist

- [ ] **Sequential number** in the `ADR-NNN` format.
- [ ] **Declared status:** Proposed, Accepted, Rejected, or Superseded.
- [ ] **Date and authors** recorded.
- [ ] **Context** explains why the decision is needed now, not only what was decided.
- [ ] **Decision in one sentence**—objective and unambiguous.
- [ ] **At least two alternatives** listed with reasons for rejection.
- [ ] **Consequences** include negatives as well as positives.
- [ ] **Fits on one page**—if it does not, it probably contains two separate decisions.
- [ ] **The Product Owner can read and understand** the context and decision without technical expertise.

---

## Common mistakes and how to avoid them

| Symptom | Cause | Correction |
|---|---|---|
| ADR does not list alternatives | Time pressure | List at least two, even briefly. Without alternatives, the reader cannot understand the trade-off. |
| ADR describes only benefits | Confirmation bias | Every decision has a cost. If there are no negative consequences, the reasoning is incomplete. |
| Decision without context | Started with the decision instead of the problem | Write the context first. "Why now?" matters more than "what?" |
| ADR is five pages long | Multiple decisions are mixed together | Split it. One ADR = one decision. |
| ADR deleted when superseded | Manual file management | Mark it as `Superseded by ADR-NNN`. Never delete it. |

---

## Useful prompts in Copilot Chat

```text
# Structure an ADR
"@architect, record an ADR about <open decision>.
Use the alternatives and evidence provided by the team.
DO NOT choose for the team—present the trade-offs."

# Challenge a decision before accepting it
"@architect, read ADR-002 and play devil's advocate.
What are the three strongest arguments for REJECTING this decision?"

# Resolve a team deadlock
/speckit.clarify
"There is no consensus between a Modular Monolith and microservices.
List objective pros and cons for each in the SIFAP context."
```

---

## References

- [Blank ADR template](../02-spec-moderna/ADR-TEMPLATE.md)
- [Stage 2 Guide](../02-spec-moderna/GUIDE.md)
- [adr.github.io — official pattern](https://adr.github.io)

---

### Continue reading

| Previous | Next |
|---|---|
| [EARS Notation](05-notacao-ears.md)<br/><sub>How to write unambiguous requirements.</sub> | [Personas (Overview)](../05-personas/OVERVIEW.md)<br/><sub>Choose your two workshop roles.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
