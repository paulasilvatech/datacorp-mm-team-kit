# GitHub Copilot Instructions — Legacy Modernization Workshop

> These instructions tell Copilot what your team is building, which stack to use,
> which conventions to follow, and what NOT to do. They apply to the team's entire
> repository.

## Approved Tools — These Only

This workshop uses a **fixed toolchain**. Using anything else fragments the team and breaks the demos.

| Use these | Why |
|-----------|-----|
| **VS Code** (or VS Code Insiders) | The only editor for the entire team. |
| **GitHub Copilot** (Ask + Plan + Agent modes) | Primary AI assistant. Copilot Workspace is also allowed for Issue → PR delegation. |
| **GitHub Copilot CLI** *(optional)* | For terminal-based tasks. |
| **GitHub Spec-Kit** (`Specify CLI` + `/speckit.*`) | Official Spec-Driven Development toolkit for specification, planning, tasks, and implementation. |
| **GitHub** (Issues, PRs, Actions, Projects) | Source of truth for work, code, and CI. |
| **Docker / Docker Compose** | Local environment parity when the team creates containers in its own prototype. |
| **Terraform** | IaC (Azure provider). |

**Do not use** other AI assistants (Cursor, Windsurf, Codex, Cline, Continue, Aider, Codeium, Tabnine), alternative IDEs (IntelliJ, Eclipse, Neovim), web chat UIs to generate code, or alternative SDD frameworks (Kiro, etc.). Mixing tools breaks specification → code → test traceability.

## Project Context

Modernization of the 29-year-old Natural/Adabas **SIFAP** legacy system (Payment Inspection and Administration System) to Java 21 + Next.js 15. Legacy code is in [`01-archaeology/legacy-sifap/`](../01-archaeology/legacy-sifap/): 24 Natural members (12 `.NSP`, 5 `.NSN`, 2 `.NSC`, 2 `.NSA`, 1 `.NSL`, 2 `.jcl`) and 4 `.ddm` DDMs plus 1 FDT listing. The [`natural-programs/`](../01-archaeology/legacy-sifap/natural-programs/README.md) README documents the 15-assigned / 9-supporting split.

The kit uses **two agent layers** (one persona kit per person + one stage agent per team). See [`06-stage-agents/README.md`](../06-stage-agents/README.md) for details.

Use the skills in [`.github/skills/`](skills/) for specialized workflows. Copilot selects the relevant skill from its description; do not duplicate specialized workflows in these global instructions.

## Target Stack

- **Backend:** Java 21 + Spring Boot 3.3 + JPA/Hibernate + PostgreSQL 16
- **Frontend:** Next.js 15 (App Router) + TypeScript 5 (strict) + Tailwind CSS + shadcn/ui
- **Containers:** Docker + Docker Compose created by the team in Stage 3/4 when necessary
- **IaC:** Terraform (Azure provider ~> 3.x)
- **CI/CD:** GitHub Actions
- **Testing:** JUnit 5 + Testcontainers (backend); Vitest + Testing Library (frontend)

## Code Generation Rules

### Java

- Use Java 21 features: records for DTOs, sealed interfaces for discriminated unions, pattern matching, and virtual threads
- Use `Optional` correctly — never return `null` from public methods
- Use `@Transactional` only in the service layer, never in repositories
- Validate inputs in the controller layer with `@Valid` + Bean Validation
- Use English class names and comments
- Unit tests are mandatory for business logic
- Never expose sensitive data (CPF, benefit amounts) in logs — mask it

### TypeScript / Next.js

- Set `strict: true` in `tsconfig.json` — no exceptions
- Use server actions for mutations; never expose secrets in client components
- Prefer `async/await` over `.then()` chains
- Use named exports only — no default exports in component files

### REST APIs

