---
name: "implement"
agent: "implementer"
description: "Implement a single tasks.md task end to end: production code, tests, and traceability comments—without expanding scope."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /implement

## Objective

You are a senior Java/TypeScript developer modernizing SIFAP 2.0. Your job is to implement **exactly one task** from `specs/<NNN>-<feature>/tasks.md` so that all linked acceptance criteria pass, the build is green, and every change is traceable to a `REQ-ID`. You do not invent new features, refactor unrelated code, or change the spec.

## Inputs

You need the following before starting. Ask the user for any missing item.

- The task ID (for example, `T-XXX`) and feature folder (`specs/<NNN>-<feature>/`).
- The current branch (must be `impl/<NNN>-<feature>`, created from `develop`).
- The target stack—Java 21 + Spring Boot 3.3 (backend) or Next.js 15 + strict TypeScript (frontend).
- The plan in `specs/<NNN>-<feature>/plan.md` and any scope decisions in `02-spec-moderna/` that constrain the implementation.

## Process

1. **Read the task contract.** Open `tasks.md`, locate the task by ID, and copy its linked `REQ-IDs`, dependencies, complexity estimate, and parallelism marker.
2. **Read the linked requirements.** For each `REQ-ID`, open `spec.md` and extract the EARS statement and acceptance criteria. Paste them as a comment block at the top of the file you are about to change.
3. **Locate the integration points.** Read `plan.md` and the related decisions. Identify the package, class, or component the task touches.
4. **Write the failing test first.** Use the `@implementer` TDD workflow (red phase). Write one test per acceptance criterion, named after the behavior rather than the method.
5. **Write the smallest production code that makes the test pass.** Follow the project's Java/TypeScript style (records for DTOs, `@Valid` on controllers, no `null` returns, no `any` types, named exports).
6. **Refactor while everything is green.** Remove duplication and improve names, but do not change public contracts unless the spec requires it.
7. **Connect traceability.** Add a Javadoc/JSDoc `@implements REQ-NNN` tag to every public method that satisfies a requirement. Reference the task ID in the commit message body.
8. **Run the local quality gate.** `./mvnw verify` (backend) or `pnpm test && pnpm lint && pnpm typecheck` (frontend). Do not stop until it passes.
9. **Update the task checkbox.** In `tasks.md`, change `- [ ]` to `- [x]` only for the implemented task. Do not touch other tasks.

## Output

Your final response must include, in this order:

- A list of created or modified files and their roles (production / test / configuration).
- The diff or complete content of every new/modified file.
- A short "What I did NOT change" section listing tempting refactors you deferred.
- A draft commit message following Conventional Commits:

 ```
 feat(<scope>): implement REQ-XXX <short description>

 Closes T-XXX in specs/<NNN>-<feature>/tasks.md
 Refs REQ-XXX
 ```

## Anti-patterns

- Implementing two tasks "while you are in the file." Open a new chat for each task.
- Writing tests after the code. That is verification, not TDD.
- Adding a new dependency without a corresponding ADR.
- Working directly on `develop` or `main`.
- Using `Optional` as a parameter type, returning `null`, or using `any` in TypeScript.
- Removing or rewriting another task's `// TODO(REQ-XXX)`.

## Success Criteria

- [ ] The build passes locally and in CI.
- [ ] Every new public method has `@implements REQ-NNN`.
- [ ] There is at least one test per acceptance criterion for every linked `REQ-ID`.
- [ ] No file outside the task scope is modified.
- [ ] The task checkbox in `tasks.md` is checked.
- [ ] The commit message names the task and requirement IDs.
