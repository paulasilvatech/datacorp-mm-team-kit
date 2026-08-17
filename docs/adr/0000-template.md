<!-- markdownlint-disable MD024 -->

# ADR-NNNN: Short, Decisive Title

> **Path:** [Team Kit](../../README.md) › [Docs](../README.md) › [ADRs](README.md) › **Template**

> [!NOTE]
> This is the ADR template. Copy this file to `NNNN-your-title.md`, replacing `NNNN` with the next sequential number, such as `0007`. Replace each instruction block with the actual decision content.

| Field | Value |
|---|---|
| **Status** | proposed \| accepted \| deprecated \| superseded |
| **Date** | YYYY-MM-DD |
| **Authors** | Persona — Name |
| **Supersedes** | ADR-NNNN \| N/A |

---

## Context

> [!NOTE]
> Describe the problem motivating this decision. Reference the business objective, legacy constraint, or stakeholder need. Be specific. Cite REQ-IDs or programs in `01-arqueologia/legado-sifap/` when relevant.

_Complete this section._

---

## Decision

> [!NOTE]
> State the proposed change in active voice. Use one or two paragraphs. Examples: "We will adopt …", "We will not migrate …".

_Complete this section._

---

## Alternatives considered

> [!NOTE]
> List at least two alternatives. Explain why each was rejected.

| Alternative | Why it was rejected |
|---|---|
| Option A | — |
| Option B | — |

---

## Consequences

> [!NOTE]
> What becomes easier? What becomes harder? Are there new risks?

- **Easier:** —
- **Harder:** —
- **Risks:** —
- **Mitigations:** —

---

## Related

- REQ-IDs: —
- ADRs: —
- Legacy source files: —

---

## References

> [!NOTE]
> Cite documents, RFCs, or research that informed the decision.

---

<details>
<summary><strong>Completed example — ADR-0001: Adopt Flyway for database migrations</strong></summary>

| Field | Value |
|---|---|
| **Status** | accepted |
| **Date** | 2026-05-12 |
| **Authors** | DBA — Carla Souza |
| **Supersedes** | N/A |

### Context

The legacy SIFAP uses Adabas, a non-relational database. The modernization adopts PostgreSQL 16. We need a controlled schema-evolution strategy that tracks changes, supports recovery after errors, and integrates with CI. Program `SIFAP-PAGTO.NSN` (lines 45–78) reveals that the monthly payment cycle requires at least three schema transformations over time.

### Decision

We will adopt Flyway as the migration tool. Each schema change will be represented by a version-controlled `V<N>__description.sql` file in the repository. CI will run `mvn flyway:migrate` on every pull request to `develop`.

### Alternatives considered

| Alternative | Why it was rejected |
|---|---|
| Liquibase | More verbose XML format and a steeper learning curve for the team during this workshop |
| Manual migrations | No traceability, automated rollback, or CI integration |

### Consequences

- Easier: complete traceability of schema changes; CI validates them before merge.
- Harder: migration files are immutable after merge; every correction requires a new file.
- Risks: accidentally editing an applied migration breaks Flyway.
- Mitigations: branch protection on `develop` plus the rule documented in `troubleshooting.md`.

</details>

---

### Continue reading

| Previous | Next |
|---|---|
| [ADRs — Index](README.md)<br/><sub>Index of recorded decisions.</sub> | [Modern Specification](../../02-spec-moderna/GUIDE.md)<br/><sub>Where ADRs are produced.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
