<!-- markdownlint-disable MD013 MD033 MD041 -->

# ADR-XXX: Decision Title

> **Path:** [Team Kit](../README.md) › [Stage 2](README.md) › **ADR Template**

> [!NOTE]
> This file is a supporting template. Copy it to `ADR-NNN-title.md` and fill it in. Do not edit the original.
> Use this template when an architectural decision blocks the feature's `plan.md`.

![Stage 2](https://img.shields.io/badge/Stage-2%20%C2%B7%20Specification-171717?style=flat-square) ![Type ADR Template](https://img.shields.io/badge/Type-ADR%20Template-737373?style=flat-square)

| Field | Value |
|---|---|
| **Date** | `YYYY-MM-DD` |
| **Status** | Proposed / Accepted / Rejected / Superseded by ADR-YYY |
| **Decision-makers** | Names of the team members involved |
| **Related feature** | `specs/<NNN>-<feature>/` |

---

## Concept: ADR (Architecture Decision Record)

An ADR is the formal record of a significant architectural decision. It documents the context that led to the decision, the alternatives assessed, the selected option, and the expected consequences.

**Why it matters:** technical decisions made verbally during the workshop get lost. A two-page ADR ensures that any PR reviewer understands why the system was designed in a particular way, without asking the person who made the decision at 14:30 on a busy day.

**Golden rule:** always list the "path not taken." Without it, the ADR becomes an implementation description rather than a decision record.

**When to create one:** only when the decision blocks `plan.md`. If the decision fits in a commit comment, it does not need an ADR.

---

## Context

> Describe the problem or need that motivated this decision.
> Include relevant constraints, requirements, and information.
> Be specific: "we need a database" is not enough.

<!-- fill in -->

---

## Options considered

### Option 1: <!-- name -->

| Aspect | Assessment |
|---|---|
| **Description** | How it would work |
| **Advantages** | List them |
| **Disadvantages** | List them |

### Option 2: <!-- name -->

| Aspect | Assessment |
|---|---|
| **Description** | How it would work |
| **Advantages** | List them |
| **Disadvantages** | List them |

### Option 3: <!-- name, optional -->

| Aspect | Assessment |
|---|---|
| **Description** | How it would work |
| **Advantages** | List them |
| **Disadvantages** | List them |

---

## Decision

**We decided to** <!-- selected action or choice -->.

---

## Rationale

> Explain why this option was selected over the others.
> Connect it to requirements, constraints, and context.

<!-- fill in -->

---

## Consequences

### Positive

- <!-- positive consequence 1 -->

### Negative

- <!-- negative consequence 1, and how to mitigate it -->

### Risks

- <!-- identified risk and contingency plan -->

---

## References

- <!-- relevant link or document -->
- Related EARS requirement: `REQ-XXX`

<details>
<summary><strong>Completed example — ADR-001: database for SIFAP 2.0</strong></summary>

| Field | Value |
|---|---|
| **Date** | 2026-05-10 |
| **Status** | Accepted |
| **Decision-makers** | Pair 2 (Enterprise Architect + Software Architect) |
| **Related feature** | `specs/001-benefit-payment/` |

**Context:** The legacy SIFAP (Payment Inspection and Administration System) uses Adabas, a navigational database. The modernization needs a relational database compatible with JPA/Hibernate and supported by the operations team.

**Options:**

- PostgreSQL 16: open source, JSONB support, and Testcontainers available.
- MySQL 8: broad support, but less adoption in Brazilian government environments.

**Decision:** PostgreSQL 16.

**Rationale:** Established adoption in public-sector systems, native support for advanced types (JSONB for variable DDM fields), and Testcontainers integration without an additional license.

**Positive consequences:** Testcontainers simplifies integration testing. **Negative consequences:** The DBA team needs familiarity with PostgreSQL.

</details>

---

### Continue reading

| Previous | Next |
|---|---|
| [Stage 2 GUIDE](GUIDE.md)<br/><sub>Stage step-by-step instructions.</sub> | [Stage 2 GUIDE](GUIDE.md)<br/><sub>Lead the decision with the team.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
