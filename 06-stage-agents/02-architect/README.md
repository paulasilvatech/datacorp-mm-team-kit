# @architect — Stage 2: Specification

> **Path:** [Team Kit](../../README.md) › [Stage Agents](../README.md) › **@architect**

**The `@architect` agent transforms evidence collected in Stage 1 into a traceable modern specification, using GitHub Spec-Kit to produce `spec.md`, `plan.md`, and `tasks.md`.**

| Field | Value |
|---|---|
| **Target audience** | Architecture pair (Enterprise Architect + Software Architect) during Stage 2 |
| **Prerequisites** | Stage 1 handoff with a rule catalog and available `source_legacy:` entries |
| **Estimated time** | 14:00–15:00 |
| **Stage** | Stage 2 — Specification |
| **Expected outcome** | `spec.md`, `plan.md`, and `tasks.md` in `specs/<NNN>-<feature>/`, approved by the Product Owner |

![Stage 2](https://img.shields.io/badge/Stage-2%20%C2%B7%20Specification-171717?style=flat-square)
![Analytical approach](https://img.shields.io/badge/Approach-Analytical-404040?style=flat-square)

---

## When to use

Use this agent after the team has legacy discoveries and needs to transform them into a modern specification. `@architect` helps define bounded contexts, write EARS requirements, record ADRs, and prepare for implementation.

- **Lead:** Software Architect
- **Strong support:** Requirements Engineer, Enterprise Architect, Product Owner, and Technical Lead
- **Hard-gate prerequisite:** Stage 1 evidence with `source_legacy:` for every rule

---

## What the agent does

- Transforms cataloged business rules into EARS requirements with `source_legacy:`
- Compares bounded context alternatives and identifies pros and cons
- Generates ADRs with context, options, decision, consequences, and risks
- Runs `/speckit.specify`, `/speckit.clarify`, and `/speckit.plan` guided by the specification
- Identifies specification gaps before implementation

---

## What the agent does NOT do

- It does not accept a requirement without legacy evidence or a `[GREENFIELD]` rationale
- It does not write implementation code (that is the `@builder` role)
- It does not fill ambiguous fields or flows without explicit resolution
- It does not decide scope without Product Owner validation

---

## Inputs

| Input | Location |
|---|---|
| Stage 1 rule catalog | `01-archaeology/business-rules-catalog.md` |
| Dependency map | In the catalog or a separate Mermaid file |
| Open questions | Catalog section |
| Legacy exploration checklist | `01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md` |

---

## Expected outputs

| Artifact | Location |
|---|---|
| Feature specification | `specs/<NNN>-<feature>/spec.md` |
| Technical plan | `specs/<NNN>-<feature>/plan.md` |
| Implementable task list | `specs/<NNN>-<feature>/tasks.md` |
| Supporting scope decisions | `02-modern-spec/` (support only, not a second specification location) |

---

## How to select the agent in Copilot Chat

- [ ] **Open Copilot Chat** in VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Select `@architect`** from the agent selector.
- [ ] **Open the Stage 1 rule catalog** in the editor.
- [ ] **Paste the opening prompt** below and press Enter.

```text
I am starting Stage 2 — Specification.
We have a discovery report, rule catalog, glossary, DDMs, and dependency map.
Help transform confirmed evidence into `spec.md`, `plan.md`, and
`tasks.md` for a thin feature. Do not fill requirements or architecture
without a source, and record open questions separately.
```

---

## Example prompts

| Situation | Useful prompt |
|---|---|
| Raw business rule | "Confirm the source of this rule before proposing an EARS requirement with `source_legacy:`." |
| Uncertain bounded context boundary | "Compare 2 or 3 possible bounded contexts and show pros and cons." |
| Architectural decision | "Generate an ADR with context, options, decision, consequences, and risks." |
| Technical plan | "Prepare `/speckit.plan` considering a Modular Monolith, JPA, and PostgreSQL." |

---

## Definition of Done

- [ ] `spec.md`, `plan.md`, and `tasks.md` exist in `specs/<NNN>-<feature>/`.
- [ ] Every requirement has `source_legacy:` pointing to `.NSN` or `.ddm`, or `[GREENFIELD]` with a rationale.
- [ ] Supporting scope decisions are in `02-modern-spec/`.
- [ ] The Product Owner reviewed and approved the scope during the 15:00 handoff.

---

## Common mistakes

| Symptom | Cause | Correction |
|---|---|---|
| Requirement without `source_legacy:` | Rule inferred without legacy evidence | Return to the Stage 1 catalog and find the line reference |
| Architecture is too complex for the available time | Ambition exceeds workshop scope | Prefer simple, testable decisions that can be implemented in one hour |
| ADR mixed with unstructured opinion | The record lacks structure | Use the template: context, options, decision, consequences |
| Specification has no acceptance criterion | Requirement is not testable | Every requirement needs at least one verifiable scenario |

---

### Continue reading

| Previous | Next |
|---|---|
| [@archaeologist](../01-archaeologist/README.md)<br/><sub>Stage 1: read the Natural/Adabas legacy system.</sub> | [@builder](../03-builder/README.md)<br/><sub>Stage 3: build the traceable implementation.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
