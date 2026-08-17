<!-- markdownlint-disable MD013 MD033 MD041 -->

# Tech Writer — Copilot Kit

> **Track:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **Tech Writer**

**Reference kit for the Tech Writer persona in the SIFAP modernization workshop.**

![Persona](https://img.shields.io/badge/Persona-Tech%20Writer-171717?style=flat-square) ![Pair 5](https://img.shields.io/badge/Par-5%20%C2%B7%20Opera%C3%A7%C3%B5es-404040?style=flat-square) ![Cross-cutting](https://img.shields.io/badge/Atua%C3%A7%C3%A3o-Transversal-737373?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Person taking the Tech Writer persona in the workshop |
| **Focus** | API documentation, evolving README, `CODEMAP.md`, ADRs, changelog, and drift detection |
| **SDLC phase** | Cross-cutting across all stages; leads Stage 4 — Evolution (Agent report) |
| **Expected outcome** | Complete README, formalized ADRs, consistent glossary, and honest Stage 4 report |

Read first: [PERSONA.md](PERSONA.md).

---

## Concept

The Tech Writer transforms decisions and code into durable project memory. In the SIFAP (Payment Inspection and Administration System) modernization, this persona maintains the glossary of Natural/Adabas legacy terms, formalizes architecture decisions as ADRs (Architecture Decision Records), and ensures that the README reflects the application's real state every hour of the workshop, not only at the end.

Why it matters: without deliberate documentation, ADRs remain empty, the README stays at "TODO: add instructions," and knowledge discovered during the workshop disappears afterward. The Tech Writer makes team learning traceable.

## Persona kit

All active artifacts live in the repository root `.github/` directory. This folder is a reference; edit the files under `.github/` when maintenance is needed.

| File | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | Tech Writer responsibilities, stages, prompts, and rubrics |
| `.github/agents/tech-writer.agent.md` | Agent | API docs, README, `CODEMAP.md`, changelog, and drift detection |
| `.github/prompts/persona-tech-writer-generate-docs.prompt.md` | Prompt | `/generate-docs` |
| `.github/prompts/persona-tech-writer-update-codemap.prompt.md` | Prompt | `/update-codemap` |
| `.github/prompts/persona-tech-writer-doc-drift.prompt.md` | Prompt | `/doc-drift` |

> [!TIP]
> If the facilitator requests a local MCP configuration and this kit has `mcp.json`, copy only that file to `.vscode/mcp.json`.

## Where active artifacts live

- Agents: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Best practices

- [ ] **Treat documentation as a feature.** Deliver, version, and review it with the code, not afterward.
- [ ] **Lead with the answer, then provide context.** Write for someone with 30 seconds.
- [ ] **Use Mermaid for diagrams.** Diagrams as code evolve with the system.
- [ ] **Include drift checks in CI.** Outdated documentation is worse than none.

## SIFAP example

In Stage 1, the Tech Writer documents `MU` (multiple-value field), `PE` (periodic field), and `FDT` (File Definition Table) in the glossary so the entire team uses consistent terminology. In Stage 3, they update `README.md` with the real endpoints created by the Developer (`POST /api/v1/beneficios`, `GET /api/v1/fiscalizacoes/{id}`) and commands for starting the local environment. In Stage 4, they follow the Agent and write `agent-experience-report.md` in real time.

## References

- [Diátaxis Framework](https://diataxis.fr/)
- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Write the Docs](https://www.writethedocs.org/)
- [Mermaid — Diagramming as Code](https://mermaid.js.org/)

---

### Continue reading

| Previous | Next |
|---|---|
| [Persona overview](../OVERVIEW.md)<br/><sub>Table of the 10 personas and their pairs.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Complete Tech Writer persona profile.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
