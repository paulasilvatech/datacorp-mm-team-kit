# @builder — Stage 3: Implementation

> **Path:** [Team Kit](../../README.md) › [Stage Agents](../README.md) › **@builder**

**The `@builder` agent executes the Stage 2 specification, transforming EARS requirements into Java 21 + Spring Boot + Next.js 15 code with traceable tests and Flyway migrations.**

| Field | Value |
|---|---|
| **Target audience** | Developer (lead), Technical Lead, DBA, and QA Engineer during Stage 3 |
| **Prerequisites** | Stage 2 handoff with `spec.md`, `plan.md`, `tasks.md`, and a prioritized first increment |
| **Estimated time** | 15:00–16:10 |
| **Stage** | Stage 3 — Implementation |
| **Expected outcome** | Backend and frontend compile, tests pass, and commits include `Implements REQ-...` |

![Stage 3](https://img.shields.io/badge/Stage-3%20%C2%B7%20Implementation-171717?style=flat-square)
![Constructive approach](https://img.shields.io/badge/Approach-Constructive-404040?style=flat-square)

---

## When to use

Use this agent when the specification exists and the team needs to build. `@builder` does not replace design. It executes `spec.md`, `plan.md`, and `tasks.md` through code, tests, and traceability.

- **Lead:** Developer
- **Strong support:** Technical Lead, DBA, QA Engineer, and Software Architect
- **Hard-gate prerequisite:** `spec.md`, `plan.md`, and `tasks.md` exist, and the first increment is prioritized

---

## What the agent does

- Translates Natural/Adabas rules into Java 21 with REQ-ID traceability
- Generates JPA entities from Adabas DDMs and explains each mapping
- Creates `/api/v1/...` REST controllers with DTOs, Bean Validation, and OpenAPI annotations
- Writes JUnit 5 tests with Testcontainers for critical business rules
- Generates idempotent Flyway migrations
- Creates Next.js 15 App Router pages that consume REST endpoints

---

## What the agent does NOT do

- It does not write code without a REQ-ID referenced in the specification
- It does not create a new architecture; it follows the Stage 2 ADRs and technical plan
- It does not log CPF, benefit values, or any sensitive data
- It does not skip tests to move faster; at least the minimum test for the critical rule is mandatory

---

## Inputs

| Input | Location |
|---|---|
| Feature specification | `specs/<NNN>-<feature>/spec.md` |
| Technical plan | `specs/<NNN>-<feature>/plan.md` |
| Task list | `specs/<NNN>-<feature>/tasks.md` |
| Architecture ADRs | `02-spec-moderna/` or `docs/adr/` |
| Mapped DDMs | `01-arqueologia/business-rules-catalog.md` |

---

## Expected outputs

| Artifact | Location |
|---|---|
| Java 21 backend code | `backend/src/main/java/` |
| Flyway migrations | `backend/src/main/resources/db/migration/` |
| JUnit 5 tests | `backend/src/test/java/` |
| Next.js frontend code | `frontend/` |
| Traceable commits | Message: `Implements REQ-NNN: <short description>` |

---

## How to select the agent in Copilot Chat

- [ ] **Open Copilot Chat** in VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Select `@builder`** from the agent selector.
- [ ] **Open `tasks.md`** and identify the next task to implement.
- [ ] **Paste the opening prompt** below and press Enter.

```text
I am starting Stage 3 — Implementation.
We have spec.md, plan.md, tasks.md, ADRs, and a data model.
Help implement the next traceable task with Java 21 + Spring Boot,
PostgreSQL/JPA, and Next.js, starting with tests for business rules.
```

---

## Example prompts

| Situation | Useful prompt |
|---|---|
| JPA entity | "Generate the entity from this DDM and explain each mapping." |
| Natural rule | "Translate this rule into Java with clear names and an equivalence test." |
| REST controller | "Create `/api/v1/...` controller with DTOs, validation, and OpenAPI." |
| Frontend | "Create a Next.js App Router page that consumes this endpoint without exposing secrets." |
| Tests | "Write a JUnit test for REQ-NNN and add the traceability comment." |

---

## Definition of Done

- [ ] The backend compiles, and `mvn test` (or equivalent) passes.
- [ ] The frontend compiles, and `npm test` (or equivalent) passes when a frontend exists.
- [ ] The first feature increment works within the selected scope.
- [ ] An interface or endpoint exists only when the scope requires it.
- [ ] Flyway migrations apply without errors to a clean database.
- [ ] Tests cite REQ-IDs in inline comments.
- [ ] Commits that implement behavior mention `Implements REQ-...`.

---

## Common mistakes

| Symptom | Cause | Correction |
|---|---|---|
| Code without a REQ-ID | Task started without checking the specification | Return to `tasks.md` and find the corresponding requirement |
| New architectural decision in Stage 3 | Incomplete specification reached the builder | Pause, resolve it in Stage 2 with `@architect`, then resume |
| Test skipped because of time pressure | Delivery pressure | Write at least the minimum test for the critical rule before committing |
| CPF or value appears in logs | Data policy was overlooked | Mask logs; never log `cpf`, `valor`, or `beneficio` directly |

---

### Continue reading

| Previous | Next |
|---|---|
| [@architect](../02-architect/README.md)<br/><sub>Stage 2: modern specification with Spec-Kit.</sub> | [@evolution](../04-evolution/README.md)<br/><sub>Stage 4: delegate, review, and record the outcome.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
