---
name: "test-strategy"
description: "Use when asked to design a test strategy, choose the shape of the test pyramid, define coverage targets, or evaluate testing investments across the unit / integration / E2E layers."
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Test Strategy Designer

## When to invoke

- "Design a test strategy for…"
- "How much unit vs integration vs E2E testing?"
- "What coverage target is right?"
- "Audit our test pyramid."

## Workflow

1. **Inventory** the code under test: modules, public APIs, external integrations, and critical paths.
2. **Classify risk** by module (P0 / P1 / P2) based on the blast radius if it fails.
3. **Allocate the pyramid**: target 70% unit, 20% integration, and 10% E2E as a starting point; justify deviations.
4. **Define coverage targets**: a baseline of 80% line coverage, 90% for P0 modules, with branch coverage tracked separately.
5. **Define the flaky-test budget**: a maximum flaky rate of 1%; anything above it triggers quarantine.
6. **Choose tools by layer**: unit (Vitest/JUnit/pytest), integration (Testcontainers), E2E (Playwright).
7. **Output**: a one-page strategy document with per-layer targets, tools, coverage thresholds, and quarantine rules.

## Heuristics

- If an E2E test can be rewritten as an integration + contract test, do it—E2E is expensive and flaky.
- Contract tests beat mocks for anything that crosses a service boundary.
- Mutation testing (Stryker, PIT) is the only honest way to detect tests that prove nothing.

## References

- [Google Testing Blog - Test Sizes](https://testing.googleblog.com/2010/12/test-sizes.html)
- [ISTQB Foundation Syllabus](https://www.istqb.org/certifications/certified-tester-foundation-level)
- [Martin Fowler - Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