- Path convention: `/api/v1/{resource}`
- Use HTTP verbs correctly (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`)
- Return appropriate status codes (`201` for creation, `204` for no content, `409` for conflict)
- Every endpoint must have OpenAPI/Swagger annotations

### Terraform

- Every resource must have `tags` including `project`, `environment`, and `owner`
- Store secrets only through `azurerm_key_vault_secret` — never in `locals` or `variables`
- Use one module per Azure service area (networking, compute, database, monitoring)
- `terraform fmt` and `terraform validate` must pass before commit

## Security Rules (OWASP Top 10)

- Validate inputs at every system boundary
- Never hardcode secrets, API keys, or credentials
- Use JPA/JPQL only for SQL queries — no string concatenation
- Configure CORS explicitly — no `*` wildcard in production
- Use OAuth2/JWT authentication (Spring Security in the backend)
- All Azure resources use Managed Identity for service-to-service authentication

## Spec-Driven Development (Spec-Kit)

- Every requirement uses **EARS notation** (Easy Approach to Requirements Syntax)
- Every requirement has a unique **REQ-ID** in the `REQ-NNN` format
- **Every requirement includes a `source_legacy:` line** pointing to `01-archaeology/legacy-sifap/natural-programs/*.{NSP,NSN,NSS,NSA,NSL,NSC,NSM,jcl}`, `01-archaeology/legacy-sifap/adabas-ddms/*.{NSD,ddm,txt}`, or `[GREENFIELD] + justification`. The `legacy-traceability` CI job rejects PRs that violate this rule. See [`01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md`](../01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md).
- Tests trace to REQ-IDs through inline comments
- Branch strategy: one prefix per persona/stage, each cut from `develop` (never from `spec/*`) and merged back `develop` → `main` (there is no `stage` branch): `spec/<NNN>-<feature>` (RE + SA, Stage 2), `impl/<NNN>-<feature>` (Dev + DBA + QA, Stage 3), `infra/<component>` (DevOps, Stage 4), `docs/<topic>` (Tech Writer), `agent/<issue-NN>` (Copilot Agent). Do not collapse `impl/` — or any other prefix — into `spec/`. Full per-persona table: [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md)
- Before writing EARS requirements in Stage 2, the pair MUST have read their assigned Natural programs (HARD GATE — see the checklist above)

## Strict Rules — Do Not Do This

- ❌ Do not assume a pre-existing application prototype or inherited containerization. `backend/` and `frontend/` do not exist yet — the team creates them from scratch in Stage 3. `infra/` **does** exist (it holds the Adabas/Natural lab in [`infra/adabas-natural-lab/`](../infra/adabas-natural-lab/) and [`infra/bootstrap/`](../infra/bootstrap/)); extend it, do not recreate it.
- ❌ Do not write an EARS requirement without `source_legacy:` — CI will reject the PR
- ❌ Do not add dependencies without justification in an ADR
- ❌ Do not write tests after the fact — write them during implementation
- ❌ Do not expose secrets in commit messages, logs, or PR descriptions
- ❌ Do not merge into `main` without at least one peer review
- ❌ Do not skip guided handoff conversations during stage transitions (see [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md))
- ❌ Do not create a root `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md`. This file is the single source of truth for repo-wide agent instructions; every Copilot surface that reads `AGENTS.md` also reads this file, and this file outranks it in precedence — a second file only adds drift risk. See [`docs/adr/0001-agent-instructions-single-source-of-truth.md`](../docs/adr/0001-agent-instructions-single-source-of-truth.md).
- ❌ Do not add or edit a Copilot primitive (agent, prompt, instruction, skill, or hook) that does not follow [`PRIMITIVE-STANDARD.md`](PRIMITIVE-STANDARD.md); the `copilot-primitives` CI job enforces its structure.

## References

- Schedule + pairs: [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md)
- Git workflow: [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md)
- Copilot's 3 modes (Ask · Plan · Agent): [`09-cheat-sheets/copilot-3-modes.md`](../09-cheat-sheets/copilot-3-modes.md)
- Persona kits (read 2 per person; active artifacts are already consolidated in `.github/`): [`05-personas/`](../05-personas/)
- Stage agents: [`06-stage-agents/`](../06-stage-agents/)
- How every Copilot primitive is structured: [`PRIMITIVE-STANDARD.md`](PRIMITIVE-STANDARD.md) — the agent, prompt, instruction, skill, and hook standard the `copilot-primitives` CI job enforces.
- SIFAP legacy system: [`01-archaeology/legacy-sifap/`](../01-archaeology/legacy-sifap/)
- Modern prototype: the team creates `backend/` and `frontend/` during Stage 3 (neither exists yet); there is no ready-made application codebase to copy. `infra/` already exists (Adabas/Natural lab) and is extended, not created.
- Known agent failures + the guardrail that catches each recurrence: [`docs/failures/README.md`](../docs/failures/README.md) — read it before finishing and add an entry whenever a mistake recurs.
- Spec-Kit SDD: <https://github.com/github/spec-kit>
