# @evolution — Stage 4: Evolution

> **Path:** [Team Kit](../../README.md) › [Stage Agents](../README.md) › **@evolution**

**The `@evolution` agent guides the team in turning Stage 3 local work into a reviewable delivery: well-written Issues for Copilot Agent mode, PR review, CI/CD records, and an experience report.**

| Field | Value |
|---|---|
| **Target audience** | Technical Lead (lead), DevOps Engineer, Tech Writer, Developer, and QA Engineer |
| **Prerequisites** | Stage 3 handoff with a working backend/frontend and relevant tests |
| **Estimated time** | 16:10–16:50 |
| **Stage** | Stage 4 — Evolution |
| **Expected outcome** | Issue created or drafted, PR reviewed or next step recorded, experience report completed |

![Stage 4](https://img.shields.io/badge/Stage-4%20%C2%B7%20Evolution-171717?style=flat-square)
![Operational approach](https://img.shields.io/badge/Approach-Operational-404040?style=flat-square)

---

## When to use

Use this agent when the prototype exists and the team needs to turn local work into a reviewable delivery: Issues, PRs, CI/CD, IaC, a runbook, and the final report.

- **Lead:** Technical Lead
- **Strong support:** DevOps Engineer, Tech Writer, Developer, and QA Engineer
- **Hard-gate prerequisite:** prototype with a working backend/frontend and relevant tests

---

## What the agent does

- Helps structure small, reviewable Issues for Copilot Agent mode
- Guides PR review with emphasis on bugs, risks, regressions, and missing tests
- Creates GitHub Actions workflows for build, test, and Terraform validation
- Converts individual commands into an operations runbook
- Produces the Agent mode experience report (`agent-experience-report.md`)

---

## What the agent does NOT do

- It does not delegate a vague Issue to Agent mode; it requires context, scope, and acceptance criteria
- It does not approve an AI-generated PR without explicit human review
- It does not create new features in Stage 4; it adds them to the backlog
- It does not hide pending work; it documents risks and records the next step

---

## Inputs

| Input | Location |
|---|---|
| Stage 3 backend/frontend | `backend/`, `frontend/` |
| Known pending work | Stage 3 handoff notes |
| Feature `spec.md` | `specs/<NNN>-<feature>/spec.md` |
| ADRs and technical plan | `02-modern-spec/` or `docs/adr/` |

---

## Expected outputs

| Artifact | Location |
|---|---|
| Issue for Agent mode | Repository GitHub Issues |
| PR review (if available) | GitHub Pull Requests |
| CI/CD workflow (if relevant) | `.github/workflows/` |
| Runbook (if relevant) | `docs/runbook/` |
| Agent experience report | `docs/agent-experience-report.md` |

---

## How to select the agent in Copilot Chat

- [ ] **Open Copilot Chat** in VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Select `@evolution`** from the agent selector.
- [ ] **Open the Stage 3 pending-work list** in the editor.
- [ ] **Paste the opening prompt** below and press Enter.

```text
I am starting Stage 4 — Evolution.
We have a prototype with a backend, frontend, and tests.
Help review a small Issue for Copilot Agent and record the delegation
outcome. Do not invent requirements, architecture, or criteria.
```

---

## Example prompts

| Situation | Useful prompt |
|---|---|
| Issue for Agent mode | "Write a small Issue with context, relevant files, acceptance criteria, and out-of-scope items." |
| PR review | "Review this PR, prioritizing bugs, risks, regressions, and missing tests." |
| CI/CD | "Create a GitHub Actions workflow for build, test, and Terraform validation." |
| Runbook | "Turn these commands into a runbook for a new operations team member." |
| Final report | "Write the `agent-experience-report` with what worked, what failed, and what we learned." |

---

## Definition of Done

- [ ] A small Issue was created or left as a reviewable draft with context, scope, and acceptance criteria.
- [ ] An available PR received human review; if no PR exists, the next step is documented.
- [ ] CI/IaC status was recorded without creating infrastructure only to meet a target.
- [ ] The Agent mode experience report is complete.

---

## Common mistakes

| Symptom | Cause | Correction |
|---|---|---|
| Agent mode produces an out-of-scope result | Vague Issue without explicit criteria | Rewrite the Issue with context, relevant files, and out-of-scope items |
| AI-generated PR merged without review | Excessive trust in the Agent result | Review it exactly as you would review a human PR |
| New feature appears at the end | Poor scope control | Add it to the backlog; do not implement it in Stage 4 |
| Pending work hidden to protect the demo | Fear of judgment | Document the risk and workaround; transparency is the goal |

---

### Continue reading

| Previous | Next |
|---|---|
| [@builder](../03-builder/README.md)<br/><sub>Stage 3: build the traceable implementation.</sub> | [Stage Agents — overview](../README.md)<br/><sub>Overview of the 4 agents and workshop schedule.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
