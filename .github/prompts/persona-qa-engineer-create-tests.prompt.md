---
name: "create-tests"
agent: "qa-engineer"
description: "Generate a complete test class for a single REQ-ID, including happy-path, boundary, and negative cases."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /create-tests

## Objective

You are writing the test class for **one specific `REQ-ID`** in SIFAP 2.0. You produce ready-to-paste JUnit 5 (Java) or Vitest (TypeScript) tests covering the happy path, boundaries, and negative cases—and stop there. You do not implement production code or modify the spec.

## Inputs

Ask the user for any missing information.

- The `REQ-ID`, its complete EARS statement, and its acceptance criteria in `specs/<NNN>-<feature>/spec.md`.
- The class or component under test.
- The test framework—JUnit 5 + AssertJ + Mockito (backend) or Vitest + Testing Library (frontend).
- Any existing test fixtures or builders to reuse (`src/test/resources/fixtures/`, `__fixtures__/`).

## Process

1. **Break the EARS statement into testable cases.**

- Ubiquitous (`The system shall ...`) → 1 happy path + 1 boundary.
- Event-driven (`When ...`) → 1 happy path + 1 negative case ("the event did not occur, so nothing should change").
- State-driven (`While ...`) → 1 case per state transition (in-state, exit-state, re-entry).
- Optional (`Where ...`) → 1 with the feature flag on, 1 with the flag off.
- Unwanted (`If ..., then the system shall not ...`) → at least 2 negative cases at different boundaries.

2. **Choose fixtures, not production data.** Reuse existing fixtures; never copy real PII.
3. **Name tests by behavior.** Use `should_<expected>_when_<condition>`, not `test1`. Use snake_case in TS test descriptions and camelCase in JUnit method names.
4. **Use Given/When/Then comments or AAA separation with blank lines.** Reviewers must be able to read the test in 10 seconds.
5. **Use AssertJ chains for rich assertions** (`assertThat(x).isEqualTo(y).as("REQ-XXX")`)—never `assertTrue(x.equals(y))`.
6. **Tag with the requirement.** Use `@Tag("REQ-XXX")` in JUnit or `describe('REQ-XXX', ...)` in Vitest.
7. **Mock only your own collaborators.** Repositories, yes; framework classes, no. Do not mock value objects or pure functions.
8. **Run the tests** and confirm that all fail with meaningful messages (until production code is written by `/implement`).

## Output

Your final response must include:

- **Test plan**—a table mapping each acceptance criterion to a test method name.
- **Complete test file content**—ready to paste into the project.
- **Fixture additions** if a new builder/factory is needed (separate file).
- **Execution instruction**—the exact command verified in the project.
- **Expected failure messages**—what the user should see before implementation.

## Anti-patterns

- Writing one giant test that exercises six cases. Split it.
- Asserting implementation details: private fields, exact SQL strings, or log-message text.
- Mocking the class under test or value objects.
- Sharing mutable fixture state across tests. Build fresh data for each test.
- Tests without a `REQ-ID` tag—they cannot be traced in the coverage-gap report.
- Skipping negative cases for unwanted-behavior EARS requirements. That is the core of the pattern.
- Using `Thread.sleep` or `await new Promise(r => setTimeout(r, 100))` for synchronization. Use Awaitility or `findBy*` matchers.

## Success Criteria

- [ ] Every acceptance criterion has at least one named test.
- [ ] At least one boundary or negative case is included.
- [ ] All tests carry the `REQ-ID` as a tag and in the assertion description.
- [ ] Tests fail before implementation, with clear messages and for the correct reason.
- [ ] No production code is changed.
- [ ] No real PII or production credentials appear in fixtures.
- [ ] The test file compiles and runs in isolation (`./mvnw test -Dtest=...`).
