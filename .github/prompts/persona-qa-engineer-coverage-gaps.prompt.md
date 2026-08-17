---
name: "coverage-gaps"
agent: "qa-engineer"
description: "Find REQ-IDs without tests, missing edge cases, and gaps between spec.md acceptance criteria and the test suite."
tools: ["search", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /coverage-gaps

## Objective

You are a QA Engineer auditing test coverage in SIFAP 2.0. Your output is a prioritized list of **untested or insufficiently tested requirements**—not a percentage. Line coverage is a vanity metric; requirement coverage is the truth.

## Inputs

Ask the user for any missing information.

- The feature folder (`specs/<NNN>-<feature>/`) and implementation folders (`backend/src/main/java/...` and/or `frontend/app/...`).
- A recent coverage report (JaCoCo XML for the backend, Vitest LCOV for the frontend)—or permission to generate one.
- The acceptance scope: "all REQ-IDs in this folder," "only this PR's diff," or "only the regulatory `REQ-COMP-*` set."

## Process

1. **Build the requirements inventory.** Parse `spec.md` and extract each `REQ-ID` with its EARS pattern and acceptance criteria.
2. **Find tests by `REQ-ID`.** Grep test sources for `REQ-NNN`, `@implements REQ-NNN`, `@Tag("REQ-NNN")`, or naming conventions such as `Req014_*`. List every occurrence.
3. **Map test → requirement.** For each `REQ-ID`, list the tests covering it. Mark it `MISSING` if none exist, `WEAK` if there is only one happy-path test, or `OK` if there is a happy path plus at least one boundary or error case.
4. **Inspect EARS variants for hidden cases.** Event-driven and unwanted-behavior (`If ...`) requirements almost always need a negative test. State-driven (`While ...`) requirements need a state-transition test.
5. **Cross-check against the legacy system.** For requirements mapped to a
   Natural program in `01-arqueologia/legado-sifap/natural-programs/`, confirm
   that the edge cases identified by the team are covered.
6. **Score by risk.** Combine probability (how often it is exercised in production) and impact (financial, regulatory, security) on a 1–3 scale for each item. Risk = probability × impact.
7. **Deliver the prioritized gap list.** Put the highest risk first. Include a one-line test recipe for each gap, not the test code itself.

## Output

A Markdown report with the following structure:

```markdown
## Coverage Gap Report — <feature>

### Summary
- Requirements in scope: <count>
- OK: <count> — WEAK: <count> — MISSING: <count>
- Highest-risk gap: <REQ-ID and behavior, if any>

### Gaps by risk

| REQ-ID | EARS Pattern | Status | Risk (P×I) | Recipe |
|--------|-------------|--------|-----------|--------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

### Legacy-derived edge cases still uncovered
- <!-- fill in with source, scenario, and REQ-ID -->

### Suggested test additions
1. `<class>#<testName>`
2. `<class>#<testName>`
```

## Anti-patterns

- Reporting only line-coverage percentages. Covered lines ≠ verified behaviors.
- Counting redundant happy-path tests as "covered." A `REQ-ID` with five "should work" tests and zero "should not" tests is WEAK.
- Listing gaps without risk scores. Triage requires risk.
- Suggesting fixes that inspect implementation details (private methods, SQL strings).
- Ignoring requirements mapped to legacy Natural programs—they hide most edge cases.
- Treating UI snapshot tests as UX requirement coverage. They cover rendering, not behavior.

## Success Criteria

- [ ] Every in-scope `REQ-ID` appears in the report exactly once.
- [ ] Each gap has a risk score and a one-line test recipe.
- [ ] Negative/unwanted-behavior EARS requirements without a negative test are flagged as WEAK or MISSING.
- [ ] Legacy-derived edge cases are explicitly checked against `01-arqueologia/legado-sifap/natural-programs/`.
- [ ] The top three gaps have actionable test names ready for assignment.
- [ ] The output is ready to paste into a sprint-planning ticket.
