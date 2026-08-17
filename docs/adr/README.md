# Architecture Decision Records (ADRs)

> **Path:** [Team Kit](../../README.md) › [Docs](../README.md) › **ADRs**

**Index of the team's architecture decision records** — one decision per file, numbered sequentially.

| Field | Value |
|---|---|
| **Target audience** | The entire team, especially the Software Architect and Technical Lead |
| **When to create** | For every decision that is difficult to revisit later (more than one hour to reverse) |
| **Expected outcome** | Auditable history of decisions made under time pressure |

---

## Why write ADRs

Decisions made under time pressure are forgotten. Your future self will rediscover the same options and lose hours. An ADR takes five minutes to write now and saves 50 minutes later.

## When to write an ADR

Write one when:

- A decision will be difficult to revisit later (more than one hour to reverse).
- Two or more team members would naturally make different choices.
- A decision affects more than one bounded context or persona.

Do not write an ADR for variable names, formatting configuration, or minor library versions.

---

## Index

| ADR | Title | Status | Date |
|---|---|---|---|
| 0000 | [Template](0000-template.md) | template | 2026-04-29 |

> [!NOTE]
> Add new ADRs to this table as they are created, first with status `proposed` and then `accepted` after team agreement.

---

## How to add an ADR

- [ ] **Open an issue** using the [ADR issue template](../../.github/ISSUE_TEMPLATE/adr.yml).
- [ ] **Copy the template** — `0000-template.md` → `NNNN-your-title.md` (next sequential number).
- [ ] **Complete every section** — context, decision, alternatives, consequences, and status.
- [ ] **Open a pull request** — require at least one review from an architecture persona.
- [ ] **Merge with status `accepted`** — update this index.

---

### Continue reading

| Previous | Next |
|---|---|
| [Cross-cutting Documentation](../README.md)<br/><sub>Glossary, SDLC flow, persona-agent matrix, and runbook.</sub> | [Stage 2 — Modern Specification](../../02-spec-moderna/GUIDE.md)<br/><sub>14:00–15:00 — Write EARS, ADRs, and C4 diagrams.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
