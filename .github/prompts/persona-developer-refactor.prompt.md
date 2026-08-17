---
name: "refactor"
agent: "implementer"
description: "Refactor code with passing tests without changing observable behavior or breaking REQ-ID traceability."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /refactor

## Objective

You are improving the internal structure of SIFAP 2.0 code without changing what it does. A refactor that changes behavior is not a refactor—it is a feature change and belongs in `/implement` or `/fix-bug`. Your output must leave all existing tests passing and all `REQ-ID` links intact.

## Inputs

Ask the user for any missing item.

- The target file, package, or component.
- The motivation: the observed code smell (long method, duplication, primitive obsession, feature envy, etc.).
- Any constraints from `plan.md` or ADRs that limit your changes (for example, "controllers must remain thin").
- The area's current test coverage (run a coverage report if unknown).

## Process

1. **Confirm the safety net.** If the target's line coverage is below 80%, write characterization tests first. Refactoring without tests is rewriting.
2. **Name the smell precisely.** Choose from the catalog (Long Method, Large Class, Primitive Obsession, Data Clumps, Feature Envy, Shotgun Surgery, Divergent Change). Vague justifications such as "make it cleaner" are rejected.
3. **Choose a refactoring move from Fowler's catalog**—Extract Method, Extract Class, Replace Conditional with Polymorphism, Introduce Parameter Object, etc. One move per commit.
4. **Run tests before making any change.** Confirm they pass. If they fail or are skipped, fix that first; do not refactor broken builds.
5. **Apply the move.** Use IDE refactoring tools when possible (Extract Method, Rename, Move). Manual edits must preserve method signatures unless the move is "Change Function Declaration."
6. **Run tests after every micro-step.** Tests must remain green in every commit. If they fail, revert and take a smaller step.
7. **Preserve traceability.** Every `@implements REQ-NNN` annotation must move with its method. Do not delete or silently merge them.
8. **Stop when the smell is gone.** Resist the urge to refactor neighboring code. Each refactor is one chat, one PR, one smell.

## Output

Your final response must include:

- **Named smell** — the exact catalog entry plus 1–2 lines of evidence.
- **Chosen refactoring** — the exact catalog entry and why it fits.
- **Diff or before/after** for every touched file.
- **Test results** — confirmation that the same test set passes (paste the summary).
- **Behavior-preservation note** — "Public API unchanged. No new throws clauses. No DB migration. No new environment variables."
- **Commit message** following Conventional Commits with the `refactor:` type:

 ```
 refactor(<scope>): <short description>

 <describe the preserved behavior and structural improvement>

 Refs: REQ-XXX
 ```

## Anti-patterns

- Refactoring without tests. That is a rewrite by another name.
- Making "small improvements" to neighboring code. Stay within scope.
- Changing behavior under the guise of refactoring. If the output changes, it is not a refactor.
- Renaming public APIs without a migration plan or deprecation notice.
- Combining a refactor and feature in the same PR. Reviewers cannot reason about it reliably.
- Refactoring code with a pending `/fix-bug`—fix it first, then refactor from a clean baseline.

## Success Criteria

- [ ] All tests that passed before still pass with the same names.
- [ ] No public API changes, new exceptions, or new dependencies.
- [ ] Coverage does not decrease.
- [ ] One smell, one move, one PR.
- [ ] All `@implements REQ-NNN` annotations remain present and correct.
- [ ] The commit message uses the `refactor:` type and explicitly states "no behavior change."
