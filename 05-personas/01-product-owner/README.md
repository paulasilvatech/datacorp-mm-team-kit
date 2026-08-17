<!-- markdownlint-disable MD013 MD033 MD041 -->

# Product Owner — Copilot Kit

> **Trail:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **Product Owner**

**Inventory of the Copilot kit for the Product Owner persona.** Lists the active artifacts, where they live under `.github/`, and best practices specific to this role.

| Field | Value |
|---|---|
| **Target audience** | Person acting as Product Owner in the workshop |
| **Pair** | 1 · Vision (with the Requirements Engineer) |
| **SDLC phase** | Discovery → Specification → Acceptance |
| **Prerequisites** | [PERSONA.md](PERSONA.md) read |
| **Expected outcome** | Kit validated, prompts accessible in Copilot Chat |

> [!IMPORTANT]
> Read [PERSONA.md](PERSONA.md) before continuing. The profile explains the mission, handoff, and evaluation rubrics.

---

## Concept

The Product Owner is responsible for translating business needs into executable scope. In a legacy modernization process such as SIFAP (Payment Inspection and Administration System), this function is critical: legacy systems accumulate implicit rules that only make sense when someone knows "why" they exist. The PO connects every technical decision to business evidence.

---

## Persona kit

| **Artifact** | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | Responsibilities, handoff, prompts, and rubric |
| `.github/agents/product-owner.agent.md` | Agent | Product Owner assistant for specification, backlog, and acceptance |
| `.github/prompts/persona-product-owner-spec.prompt.md` | Prompt | `/spec` — writes a section of `specs/<NNN>-<feature>/spec.md` from user stories in EARS |
| `.github/prompts/persona-product-owner-update-spec.prompt.md` | Prompt | `/update-spec` — updates the specification when a feature changes |
| `.github/prompts/persona-product-owner-acceptance-check.prompt.md` | Prompt | `/acceptance-check` — checks whether the code meets the acceptance criteria |
| `mcp.json` | MCP | GitHub servers + Azure DevOps work items manifest |

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

- Write requirements in EARS so that every sentence is testable.
- Keep every user story tied to a measurable outcome.
- Mark assumptions explicitly — a hidden assumption becomes a production bug.
- Treat `.specify/memory/constitution.md` as the source of truth for non-negotiable items.

---

## References

- [EARS Notation — Alistair Mavin](https://alistairmavin.com/ears/)
- [Spec-Driven Development (Spec-Kit)](https://github.com/github/spec-kit)
- [User Story Mapping — Jeff Patton](https://www.jpattonassociates.com/user-story-mapping/)
- [GitHub Copilot for PMs](https://docs.github.com/en/copilot)

---

### Continue reading

| Previous | Next |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Table of the 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Profile for this persona.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
