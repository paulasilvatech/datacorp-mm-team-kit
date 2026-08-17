---
name: "test-strategy"
description: "Use when designing a test strategy, choosing the test-pyramid shape, defining coverage targets, or evaluating testing investments across unit, integration, and E2E layers. Triggers include \"test strategy\", \"test pyramid\", \"coverage target\", \"E2E vs integration\", and \"testing investment\"."
---
# Test strategy

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

## Anti-patterns

- Inverted pyramid: many slow E2E tests sitting on top of few unit tests.
- One global coverage number with no higher target for P0 modules.
- Mocked service boundaries that never catch a real integration break.
- Coverage treated as the goal instead of a proxy for confidence.

## Output template

```markdown
## Test strategy - <system or module>

| Layer | Target mix | Tools | Coverage target |
|---|---|---|---|
| Unit | 70% | JUnit 5 / Vitest | 80% line (90% for P0) |
| Integration | 20% | Testcontainers | critical paths |
| E2E | 10% | Playwright | top user journeys |

**Flaky-test budget**: <=1% (quarantine above)
**Risk classification**: P0 <modules> / P1 <modules> / P2 <modules>
```

## Quality gate

- [ ] Every module is risk-classified (P0/P1/P2) with a coverage target.
- [ ] The pyramid mix is set per layer, and deviations from 70/20/10 are justified.
- [ ] Each layer names its tool and threshold.
- [ ] A flaky-test budget and quarantine rule are defined.

## References

- [Google Testing Blog - Test Sizes](https://testing.googleblog.com/2010/12/test-sizes.html)
- [ISTQB Foundation Syllabus](https://www.istqb.org/certifications/certified-tester-foundation-level)
- [Martin Fowler - Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
