# Software Architect — Copilot Kit

> **Trail:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **Software Architect**

**Inventory of the Copilot kit for the Software Architect persona.** Lists the active artifacts, where they live under `.github/`, and best practices specific to this role.

| Field | Value |
|---|---|
| **Target audience** | Person acting as Software Architect in the workshop |
| **Pair** | 2 · Architecture (with the Enterprise Architect) |
| **SDLC phase** | Design → Implementation Oversight |
| **Prerequisites** | [PERSONA.md](PERSONA.md) read |
| **Expected outcome** | Kit validated, prompts accessible in Copilot Chat |

> [!IMPORTANT]
> Read [PERSONA.md](PERSONA.md) before continuing. The profile explains the mission, handoff, and evaluation rubrics.

---

## Concept

The Software Architect owns the system's internal structure. This role defines how modules are organized, where bounded contexts (Domain-Driven Design boundaries) begin and end, and which abstractions are exposed. In SIFAP (Payment Inspection and Administration System), this role produces the technical plan the implementation team will follow — `CODEMAP.md`, the package structure, and internal design ADRs.

---

## Persona kit

| **Artifact** | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | Responsibilities, handoff, prompts, and rubric |
| `.github/agents/software-architect.agent.md` | Agent | Software architecture |
| `.github/prompts/persona-software-architect-codemap.prompt.md` | Prompt | `/codemap` |
| `.github/prompts/persona-software-architect-impl-plan.prompt.md` | Prompt | `/impl-plan` |
| `.github/prompts/persona-software-architect-api-validate.prompt.md` | Prompt | `/api-validate` |
| `.github/instructions/backend.instructions.md` | Instructions | Backend conventions |
| `.github/instructions/frontend.instructions.md` | Instructions | Frontend conventions |

---

## Where the artifacts live

The active artifacts are consolidated under the root `.github/` directory:

| **Type** | Path |
|---|---|
| Agents | `.github/agents/` |
| Prompts | `.github/prompts/persona-*.prompt.md` |
| Skills | `.github/skills/` |
| Instructions | `.github/instructions/` |

Use this directory as the reference. Active files live only under the root `.github/` directory — edit them there when maintenance is needed.

If the kit includes `mcp.json` and the facilitator requests local MCP, copy only that file to `.vscode/mcp.json`.

---

## Best practices

- Prefer composition over inheritance, clear boundaries over generic abstractions, and clear data over clever code.
- API contracts are a public commitment; break them only with versioning and a migration guide.
- Keep business rules out of the database and framework.
- A growing `util` directory usually indicates a missing bounded context.

---

## References

- [Clean Architecture — Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Domain-Driven Design — Eric Evans](https://www.domainlanguage.com/ddd/)
- [Hexagonal Architecture — Alistair Cockburn](https://alistair.cockburn.us/hexagonal-architecture/)
- [Microsoft .NET Architecture Guides](https://learn.microsoft.com/dotnet/architecture/)

---

### Continue reading

| Previous | Next |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Table of the 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Profile for this persona.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
