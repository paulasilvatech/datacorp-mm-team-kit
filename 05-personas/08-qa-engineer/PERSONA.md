<!-- markdownlint-disable MD013 MD033 MD041 -->

# Persona — QA Engineer

> **Track:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › [QA Engineer](README.md) › **PERSONA**

**Reference profile for the QA Engineer persona in the SIFAP modernization workshop.**

![Pair 4](https://img.shields.io/badge/Par-4%20%C2%B7%20Qualidade-171717?style=flat-square) ![Leads Stages 3 and 4](https://img.shields.io/badge/Lidera-Est%C3%A1gios%203%20e%204-404040?style=flat-square) ![Supports all](https://img.shields.io/badge/Apoia-Todos%20os%20est%C3%A1gios-737373?style=flat-square)

| Field | Value |
|---|---|
| **Role** | QA Engineer (Quality Assurance Engineer) |
| **Pair** | Pair 4 — Quality (with DBA) |
| **Active stages** | Stage 1 (critical scenarios), Stage 2 (acceptance criteria), Stage 3 (leads testing), Stage 4 (validates coverage) |
| **Artifacts produced** | Test suite (JUnit 5 + Testcontainers + Vitest), test strategy, acceptance criteria per REQ-ID, green CI pipeline |
| **Artifacts consumed** | EARS requirements with REQ-IDs (Requirements Engineer), testable code (Developer), seed data (DBA) |
| **Handoff to** | DevOps Engineer — reliable CI; entire team — green pipeline |

---

## What this persona is

The QA Engineer transforms EARS requirements into executable tests that prove functional equivalence between legacy Natural/Adabas behavior and modern Java 21 code. In the SIFAP (Payment Inspection and Administration System) modernization, this persona defines the test strategy, writes the tests that matter rather than every possible test, and keeps the CI pipeline green throughout Stage 3.

Why it matters: in legacy modernization, functional equivalence between old and new systems can only be proven by tests traceable to requirements. Without the QA Engineer, the team cannot know whether the Natural-to-Java translation preserved correct business behavior.

Within the Agentic Legacy Modernization framework, the QA Engineer works with the Test Gen Agent and Security Agent in Stage 3 and validates coverage in Copilot Agent PRs during Stage 4.

## Where you work in the SDLC

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart LR
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef active fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px
    classDef muted fill:#FAFAFA,stroke:#A3A3A3,color:#404040
    S1["Stage 1<br/>Archaeology"]:::step --> S2["Stage 2<br/>Specification"]:::step
    S2 --> S3["Stage 3<br/>Implementation"]:::active
    S3 --> S4["Stage 4<br/>Evolution"]:::active
```

| Stage | Responsibility | Deliverable |
|---|---|---|
| **1 — Archaeology** | Identify critical scenarios in the assigned Natural programs | Critical scenarios by program |
| **2 — Specification** | Validate that every EARS requirement is testable and propose concrete acceptance criteria | Test criteria per REQ-ID |
| **3 — Implementation** | Write unit and integration tests for prioritized behavior; keep CI green | Test suite + green pipeline |
| **4 — Evolution** | Require Copilot Agent PRs to include tests and validate coverage of new scenarios | Coverage aligned with the feature |

## Core responsibility

Define the project's test strategy. Write the critical tests—not to chase 100% coverage, but to cover the paths that matter. Validate spec-to-test traceability. Protect the team from a falsely green CI pipeline whose tests always pass regardless of behavior.

## Key skills

- JUnit 5: `@Test`, `@DisplayName`, `@ParameterizedTest`, AssertJ
- Testcontainers for real PostgreSQL 16 integration
- Vitest + Testing Library for Next.js 15 components
- Test-to-REQ-ID traceability through inline comments
- Risk-driven coverage analysis rather than percentage-driven coverage

## Persona kit

| Artifact | Path | Use |
|---|---|---|
| QA Engineer agent | `.github/agents/qa-engineer.agent.md` | Test generation, coverage analysis, and quality gates |
| Prompt `/create-tests` | `.github/prompts/persona-qa-engineer-create-tests.prompt.md` | Generate tests from an EARS requirement |
| Prompt `/coverage-gaps` | `.github/prompts/persona-qa-engineer-coverage-gaps.prompt.md` | Identify coverage gaps |
| Prompt `/test-strategy` | `.github/prompts/persona-qa-engineer-test-strategy.prompt.md` | Define the project's test strategy |
| Testing instructions | `.github/instructions/tests.instructions.md` | Mandatory testing conventions |

## Copilot tools and modes

| Tool / Mode | When to use |
|---|---|
| **Copilot Ask** | Generate test scenarios from EARS requirements; discuss missing coverage |
| **Copilot Plan** | Plan JUnit skeletons in batches for an entire slice |
| **Testcontainers** | Integrate with real PostgreSQL—prefer it to Mockito for repository layers |
| **Spec-Kit** (`/speckit.analyze`) | Review test tasks derived from `tasks.md` |
| **GitHub Actions MCP** | Monitor CI without leaving VS Code |

## Recommended cheat sheets

- [`09-cheat-sheets/spec-kit-workflow.md`](../../09-cheat-sheets/spec-kit-workflow.md) — `/speckit.analyze` and test tasks in `tasks.md`
- [`09-cheat-sheets/copilot-3-modes.md`](../../09-cheat-sheets/copilot-3-modes.md) — use Plan for coverage planning and Ask to discuss gaps

## How to perform well

- [ ] **Cover the paths that matter.** Use REQ-IDs and legacy evidence, not a coverage percentage.
- [ ] **Keep the test suite fast.** The full suite must run in under two minutes.
- [ ] **Write tests that fail on the first bug.** Tests that always pass do not validate behavior.
- [ ] **Maintain traceability.** Add `// REQ-NNN` to every test method.

## Common mistakes and how to avoid them

| Symptom | Cause | Correction |
|---|---|---|
| Chasing 100% coverage and missing the deadline | Treating the metric as the goal | Prioritize risk paths identified by the team |
| Tests validate the framework rather than the domain | Infrastructure focus instead of behavior | Ask whether the assertion fails when business behavior changes |
| Mock used where Testcontainers was needed | Convenience | Use Testcontainers for repositories and Mockito for domain services |
| Red CI ignored for 20 minutes | No owner | The QA Engineer owns green CI; do not delegate this responsibility |

## Combinations with other personas

| Combination | Note |
|---|---|
| **QA + Developer** | Most common and productive; write the feature and tests in the same session |
| **QA + Requirements Engineer** | Write the requirement and its matching test |
| **QA + DevOps Engineer** | Avoid when possible—it overloads Stage 3 |

## Ready-to-use prompts

1. **(Ask)** _"For this EARS requirement, generate test scenarios covering the main behavior, boundaries, and relevant failures."_
2. **(Plan)** _"For the prioritized feature class, plan integration tests with the required data and verifications."_
3. **(Ask)** _"Analyze current coverage and identify the highest-risk untested paths. Prioritize them using team evidence."_

## Emergency defaults

| Situation | What to do |
|---|---|
| JUnit 5 is unfamiliar | Use the existing pattern: `@Test`, `@DisplayName`, and AssertJ assertions |
| Testcontainers does not work | Check whether Docker is running; fallback: unit test with Mockito |
| Too many scenarios, too little time | Focus on the highest-risk behavior identified by the team |
| CI is red while local tests pass | Environment issue—check Docker/Testcontainers and the runner's Docker version |

## Dependencies

| Persona | Relationship | Artifact |
|---|---|---|
| Requirements Engineer | You depend on them | Testable requirements with acceptance criteria |
| Developer | You depend on them | Testable code |
| Technical Lead | Depends on you | Green pipeline |
| DevOps Engineer | Depends on you | Reliable CI |

## How you are evaluated

- **Rubric A3 — Technical Integrity:** passing tests, green CI
- **Rubric A2 — Spec:** every requirement has verification criteria
- **Criterion:** tests fail on the first bug rather than always passing

---

### Continue reading

| Previous | Next |
|---|---|
| [DBA — PERSONA](../07-dba/PERSONA.md)<br/><sub>Pair 4 — Quality — Flyway migrations and query optimization.</sub> | [DevOps Engineer — PERSONA](../09-devops-engineer/PERSONA.md)<br/><sub>Pair 5 — Operations — Terraform, GitHub Actions, and runbook.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
