<!-- markdownlint-disable MD013 MD033 MD041 -->

# Enterprise Architect — Copilot Kit

> **Trail:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **Enterprise Architect**

**Inventory of the Copilot kit for the Enterprise Architect persona.** Lists the active artifacts, where they live under `.github/`, and best practices specific to this role.

| Field | Value |
|---|---|
| **Target audience** | Person acting as Enterprise Architect in the workshop |
| **Pair** | 2 · Architecture (with the Software Architect) |
| **SDLC phase** | Architecture → Design → Security |
| **Prerequisites** | [PERSONA.md](PERSONA.md) read |
| **Expected outcome** | Kit validated, prompts accessible in Copilot Chat |

> [!IMPORTANT]
> Read [PERSONA.md](PERSONA.md) before continuing. The profile explains the mission, handoff, and evaluation rubrics.

---

## Concept

The Enterprise Architect views the system within its ecosystem. In SIFAP (Payment Inspection and Administration System), this means mapping external dependencies — SIAFI, Banco do Brasil, INCRA, MDA — and ensuring that the target architecture respects existing contracts. The EA knows where the contracts are, which are fragile, and which can be changed without triggering a chain of unforeseen effects.

---

## Persona kit

| **Artifact** | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | Responsibilities, handoff, prompts, and rubric |
| `.github/agents/enterprise-architect.agent.md` | Agent | Architecture and security |
| `.github/prompts/persona-enterprise-architect-create-constitution.prompt.md` | Prompt | `/create-constitution` |
| `.github/prompts/persona-enterprise-architect-create-adr.prompt.md` | Prompt | `/create-adr` |
| `.github/prompts/persona-enterprise-architect-architecture-review.prompt.md` | Prompt | `/architecture-review` |
| `.github/instructions/security.instructions.md` | Instructions | Security conventions |
| `.github/instructions/infrastructure.instructions.md` | Instructions | IaC conventions |
| `hooks.json` | Hooks | Edit blocks for `.specify/memory/constitution.md` |

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

- Use C4 L1/L2 for the executive view and L3/L4 for implementation.
- Every architectural decision needs an ADR with context, decision, and consequences.
- Prefer architecture that is predictable and operable in production.
- Use the Azure Well-Architected pillars as review gates, not as a late checklist.

---

## References

- [C4 Model — Simon Brown](https://c4model.com/)
- [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [Architecture Decision Records](https://adr.github.io/)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)

---

### Continue reading

| Previous | Next |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Table of the 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Profile for this persona.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
