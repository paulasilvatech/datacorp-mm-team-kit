# Documentation

> **Path:** [Team Kit](../README.md) › **Docs**

**Index of the workshop's cross-cutting documentation** — resources used at any stage of the day.

| Field | Value |
|---|---|
| **Target audience** | The entire team, especially the Tech Writer and Technical Lead |
| **Prerequisites** | Read [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) |
| **Estimated time** | 5 min |
| **Expected outcome** | Know where to find each cross-cutting resource |

---

## How to use this folder

- [ ] **Before starting the day** — read [sdlc-flow-guide.md](sdlc-flow-guide.md) to understand the complete map.
- [ ] **When choosing your personas** — read [persona-agent-matrix.md](persona-agent-matrix.md) to learn when you lead, support, or observe.
- [ ] **During Stage 1** — update the [Stage 1 glossary](../01-archaeology/glossary.md) and record terms with a legacy source.
- [ ] **For every technical decision** — create an ADR in [adr/](adr/).
- [ ] **When an agent or harness mistake recurs** — record it in the [failure register](failures/README.md) with the check that catches it.
- [ ] **At the end of the day** — review [runbook.md](runbook.md) so another person can run and operate the system.

## Structure

| Path | Purpose |
|---|---|
| [`adr/`](adr/) | Architecture decision records (one file per decision) |
| [`failures/`](failures/) | Agent failure register — known agent/harness mistakes and the guardrail for each |
| [`../01-archaeology/glossary.md`](../01-archaeology/glossary.md) | Domain glossary — completed during Stage 1 |
| [`4-agents-explained.md`](4-agents-explained.md) | Explanation of the four stage agents and their relationship to persona kits |
| [`persona-agent-matrix.md`](persona-agent-matrix.md) | Matrix showing who leads, supports, or observes at each stage |
| [`sdlc-flow-guide.md`](sdlc-flow-guide.md) | Complete flow of the day, handoffs, and deliverables |
| `api.md` _(created by the team)_ | OpenAPI overview and endpoint summary |
| [`runbook.md`](runbook.md) | How to run the system locally, in CI, and on Azure |

## Conventions

- Use one ADR per decision. Number them sequentially: `0001-title.md`, `0002-title.md`.
- Keep glossary terms in alphabetical order, with citations to the legacy program where each term originated.
- Every README in a subfolder follows [`.github/copilot-instructions.md`](../.github/copilot-instructions.md).
- Every important decision becomes an ADR. A chat conversation is not a sufficient record.
- Every glossary term originating in the legacy system needs a source (`.NSN`, `.ddm`, or historical document).

## Documentation definition of done

- [ ] Glossary includes legacy sources.
- [ ] ADRs include context, options, decision, and consequences.
- [ ] Runbook includes commands for execution, validation, and troubleshooting.
- [ ] Internal links point to the correct files.
- [ ] Documents explain the reason before the procedure.

## Quick links

- [Team flow](../00-TEAM-FLOW.md)
- [Consolidated persona kits](../05-personas/) — read `PERSONA.md` inside the kit for your role
- [Stage guides](../01-archaeology/GUIDE.md)

---

### Continue reading

| Previous | Next |
|---|---|
| [Reference Cards](../09-cheat-sheets/README.md)<br/><sub>Three one-page cards: Copilot, Spec-Kit, and models.</sub> | [Visual Glossary](../07-concepts/03-visual-glossary.md)<br/><sub>30+ technical terms from the SIFAP domain.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
