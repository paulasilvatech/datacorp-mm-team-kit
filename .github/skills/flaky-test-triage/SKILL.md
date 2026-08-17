---
name: "flaky-test-triage"
description: "Use when a test is intermittent, when asked to investigate CI instability, to 'quarantine a flaky test', or to create a flaky-test dashboard."
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Flaky test triage

## When to invoke

- CI fails and the rerun passes.
- "This test is flaky - help me fix it."
- "Build a flaky-test quarantine process."

## Diagnostic workflow

1. **Reproduce**: run the test in isolation 50× with `--repeat-each 50` (Playwright) or `pytest --count=50`. If it fails <1×, it probably depends on execution order.
2. **Categorize** the root cause of the flake:

- **Async/timing** - missing await, race condition, hard-coded sleep
- **Order dependency** - shared state, database not cleaned, global singleton
- **External dependency** - network, clock, filesystem
- **Non-determinism** - iteration over an unordered map, random seed
- **Resource contention** - port, file lock, parallel worker collision

3. **Fix the root cause**: replace sleeps with explicit waits, isolate state, set random seeds, and use test-scoped ports.
4. **Quarantine if it cannot be fixed in <1 day**: move it to a `flaky/` tag, open a tracking issue, and set a 30-day SLA to fix or delete it.

## Quarantine policy

- Quarantined tests run, but do not fail the build.
- Delete anything quarantined for >30 days. A test that cannot be fixed is worse than no test.
- Dashboard: track the flake rate per test across 100 runs. Automatically quarantine anything above 5%.

## Anti-patterns

- `sleep(1000)` - always wrong.
- Repeating the assertion in a loop - hides timing bugs.
- `@Retry(3)` - masks flakes and rewards poor tests.

## References

- [Google - Flaky Tests at Google](https://testing.googleblog.com/2016/05/flaky-tests-at-google-and-how-we.html)
- [Microsoft Research - Empirical Study of Flaky Tests](https://www.microsoft.com/en-us/research/publication/an-empirical-analysis-of-flaky-tests/)
