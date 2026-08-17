<!-- markdownlint-disable MD013 MD033 MD041 -->

# Persona Kits

> **Track:** [Team Kit](../README.md) › **Personas**

**Onboarding guide for the workshop's 10 personas.** Each persona is a Copilot toolkit specialized for an SDLC role; each team member chooses and studies 2 personas from the same pair.

| Field | Value |
|---|---|
| **Target audience** | All workshop participants |
| **Prerequisites** | [00-SETUP.md](../00-SETUP.md) completed |
| **Estimated time** | 15 min |
| **Expected outcome** | Two personas identified, `.github/` validated, Copilot reloaded |

![Overview of persona pairs in the SIFAP workshop](../assets/personas-team.svg)

---

## Concept

A persona is a Copilot toolkit specialized for a specific role in the development lifecycle. Each kit includes a configured agent, prompts for recurring tasks, instructions, and skills. The persona guides how Copilot responds and which productivity shortcuts are available.

In the SIFAP (Payment Inspection and Administration System) context, each role has direct responsibilities for concrete artifacts—from the Natural/Adabas rule catalog to acceptance tests and the CI pipeline. By studying the persona, you know what to produce, who provides your inputs, and who receives your outputs.

---

## The 5 pairs

The workshop team has 5 people, each using 2 personas from the same pair. This covers the entire SDLC.

| **Pair** | Personas | Kits |
|---|---|---|
| **1 · Vision** | Product Owner + Requirements Engineer | `01-product-owner/` + `02-requirements-engineer/` |
| **2 · Architecture** | Enterprise Architect + Software Architect | `03-enterprise-architect/` + `04-software-architect/` |
| **3 · Implementation** | Technical Lead + Developer | `05-technical-lead/` + `06-developer/` |
| **4 · Quality** | DBA + QA Engineer | `07-dba/` + `08-qa-engineer/` |
| **5 · Operations** | DevOps Engineer + Tech Writer | `09-devops-engineer/` + `10-tech-writer/` |

---

## What each kit contains

| **Artifact** | Purpose |
|---|---|
| `PERSONA.md` | Complete profile: responsibilities, handoffs, prompts, and evaluation criteria |
| `README.md` | Inventory of Copilot artifacts (paths under `.github/`) |
| `mcp.json` | Recommended MCP servers for the role (when available) |

Active artifacts are consolidated in the root `.github/` directory:

| **Artifact** | Path |
|---|---|
| Copilot agent tailored to the role | `.github/agents/*.agent.md` |
| Prompts for recurring tasks | `.github/prompts/persona-*.prompt.md` |
| Reusable skills | `.github/skills/*/SKILL.md` |
| File-type-specific rules | `.github/instructions/*.instructions.md` |

---

## Available kits

| **#** | Kit | Workshop role |
|---|---|---|
| 01 | [Product Owner](./01-product-owner/PERSONA.md) | Priority, scope, value, and demo narrative |
| 02 | [Requirements Engineer](./02-requirements-engineer/PERSONA.md) | EARS requirements, acceptance criteria, and traceability |
| 03 | [Enterprise Architect](./03-enterprise-architect/PERSONA.md) | External dependencies and scope decisions |
| 04 | [Software Architect](./04-software-architect/PERSONA.md) | Technical plan, module boundaries, and ADRs when needed |
| 05 | [Technical Lead](./05-technical-lead/PERSONA.md) | Standards, technical coordination, and PR reviews |
| 06 | [Developer](./06-developer/PERSONA.md) | Java/TypeScript code, tests, and integration |
| 07 | [DBA](./07-dba/PERSONA.md) | PostgreSQL model, migrations, and DDM mapping |
| 08 | [QA Engineer](./08-qa-engineer/PERSONA.md) | Test strategy, coverage, and gates |
| 09 | [DevOps Engineer](./09-devops-engineer/PERSONA.md) | CI/CD, Terraform, secrets, and deployment |
| 10 | [Tech Writer](./10-tech-writer/PERSONA.md) | Glossary, ADR clarity, README, and runbook |

---

## How to activate your persona

![Five steps for using your persona: read PERSONA.md, review README, validate .github, copy mcp.json if needed, reload Copilot](../assets/persona-onboarding.svg)

> [!IMPORTANT]
> Complete [00-SETUP.md](../00-SETUP.md) before proceeding.

- [ ] **Identify your two personas.** Find your pair in [00-TEAM-FLOW.md](../00-TEAM-FLOW.md).
- [ ] **Read both profiles.** Open `05-personas/<role>/PERSONA.md` for each role in your pair.
- [ ] **Validate the consolidated `.github/`.** Confirm that agents, prompts, instructions, and skills are present:

  ```bash
  ls .github/agents .github/prompts .github/instructions .github/skills
  ```

- [ ] **Copy the MCP configuration only if needed.** The facilitator will tell you when:

  ```bash
  [ -f 05-personas/06-developer/mcp.json ] && \
    mkdir -p .vscode && \
    cp 05-personas/06-developer/mcp.json .vscode/mcp.json
  ```

- [ ] **Reload Copilot.** Open the Command Palette and run **Developer: Reload Window**.
- [ ] **Verify agents and prompts.** Type `@` in the Copilot panel and confirm the agents. Type `/` and confirm the slash commands.

---

## How to study a kit in 10 minutes

- [ ] **Read `PERSONA.md` first.** Mission, responsibilities, handoffs, and evaluation rubrics.
- [ ] **Open the kit's `README.md`.** Inventory of agents, prompts, skills, and MCPs.
- [ ] **Review the available prompts.** They are shortcuts for recurring tasks, not substitutes for judgment.
- [ ] **Check skills and instructions.** Skills contain workflows; instructions apply rules by file type.
- [ ] **Note the handoffs.** Every persona must know who provides their inputs and who receives their outputs.

---

## Installation Definition of Done

- [ ] Both `PERSONA.md` profiles for the pair have been read.
- [ ] The consolidated `.github/` contains agents, prompts, instructions, and skills.
- [ ] `mcp.json` copied to `.vscode/` when available.
- [ ] VS Code reloaded.
- [ ] Agents appear when typing `@` in Copilot Chat.
- [ ] Prompts appear when typing `/` in Copilot Chat.

---

### Continue reading

| Previous | Next |
|---|---|
| [SETUP](../00-SETUP.md)<br/><sub>Laptop setup: Git, VS Code, Copilot, Spec-Kit, branch protection.</sub> | [OVERVIEW of the 10 personas](OVERVIEW.md)<br/><sub>Comparison table: pair, stage lead, emergency defaults.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
