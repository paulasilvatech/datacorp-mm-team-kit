<!-- markdownlint-disable MD013 MD033 MD041 -->

# DBA — Copilot Kit

> **Track:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **DBA**

**Reference kit for the DBA persona in the SIFAP modernization workshop.**

![Persona](https://img.shields.io/badge/Persona-DBA-171717?style=flat-square) ![Pair 4](https://img.shields.io/badge/Par-4%20%C2%B7%20Qualidade-404040?style=flat-square) ![Stage 3](https://img.shields.io/badge/Est%C3%A1gio-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-737373?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Person taking the DBA persona in the workshop |
| **Focus** | Data modeling, Flyway migrations, query optimization, and SQL injection auditing |
| **SDLC phase** | Stage 3 — Implementation (schema + migrations) |
| **Expected outcome** | PostgreSQL 16 schema consistent with JPA entities and test seed data |

Read first: [PERSONA.md](PERSONA.md).

---

## Concept

The DBA (Database Administrator) is responsible for the SIFAP 2.0 data layer. In the legacy modernization, this means translating the 4 Adabas DDMs—with their MU (multiple-value) and PE (periodic) fields—into a normalized PostgreSQL 16 relational schema, writing idempotent Flyway migrations, and protecting data integrity throughout the project.

Why it matters: the data model is the foundation for the Developer's JPA entities and the infrastructure provisioned by DevOps. A fragile schema or irreversible migrations compromise all of Stage 3.

## Persona kit

All active artifacts live in the repository root `.github/` directory. This folder is a reference; edit the files under `.github/` when maintenance is needed.

| File | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | DBA responsibilities, stages, prompts, and rubrics |
| `.github/agents/dba.agent.md` | Agent | Data modeling, migrations, and SQL auditing |
| `.github/prompts/persona-dba-migration.prompt.md` | Prompt | `/migration` |
| `.github/prompts/persona-dba-query-audit.prompt.md` | Prompt | `/query-audit` |
| `.github/instructions/database.instructions.md` | Instructions | Database conventions |

> [!TIP]
> If the facilitator requests a local MCP configuration and this kit has `mcp.json`, copy only that file to `.vscode/mcp.json`.

## Where active artifacts live

- Agents: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Best practices

- [ ] **Measure index impact in both directions.** Indexes accelerate reads and slow writes; measure both before creating one.
- [ ] **Use expand-contract for migrations.** Schema changes must remain compatible for at least two consecutive deployments.
- [ ] **Detect N+1 queries before staging.** They are performance bugs, not optional improvements.
- [ ] **Validate backups by restoring them.** A backup that has never been restored is not reliable.

## SIFAP example

In Stage 1, the DBA reads the `SIFAP-BEN.ddm` DDM and maps beneficiary MU fields to candidate related tables. In Stage 3, they write `V2__create_beneficiarios.sql` with Flyway, define indexes for fields used in `WHERE` clauses by critical monthly-cycle queries, and populate `src/test/resources/seed.sql` for the QA Engineer's integration tests.

## References

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use the Index, Luke — Markus Winand](https://use-the-index-luke.com/)
- [High Performance MySQL / PostgreSQL — Schwartz et al.](https://www.oreilly.com/)
- [Azure Database for PostgreSQL Best Practices](https://learn.microsoft.com/azure/postgresql/)

---

### Continue reading

| Previous | Next |
|---|---|
| [Persona overview](../OVERVIEW.md)<br/><sub>Table of the 10 personas and their pairs.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Complete DBA persona profile.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
