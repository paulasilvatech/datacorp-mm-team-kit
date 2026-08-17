---
name: "tdd"
agent: "implementer"
description: "Drive a feature through a rigorous red-green-refactor TDD cycle: one failing test, the smallest passing code, and then refactoring."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /tdd

## Objective

You will produce a complete TDD cycle for a single behavior in SIFAP 2.0. The deliverable is three separate commits—`red`, `green`, and `refactor`. No production code is written without a failing test, and no test is written to pass immediately.

## Inputs

Ask the user for anything that is missing.

- The behavior to discover, in plain language.
- The linked `REQ-ID` in `specs/<NNN>-<feature>/spec.md`.
- The target file or class. If it does not exist, say so—TDD also guides design, so creating it is acceptable.
- The test framework—JUnit 5 + AssertJ for Java, or Vitest + Testing Library for TypeScript.

## Process

Execute exactly three phases. Do not combine them.

### Phase 1 — RED (write the failing test)

1. Choose the **simplest non-trivial case** for the behavior. Not the empty case or the catastrophic case—the smallest case that exercises real logic.
2. Name the test after the behavior, not the method: `should_<expected>_when_<condition>`, not `test1`.
3. Use Given/When/Then or Arrange/Act/Assert structure, with blank lines between sections.
4. Run the test. Confirm that it fails. Read the failure message and confirm that it fails for the expected reason (compilation error or assertion mismatch—not a setup error).
5. Commit: `test(<scope>): red — <short behavior description>`.

### Phase 2 — GREEN (smallest code that passes)

6. Write the **smallest amount of production code** that makes the test pass. "Fake it till you make it" is allowed: returning a fixed value is acceptable in the first cycle.
7. Run the single test. Confirm it passes. Run the full suite. Confirm it remains green.
8. Commit: `feat(<scope>): green — implement REQ-XXX (minimal)`.

### Phase 3 — REFACTOR (improve while everything is green)

9. Look for duplication, misleading names, and primitive obsession. Apply one small Fowler move (Extract Method, Inline Variable, Rename).
10. Run all tests after every micro-step. They must remain green.
11. Stop when the design is good enough for the next cycle, not perfect.
12. Commit: `refactor(<scope>): <short description>`.

## Output

Your final response must include:

- **The discovered behavior** — one sentence.
- **The three commits** — message, touched files, and test result for each.
- **The test file** — complete content.
- **The production code** — complete content after the refactoring phase.
- **Next-cycle hint** — which test you would write next (boundary, error, second variation). Do not implement it.

## Anti-patterns

- Writing the test and code together. That is verification, not TDD.
- Skipping the refactoring phase. Most of the design value lives there.
- Having two failing tests at the same time. One red at a time.
- Testing private methods. Test through the public interface.
- Writing one giant first test that covers six cases. Take smaller steps.
- Mocking everything. A test that mocks every collaborator tests nothing.
- "Refactoring" by changing behavior. If the test changes, you cheated.

## Success Criteria

- [ ] There are three separate commits: `test:` (red), `feat:` (green), and `refactor:`.
- [ ] The red commit is reproducibly red—you can check it out and the build fails.
- [ ] The green commit is the minimum needed to pass—one method, with a fixed value if necessary.
- [ ] The refactor commit changes structure, not behavior. Test names and assertions remain unchanged.
- [ ] The full suite is green at the end.
- [ ] The discovered behavior maps exactly to one acceptance criterion of a `REQ-ID`.
