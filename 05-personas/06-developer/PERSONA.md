<!-- markdownlint-disable MD013 MD033 MD041 -->

# Persona — Developer

> **Track:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › [Developer](README.md) › **PERSONA**

**Reference profile for the Developer persona in the SIFAP modernization workshop.**

![Pair 3](https://img.shields.io/badge/Par-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-171717?style=flat-square) ![Leads Stage 3](https://img.shields.io/badge/Lidera-Est%C3%A1gio%203-404040?style=flat-square) ![Supports Stage 4](https://img.shields.io/badge/Apoia-Est%C3%A1gio%204-737373?style=flat-square)

| Field | Value |
|---|---|
| **Role** | Developer |
| **Pair** | Pair 3 — Implementation (with Technical Lead) |
| **Active stages** | Stage 3 — Implementation (leads); Stage 4 — Evolution (supports) |
| **Artifacts produced** | Backend (Java 21 + Spring Boot 3.3), frontend (Next.js 15), tests (JUnit 5 + Testcontainers + Vitest), reviewable PRs |
| **Artifacts consumed** | EARS requirements (Requirements Engineer), package structure and bounded contexts (Software Architect), Flyway migrations (DBA) |
| **Handoff to** | QA Engineer — testable code; DevOps Engineer — stable build |

---

## What this persona is

The Developer writes the code. In the SIFAP (Payment Inspection and Administration System) modernization, this persona translates Natural programs and DDM/Adabas structures into Java 21 with Spring Boot 3.3, implements the frontend in Next.js 15 with strict TypeScript, and ensures that every EARS requirement becomes a functional endpoint with passing tests.

Within the Agentic Legacy Modernization framework, the Developer works in the translation layer (Translation Agent — Stage 3) and follows the Review Agent in Stage 4, intervening when the Copilot Agent deviates from the architecture standards defined by the team.

## Where you work in the SDLC

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart LR
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef active fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px
    classDef muted fill:#FAFAFA,stroke:#A3A3A3,color:#404040

    S1["Stage 1<br/>Archaeology"]:::muted --> S2["Stage 2<br/>Specification"]:::muted
    S2 --> S3["Stage 3<br/>Implementation"]:::active
    S3 --> S4["Stage 4<br/>Evolution"]:::step
```

| Stage | Responsibility | Deliverable |
|---|---|---|
| **1 — Archaeology** | Read Natural programs with Copilot Chat and produce a team-readable summary | Narrative program summaries |
| **2 — Specification** | Pair with the Requirements Engineer to anticipate implementation problems | Preventive notes in the spec |
| **3 — Implementation** | Implement, test, open a PR, review the pair's PR, iterate | Backend + frontend for the prioritized slice |
| **4 — Evolution** | Follow the Copilot Agent, intervene when needed, finish what the Agent did not complete | Agent PR in a mergeable state |

## Core responsibility

Transform the spec into executable code using Copilot deliberately—Ask mode to understand, Plan mode to plan multi-file changes, and Agent mode to delegate well-defined tasks. Commit every day.

## Key skills

- Java 21 implementation: records, sealed interfaces, virtual threads, Optional, Bean Validation
- TypeScript implementation: Next.js 15 App Router, Server Actions, `strict: true`
- TDD with JUnit 5, Testcontainers, and Vitest
- Incremental refactoring with commits separated by intent
- Deliberate switching among Copilot's three modes

## Persona kit

| Artifact | Path | Use |
|---|---|---|
| Implementation agent | `.github/agents/implementer.agent.md` | Implementation, TDD, and bug fixing |
| Prompt `/implement` | `.github/prompts/persona-developer-implement.prompt.md` | Start implementation from a spec |
| Prompt `/fix-bug` | `.github/prompts/persona-developer-fix-bug.prompt.md` | Understand → reproduce → fix → verify cycle |
| Prompt `/tdd` | `.github/prompts/persona-developer-tdd.prompt.md` | Write a test before implementation |
| Prompt `/refactor` | `.github/prompts/persona-developer-refactor.prompt.md` | Refactor without changing behavior |

## Copilot tools and modes

| Tool / Mode | When to use |
|---|---|
| **Copilot Ask** | Understand Natural legacy code and discuss design before implementation |
| **Copilot Plan** | Primary mode in Stage 3—plan changes affecting multiple files |
| **Copilot Agent** | Stage 4—delegate well-defined tasks from Issues |
| **Spec-Kit** (`/speckit.tasks`, `/speckit.implement`) | Consume Software Architect and Requirements Engineer artifacts |
| **GitHub MCP** | Work with Issues and PRs without leaving VS Code |

## Recommended cheat sheets

- [`09-cheat-sheets/copilot-3-modes.md`](../../09-cheat-sheets/copilot-3-modes.md) — map for the day; use it constantly
- [`09-cheat-sheets/spec-kit-workflow.md`](../../09-cheat-sheets/spec-kit-workflow.md) — `/speckit.tasks`, `/speckit.implement`, and `/speckit.analyze`
- [`09-cheat-sheets/model-routing.md`](../../09-cheat-sheets/model-routing.md) — Haiku 4.5 for simple snippets, Sonnet 4.6 by default, Opus 4.6 for design

## How to perform well

- [ ] **Use all three Copilot modes deliberately.** Chat is not always the right mode.
- [ ] **Keep commits small and PRs reviewable.** One topic per PR.
- [ ] **Write tests at the same time as the code.** Never afterward.
- [ ] **Do not invest in premature abstractions during Stage 3.** Prefer clarity over elegance.

## Common mistakes and how to avoid them

| Symptom | Cause | Correction |
|---|---|---|
| Huge branch accumulating for hours | Unfocused PR | Open one PR per feature or layer |
| Copilot Agent used for a simple task | Wrong mode selected | Reserve Agent for tasks with clear scope and complete input artifacts |
| Untested code discovered at 4 p.m. | TDD postponed | Write the test before moving to the next behavior |
| Long wait for Opus 4.6 | Oversized model | Use Sonnet 4.6 by default; Opus only for design decisions |

## Combinations with other personas

| Combination | Note |
|---|---|
| **Developer + Technical Lead** | Very common; you implement while the TL reviews and defines standards |
| **Developer + QA Engineer** | You write the feature and tests in the same session |
| **Developer + DevOps Engineer** | For small teams; you package and deliver |

## Ready-to-use prompts

1. **(Ask)** _"Explain the selected legacy code and identify only confirmed behaviors. Then propose questions before implementing them in Java."_
2. **(Plan)** _"Select the files for the prioritized feature. Plan the change across domain, application, infrastructure, data, and tests."_
3. **(Agent)** _"Implement the feature described in this Issue: [paste the issue]. Follow the three-layer architecture and include tests."_

## Emergency defaults

| Situation | What to do |
|---|---|
| Code does not compile | Run `mvn test-compile` to see the exact error—it is usually a missing import |
| Package structure is unknown | Consult the structure defined by the team: `domain/` → `application/` → `infrastructure/` |
| Copilot generates unsuitable code | Switch from Ask to Plan—select the relevant files and describe the change |
| Test fails for no obvious reason | Read the error: an NPE usually means a missing mock; a wrong assertion means an incorrect expected value |

## Dependencies

| Persona | Relationship | Artifact |
|---|---|---|
| Software Architect | You depend on them | Package structure and bounded contexts |
| Requirements Engineer | You depend on them | EARS requirements to implement |
| Technical Lead | Depends on you | PRs to review |
| QA Engineer | Depends on you | Testable code |
| DBA | You depend on them | Migrations and data model |

## How you are evaluated

- **Rubric A3 — Technical Integrity:** functional endpoints, passing tests
- **Rubric A4 — Deliberate Copilot Use:** deliberate switching among Ask, Plan, and Agent
- **Criterion:** small commits, reviewable PRs, tests written alongside the code

---

### Continue reading

| Previous | Next |
|---|---|
| [Technical Lead — PERSONA](../05-technical-lead/PERSONA.md)<br/><sub>Pair 3 — Implementation — standards and code review.</sub> | [DBA — PERSONA](../07-dba/PERSONA.md)<br/><sub>Pair 4 — Quality — Flyway migrations and query optimization.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
