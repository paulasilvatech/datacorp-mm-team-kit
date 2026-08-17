# Technical Lead — Copilot Kit

> **Trail:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **Technical Lead**

**Inventory of the Copilot kit for the Technical Lead persona.** Lists the active artifacts, where they live under `.github/`, and best practices specific to this role.

| Field | Value |
|---|---|
| **Target audience** | Person acting as Technical Lead in the workshop |
| **Pair** | 3 · Implementation (with the Developer) |
| **SDLC phase** | All phases (technical coordination) |
| **Prerequisites** | [PERSONA.md](PERSONA.md) read |
| **Expected outcome** | Kit validated, prompts accessible in Copilot Chat |

> [!IMPORTANT]
> Read [PERSONA.md](PERSONA.md) before continuing. The profile explains the mission, handoff, and evaluation rubrics.

---

## Concept

The Technical Lead connects architecture to everyday code. This role defines implementation standards, unblocks the team when someone gets stuck on a technical detail, and ensures that the application created by the team actually runs end to end by the end of Stage 3. In SIFAP (Payment Inspection and Administration System), the TL maintains execution speed without compromising quality by choosing which technical battles are worth fighting.

---

## Persona kit

| **Artifact** | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | Responsibilities, handoff, prompts, and rubric |
| `.github/agents/tech-lead.agent.md` | Agent | Technical governance |
| `.github/prompts/persona-technical-lead-setup-project.prompt.md` | Prompt | `/setup-project` |
| `.github/prompts/persona-technical-lead-routing-table.prompt.md` | Prompt | `/routing-table` |
| `.github/prompts/persona-technical-lead-audit-context.prompt.md` | Prompt | `/audit-context` |
| `hooks.json` | Hooks | Scope, linting, and tests |

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

- Block bad changes, not people; review the PR and protect reviewers' time.
- `CODEMAP.md` is the team's working memory; if it is outdated, the team works without visibility.
- Model routing matters: Opus for discovery, Sonnet for implementation, Haiku for mechanical transformations.
- Cost per feature is an engineering metric; track it alongside coverage.

---

## References

- [Staff Engineer — Will Larson](https://staffeng.com/)
- [The Manager's Path — Camille Fournier](https://www.oreilly.com/library/view/the-managers-path/9781491973882/)
- [Accelerate — Forsgren, Humble, Kim](https://itrevolution.com/product/accelerate/)
- [GitHub Copilot Best Practices](https://docs.github.com/en/copilot)

---

### Continue reading

| Previous | Next |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Table of the 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Profile for this persona.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
