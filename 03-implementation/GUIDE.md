# Stage 3 — Implementation (70 min)

> **Path:** [Team Kit](../README.md) › [Stage 3](README.md) › **GUIDE**

**This guide leads Pairs 3 and 4 through building the functional SIFAP 2.0 prototype, from the initial skeleton to features implemented with tests, migrations, and traceability to REQ-IDs.**

![Stage 3](https://img.shields.io/badge/Stage-3%20%C2%B7%20Implementation-171717?style=flat-square) ![Duration 70 min](https://img.shields.io/badge/Duration-70%20min-737373?style=flat-square) ![Time 15:00–16:10](https://img.shields.io/badge/Time-15%3A00--16%3A10-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Pair 3 (TL + Developer) and Pair 4 (DBA + QA) lead; Pair 5 scaffolds CI |
| **Prerequisites** | H2 handoff accepted; `spec.md`, `plan.md`, and `tasks.md` ready with REQ-IDs and `source_legacy:` |
| **Estimated time** | 70 min |
| **Stage** | Stage 3 — Implementation |
| **Expected outcome** | Functional backend and frontend; passing tests; commits with `Implements REQ-XXX` |

> [!IMPORTANT]
> See the exact schedule in [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md). The badges show only the stage duration.

---

## Concept: Modular Monolith

A Modular Monolith is an architecture in which bounded contexts are independent Java modules within a single JVM, with explicit boundaries between them. It is the recommended starting point for modernizing SIFAP before any future microservice extraction.

**Why it matters:** the legacy SIFAP has implicit coupling between modules through shared memory (Natural/Adabas). The Modular Monolith makes this coupling explicit and controlled. Each module exposes only the interface that other modules need.

**Strangler Fig:** a migration pattern that gradually surrounds the legacy system. The Stage 3 prototype does not need to replace all of SIFAP. Modernize one bounded context at a time while keeping the legacy system active for parts that have not yet migrated.

---

## Concept: Testcontainers

Testcontainers is a Java library that starts real Docker containers during tests. Instead of simulating PostgreSQL with an in-memory database (H2), tests use the actual production database engine.

**Why it matters:** tests against H2 can pass and then fail against PostgreSQL because of differences in SQL, types, and transaction behavior. Testcontainers removes this divergence.

**Common mistake:** forgetting to start Docker Desktop before running `./mvnw test`. The error is `Could not find a valid Docker environment`.

---

## Concept: TDD (Test-Driven Development)

TDD is the practice of writing the test before the implementation. The cycle is: write a failing test (red), implement the minimum code needed to pass (green), and improve the code without breaking the test (refactor).

**In SIFAP:** before implementing the benefit adjustment calculation (REQ-042), write a test that validates the acceptance criteria defined in `spec.md`. The test fails until the logic is implemented.

---

## Definition of Ready — before starting

> [!IMPORTANT]
> Confirm every item before starting this stage:

- [ ] The PO accepted the H2 handoff.
- [ ] The `@builder` persona is selected in Copilot Chat.
- [ ] `specs/<NNN>-<feature>/spec.md` has REQ-IDs with valid `source_legacy:` entries.
- [ ] `specs/<NNN>-<feature>/plan.md` contains the decisions needed for the first task.
- [ ] The team defined the prototype's initial paths (`backend/`, `frontend/`, and, if needed, `infra/`).
- [ ] Branch `impl/<NNN>-<feature>` was created from the updated `develop` branch.

---

## Objective

Create the first functional SIFAP 2.0 prototype from scratch and implement the features prioritized in Stage 2. The kit provides no codebase, ready-made containerization, or prototype symlink. The team creates the structure, implements features, and writes tests. Every feature must trace to a REQ-ID.

Stage 3 is where the specification meets reality. A well-written EARS requirement from Stage 2 becomes a test that either passes or fails. Every commit includes an `Implements REQ-XXX:` reference in the message. Without it, traceability ends.

---

## First 15 minutes: creating the skeleton

### Step 1 — Create the prototype folders

```bash
mkdir -p backend frontend
```

### Step 2 — Create the minimum structure

- **Backend:** Spring Boot 3.3, Java 21, Maven Wrapper, and base package `br.gov.sifap`.
- **Frontend:** Next.js 15 App Router, strict TypeScript, and Tailwind CSS.
- **Database:** Flyway migrations in `backend/src/main/resources/db/migration/`.

> [!CAUTION]
> Do not use code or containerization from external prototypes. The workshop goal is for the team to build the modern prototype from its reading of the legacy system.

### Step 3 — Verify that the minimum setup runs

- Backend: `cd backend && ./mvnw test` shall pass as soon as the skeleton exists.
- Frontend: `cd frontend && npm test` (or the team-defined command) shall pass.
- Create `infra/` only when the team starts describing IaC or local composition.

---

## Backend structure

```text
src/main/java/br/gov/client/sifap/
└── <feature>/
    ├── domain/
    ├── application/
    └── infrastructure/
```

### Layers (inside out)

| Layer | Responsibility | Examples |
|---|---|---|
| **domain** | Pure business rules with no framework dependency | Status enums, repository interfaces, value objects |
| **application** | Use cases and orchestration | Services, request/response DTOs |
| **infrastructure** | Technical details and I/O | REST controllers, JPA entities, Spring Data repositories |

> [!IMPORTANT]
> The `domain` layer never imports classes from `infrastructure`. The flow is always Controller → Service → Repository (interface in domain, implementation in infrastructure).

---

## Step by step: add a feature

- [ ] **Reread the EARS requirement.** Open `spec.md` and reread the REQ-ID to implement.
- [ ] **Verify the legacy evidence.** Confirm `source_legacy:` and reread the corresponding `.NSN` program.
- [ ] **Model the behavior.** Define the entity, use cases, and REST contracts in the correct context.
- [ ] **Create the Flyway migration.** Add `V<N>__description.sql` in `db/migration/`.
- [ ] **Write the test first.** Create the integration test before implementing (TDD).
- [ ] **Implement the code.** Controller → Service → Repository, following the layers.
- [ ] **Run the tests.** `./mvnw test` shall pass with Docker running.
- [ ] **Commit the change.** Include `Implements REQ-XXX` in the message.

> [!CAUTION]
> Use Flyway. Never modify existing migrations. Always create new ones (`V2__`, `V3__`, and so on). Editing an old migration corrupts the schema history and breaks deployments.

---

## Flow with Copilot Plan

To implement features with traceability:

1. Select the relevant files in VS Code (Ctrl+click).
2. Open Copilot in Plan mode.
3. Describe the change in natural language and request a plan before execution:
   > "Plan the implementation of EARS `REQ-XXX`. List the files involved, risks, and required tests. Do not implement yet."
4. Review the plan and diff before accepting them. Verify that they follow the architecture.
5. Run the tests to confirm.

> [!TIP]
> Prefer Plan mode for small features. Copilot Agent mode is better suited to Stage 4, which grants greater scope autonomy.

---

## Tests

### Run all tests

```bash
cd backend
./mvnw test
```

**Prerequisite:** Docker must be running. The tests use Testcontainers to start a real PostgreSQL instance.

### Expected test types

| Type | Class | What it tests |
|---|---|---|
| Unit | `*ServiceTest.java` | Isolated business logic |
| Integration | `*ControllerTest.java` | Complete endpoint (HTTP → DB) |
| Repository | `*RepositoryTest.java` | Custom queries |

---

## Frontend

### Run the frontend locally

```bash
cd frontend
npm install
npm run dev
```

Open `http://localhost:3000`.

### Frontend architecture

The frontend uses Next.js 15 with App Router and Server Components:

```text
src/app/
├── layout.tsx
├── page.tsx
└── <feature>/
    └── page.tsx
```

| Component type | When to use it |
|---|---|
| **Server Component** (default) | Server-side data fetching; no client-side JavaScript |
| **Client Component** (`"use client"`) | Interactivity: forms, modals, and local state |

---

## Traceability: requirement → code → test

Document traceability for every implemented feature:

| EARS requirement | Implementation file | Test file |
|---|---|---|
| `REQ-XXX` | `<!-- fill in -->` | `<!-- fill in -->` |

Every commit that implements specification behavior must include `Implements REQ-XXX` in the message. This closes the specification → code → test cycle and allows `/speckit.analyze` to detect drift.

---

<details>
<summary><strong>Common pitfalls — expand</strong></summary>

| If you are doing this | Do this instead |
|---|---|
| One enormous eight-hour branch | Use small commits and small PRs. One feature = one PR |
| Implementing without tests and planning to "do them later" | Write the test with the code |
| Editing an old Flyway migration | Never do this. Always create a new migration (`V5__`, `V6__`...) |
| Creating an endpoint without `@Valid` on the DTO | Always use Bean Validation in the controller |
| Mixing domain logic into the controller | The controller calls a service. Logic belongs in the service or domain |
| Importing infrastructure classes between contexts | Preserve the boundaries defined by the team |
| Committing without `Implements REQ-XXX` | Traceability validates the work from the previous stage |

</details>

---

<details>
<summary><strong>Troubleshooting — expand</strong></summary>

| Problem | Solution |
|---|---|
| Local environment does not start | Check Java 21, Node, environment variables, and whether ports 5432/8080/3000 are free |
| Backend cannot connect to PostgreSQL | Check the configured URL and whether the team's selected PostgreSQL instance is running |
| Frontend shows "Failed to load" | Is the backend running? Test with `curl http://localhost:8080/actuator/health` |
| Testcontainers test fails | Docker Desktop must be running. Alternative: a unit test with Mockito |
| Migration fails at startup | Never edit an existing migration. Create a new one (`V5__`, `V6__`...) |
| `mvn test-compile` import error | Verify that the package follows `domain/` → `application/` → `infrastructure/` |
| Swagger UI does not appear | Try `http://localhost:8080/swagger-ui/index.html` |

</details>

---

## Completion criteria

- [ ] The team-prioritized flow is implemented and documented.
- [ ] The interface required for that flow is available.
- [ ] Team-defined tests pass with `./mvnw test`.
- [ ] Local execution is documented in the prototype.
- [ ] Exposed contracts are documented with Swagger/OpenAPI.
- [ ] The prioritized Stage 1 rule is implemented and tested.
- [ ] Every commit includes `Implements REQ-XXX` in the message.

---

## Next step

During the H3 handoff (around 17:00), Pair 3 delivers working code to Pair 5 (Operations), which handles Terraform and CI/CD in Stage 4. Pair 4 continues final testing.

See [`../04-evolucao/GUIDE.md`](../04-evolucao/GUIDE.md) for the next stage.

---

<details>
<summary><strong>Useful prompts for Copilot Chat — expand</strong></summary>

1. "Create a REST endpoint for [feature] following the existing architecture."
2. "Write an integration test for the [endpoint] endpoint."
3. "Add Bean Validation to the [class] DTO."
4. "Create a Flyway migration to add [table/column]."
5. "Implement business rule BR-XXX: [rule description]."
6. "Create a React Server Component to list [entity]."
7. "Add error handling for [scenario]."
8. "Refactor this service to separate [responsibility] logic."

</details>

> [!TIP]
> Do not try to implement everything. Focus on quality over quantity. One well-built endpoint with tests, validation, and documentation is worth more than five broken endpoints.

---

### Continue reading

| Previous | Next |
|---|---|
| [Stage 2 — Specification](../02-spec-moderna/GUIDE.md)<br/><sub>14:00–15:00 · Write EARS requirements, ADRs, and C4 diagrams.</sub> | [Stage 4 — Evolution](../04-evolucao/GUIDE.md)<br/><sub>16:10–16:50 · Copilot Agent + Terraform + CI/CD.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
