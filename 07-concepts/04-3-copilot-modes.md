# Copilot's 3 Modes — Ask, Plan, and Agent

> **Path:** [Team Kit](../README.md) › [Concepts](00-README.md) › **Copilot's 3 Modes**

**GitHub Copilot operates in three distinct modes—Ask, Plan, and Agent—and choosing the wrong mode for a task wastes time. This document provides objective criteria for selecting the right mode in each workshop situation.**

![Concept 04](https://img.shields.io/badge/Concept-04-171717?style=flat-square) ![Used in All Stages](https://img.shields.io/badge/Used-All%20stages-737373?style=flat-square) ![Duration 15 min](https://img.shields.io/badge/Duration-15%20min-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | All personas |
| **Prerequisites** | Read [Agents and Personas](02-agents-and-personas.md) |
| **Estimated time** | 15 minutes |
| **Stage** | All stages |
| **Expected outcome** | Know which mode to use for each task without hesitation |

---

## Concept

Copilot Chat provides three operating modes with different levels of autonomy, time costs, and outputs:

- **Ask** — conversational mode. You ask questions and receive text answers. No code is changed.
- **Plan** — planning mode. You describe a change, and Copilot proposes a plan listing the files to touch and the changes to make—before execution.
- **Agent** — autonomous mode. You provide a well-defined task, usually as an Issue, and Copilot reads the code, implements the change, and opens a PR autonomously.

---

## Why it matters

Using the wrong mode has direct consequences:

- **Ask when you should use Plan:** You receive correct guidance but must perform everything manually, making the work slower than necessary.
- **Agent when you should use Ask:** Copilot changes multiple files based on incomplete context, generating a faulty PR that takes longer to correct than a manual change.
- **Plan when you should use Agent:** You review a step-by-step plan for a large, well-defined task, creating unnecessary manual effort.

---

## Decision tree

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart TD
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px
    classDef question fill:#FAFAFA,stroke:#A3A3A3,color:#404040

    Q1{"Do you need to<br/>change code?"}:::question
    Q2{"Does the change<br/>affect more than<br/>one file?"}:::question
    Q3{"Is the requirement<br/>fully<br/>specified?"}:::question

    ASK["Ask<br/><sub>Question, explore, understand</sub>"]:::result
    PLAN["Plan<br/><sub>Plan a change with human review</sub>"]:::result
    AGENT["Agent<br/><sub>Delegate a complete task</sub>"]:::result

    Q1 -- "No" --> ASK
    Q1 -- "Yes" --> Q2
    Q2 -- "No (1 file)" --> PLAN
    Q2 -- "Yes" --> Q3
    Q3 -- "No" --> PLAN
    Q3 -- "Yes, detailed Issue" --> AGENT
```

---

## Comparing the three modes

| Criterion | Ask | Plan | Agent |
|---|---|---|---|
| **What it does** | Answers questions in text | Proposes a change plan without executing it | Implements autonomously and opens a PR |
| **Autonomy** | None | Low (you approve each step) | High (runs without intervention) |
| **Time cost** | Low | Medium | High—justified only for large tasks |
| **When to use** | Explore, understand, answer questions | Multi-file change with human review | Fully specified Issue with context and acceptance criteria |
| **Prerequisite** | None | Context for what to change | Issue containing context, REQ-IDs, acceptance criteria, and traceability |
| **Rework risk** | None | Low | High if the Issue is incomplete |

---

## Prompt examples by mode — SIFAP context

### Ask — explore the legacy system

```text
"Explain line by line what CALCPGTO.NSN does.
Focus on business decisions. Ignore I/O routines."
```

```text
"@archaeologist, which fields in BENEFIC.ddm
are mandatory, and which are multiple-value fields (MU)?"
```

### Plan — implement a requirement with review

```text
"Plan: implement REQ-042 (calculate the net benefit amount).
List the files to create or modify, the order of changes,
and the required integration tests.
DO NOT implement yet—I am waiting for team approval."
```

```text
"Plan: create Flyway migration V3 to add the
status_pagamento column to the beneficiario table.
Show the SQL script and the required JPA entity changes."
```

### Agent — delegate a complete task (Stage 4)

```text
[Create a GitHub Issue containing:]
- Title: Implement endpoint GET /api/v1/beneficiarios/{id}
- Context: REQ-042 specified in Stage 2 and mapped to BeneficiarioService
- Acceptance criteria: returns 200 with a DTO, returns 404 when not found,
  validates the UUID in the path, and includes Testcontainers tests for both scenarios
- Traceability: REQ-042 › CALCPGTO.NSN#L120-L198
[Select Agent mode and reference the Issue]
```

---

## Anti-patterns — what not to do

| Anti-pattern | Consequence | Correct alternative |
|---|---|---|
| Use Agent for a two-minute question | Delay, context consumption, and risk of unwanted changes | Use Ask |
| Use Ask to implement an entire service | You receive guidance but perform everything manually | Use Plan or Agent |
| Delegate to Agent without a detailed Issue | Generated PR contains incorrect or incomplete code | Write the complete Issue before starting Agent |
| Use Plan during Stage 1 (archaeology) | Copilot may try to modify the legacy system | Use Ask with `@archaeologist` |
| Ignore the Plan output before execution | Unexpected changes to unplanned files | Read and approve the plan before confirming |

---

## Estimated time cost

Use these estimates to choose a mode during the workshop. Actual time varies with task complexity:

| Mode | Simple task | Medium task | Complex task |
|---|---|---|---|
| Ask | 1–2 min | 3–5 min | 5–10 min |
| Plan | 5–10 min (including review) | 15–20 min | 30+ min |
| Agent | Not recommended | 20–30 min (including PR review) | 45–90 min |

> [!WARNING]
> Agent time includes review of the generated PR. PRs with incomplete context may require multiple iterations.

---

## References

- [One-page cheat sheet for the 3 modes](../09-cheat-sheets/copilot-3-modes.md)
- [Agents and Personas](02-agents-and-personas.md)
- [Stage 4 Guide — Agent mode in practice](../04-evolution/GUIDE.md)

---

### Continue reading

| Previous | Next |
|---|---|
| [Visual Glossary](03-visual-glossary.md)<br/><sub>30+ terms with definitions and SIFAP examples.</sub> | [EARS Notation](05-ears-notation.md)<br/><sub>How to write unambiguous requirements.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
