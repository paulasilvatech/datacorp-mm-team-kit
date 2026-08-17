# Spec-Driven Development and Spec-Kit

> **Path:** [Team Kit](../README.md) › [Concepts](00-README.md) › **Spec-Driven Development**

**Spec-Driven Development (SDD) is the practice of fully specifying expected behavior before writing code—and Spec-Kit is the command set that structures this process in Copilot Chat.**

![Concept 01](https://img.shields.io/badge/Concept-01-171717?style=flat-square) ![Stage 2](https://img.shields.io/badge/Stage-2%20%C2%B7%20Specification-737373?style=flat-square) ![Duration 20 min](https://img.shields.io/badge/Duration-20%20min-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | All personas, especially Requirements Engineers and Software Architects |
| **Prerequisites** | Read the `.NSN` programs assigned in Stage 1 |
| **Estimated time** | 20 minutes |
| **Stage** | Stage 2 — Specification |
| **Expected outcome** | Understand the Spec-Kit cycle and know when to run each command |

---

## Concept

Spec-Driven Development is an approach in which the team produces a formal specification—with requirements, an architecture plan, and tasks—before writing any code. As a result, five people working in parallel build compatible parts of the same system instead of five divergent versions.

**Spec-Kit** (official repository: [github/spec-kit](https://github.com/github/spec-kit)) is the practical implementation of SDD for teams using GitHub Copilot. It provides a sequence of commands in Copilot Chat that guides the team from a vague idea to concrete tasks with ownership and traceability.

---

## Why it matters in this workshop

In the SIFAP workshop, five people have a few hours to modernize a 29-year-old system. Without a shared specification, each person implements their interpretation of the legacy system—resulting in incompatible code, duplicated rules, or missing functionality.

Spec-Kit solves this problem by enforcing the cycle:

> specify expected behavior → plan the architecture → distribute tasks → implement

No code should be written before `/speckit.plan` has been run and validated.

---

## How it works

The complete Spec-Kit cycle has seven commands. Each produces a concrete artifact:

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart TD
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef gate fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px
    classDef muted fill:#FAFAFA,stroke:#A3A3A3,color:#404040

    A["/speckit.specify<br/><sub>EARS requirements with source_legacy</sub>"]:::step
    B["/speckit.clarify<br/><sub>Unanswered questions before planning</sub>"]:::step
    C["/speckit.plan<br/><sub>Modules, contracts, data, risks</sub>"]:::step
    D["/speckit.tasks<br/><sub>Tasks with owners and dependencies</sub>"]:::step
    E["/speckit.analyze<br/><sub>Gaps between requirements and plan</sub>"]:::gate
    F["/speckit.implement<br/><sub>Code linked to REQ-IDs</sub>"]:::step
    G["constitution.md<br/><sub>Principles already defined in the repository</sub>"]:::muted

    G -. "read first" .-> A
    A --> B --> C --> D --> E
    E -- "no gaps" --> F
    E -- "gap found" --> C
```

| Command | What it produces | When to use it |
|---|---|---|
| `/speckit.constitution` | General system principles (stack, patterns, constraints) | Once per project—already in `.specify/memory/constitution.md` |
| `/speckit.specify` | EARS requirements with REQ-IDs and `source_legacy:` | At the start of Stage 2, for each confirmed feature |
| `/speckit.clarify` | Questions about behaviors with no legacy evidence | After `specify`, before planning |
| `/speckit.plan` | Modules, API contracts, data model, and risks | After answering all `clarify` questions |
| `/speckit.tasks` | Tasks with estimates, owners, and dependencies | After the team approves the plan |
| `/speckit.analyze` | Consistency report: gaps, conflicts, and coverage | Before implementation—mandatory |
| `/speckit.implement` | Code, tests, and migrations with traceable REQ-IDs | Only after `analyze` reports no critical gaps |

---

## SIFAP example

Suppose Stage 1 revealed that `CALCPGTO.NSN` calculates the net benefit amount by deducting contributions. The Stage 2 flow would be:

```bash
# 1. Check the system principles
cat .specify/memory/constitution.md

# 2. Specify the feature
/speckit.specify calculate the net benefit amount according to CALCPGTO.NSN.
Include source_legacy in every requirement.

# 3. Resolve open questions
/speckit.clarify
# Example generated question: "When a contribution is overdue, is the deduction
# calculated from the gross amount or from the amount after other deductions?"
# → Answer by consulting the legacy code or the PO before continuing.

# 4. Plan the architecture
/speckit.plan
# Use the workshop stack: Java 21 + Spring Boot 3.3 + PostgreSQL 16.

# 5. Distribute tasks
/speckit.tasks

# 6. Check consistency
/speckit.analyze

# 7. Implement
/speckit.implement
```

Every REQ-ID generated by `/speckit.specify` must contain a `source_legacy:` line pointing to the exact `.NSN` section. Without it, the `legacy-traceability` CI job rejects the PR.

---

## Use case

Use Spec-Kit whenever the team starts a new feature in Stage 2. Even when a feature appears simple, running the full cycle prevents the workshop's primary risk: **modernizing what the team thinks the system does rather than what it actually does**.

---

## Common mistakes and how to avoid them

| Symptom | Cause | Correction |
|---|---|---|
| Code written before `plan` | The team skipped the initial steps | Return to `specify`. Code without a spec guarantees rework. |
| Missing `source_legacy:` in a REQ-ID | Requirement written from memory without legacy evidence | Open the corresponding `.NSN` and locate the exact section. |
| Twelve questions from `clarify` | Normal—not a problem | Answer all of them. Every unanswered question becomes a bug. |
| `analyze` reports gaps | Incomplete or inconsistent plan | Do not continue to `implement`. Correct the plan and rerun it. |
| Spec-Kit not found | Incomplete installation | See [`09-cheat-sheets/spec-kit-workflow.md`](../09-cheat-sheets/spec-kit-workflow.md). |

---

## Usage checklist

- [ ] **Read `constitution.md` first.** Confirm the project's stack, patterns, and constraints.
- [ ] **Run `/speckit.specify` based on legacy evidence.** Never rely on memory.
- [ ] **Answer every `/speckit.clarify` question.** Record decisions.
- [ ] **Have the team approve the plan before `/speckit.tasks`.** The plan is a shared artifact.
- [ ] **Run `/speckit.analyze` and correct gaps before implementing.**
- [ ] **Every REQ-ID has `source_legacy:` or `[GREENFIELD] + justification`.**

---

## References

- [Official Spec-Kit repository](https://github.com/github/spec-kit)
- [Command cheat sheet](../09-cheat-sheets/spec-kit-workflow.md)
- [Stage 2 Guide](../02-spec-moderna/GUIDE.md)

---

### Continue reading

| Previous | Next |
|---|---|
| [Concepts Index](00-README.md)<br/><sub>What you will learn and in what order.</sub> | [Agents and Personas](02-agentes-e-personas.md)<br/><sub>The two context layers in Copilot Chat.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
