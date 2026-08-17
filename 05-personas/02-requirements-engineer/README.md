# Requirements Engineer — Copilot Kit

> **Trail:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **Requirements Engineer**

**Inventory of the Copilot kit for the Requirements Engineer persona.** Lists the active artifacts, where they live under `.github/`, and best practices specific to this role.

| Field | Value |
|---|---|
| **Target audience** | Person acting as Requirements Engineer in the workshop |
| **Pair** | 1 · Vision (with the Product Owner) |
| **SDLC phase** | Requirements → Specification |
| **Prerequisites** | [PERSONA.md](PERSONA.md) read |
| **Expected outcome** | Kit validated, prompts accessible in Copilot Chat |

> [!IMPORTANT]
> Read [PERSONA.md](PERSONA.md) before continuing. The profile explains the mission, handoff, and evaluation rubrics.

---

## Concept

The Requirements Engineer is responsible for transforming conversations and discoveries into formal, testable requirements. In SIFAP (Payment Inspection and Administration System), business rules are tacitly encoded in Natural, without up-to-date documentation. The RE extracts those rules, structures them using EARS (Easy Approach to Requirements Syntax), and ensures traceability from the legacy system to the modern requirement.

---

## Persona kit

| **Artifact** | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | Responsibilities, handoff, prompts, and rubric |
| `.github/agents/requirements-engineer.agent.md` | Agent | Requirements analysis |
| `.github/prompts/persona-requirements-engineer-spec-sync.prompt.md` | Prompt | `/spec-sync` |
| `.github/prompts/persona-requirements-engineer-contradiction-check.prompt.md` | Prompt | `/contradiction-check` |
| `.github/prompts/persona-requirements-engineer-ears-convert.prompt.md` | Prompt | `/ears-convert` |
| `.github/instructions/requirements.instructions.md` | Instructions | Requirements documentation conventions |

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

- Use EARS patterns exclusively; vague requirements must be quantified.
- Every `REQ-ID` must be unique, immutable, and traceable to at least one test and one task.
- Perform a contradiction pass before accepting new specifications.
- Remove or quantify ambiguous terms such as "adequate," "reasonable," and "user-friendly."

---

## References

- [EARS Notation — Alistair Mavin](https://alistairmavin.com/ears/)
- [IEEE 29148 — Requirements Engineering](https://www.iso.org/standard/72089.html)
- [ISO/IEC 25010 — Quality Model](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010)
- [Writing Good Requirements — INCOSE](https://www.incose.org/)

---

### Continue reading

| Previous | Next |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Table of the 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Profile for this persona.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
