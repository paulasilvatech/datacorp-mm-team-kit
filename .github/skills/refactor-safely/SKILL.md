---
name: "refactor-safely"
description: "Use when refactoring legacy code, extracting a service, or making behavior-preserving changes. Triggers include \"refactor\", \"legacy code\", \"strangler fig\", \"characterization test\", and \"mikado method\"."
---
# Refactor safely

## When to invoke

- When working on code without sufficient tests.
- When splitting a monolith or extracting a service.
- When a change is "one line" but touches a risky path.

## First rule

**Refactoring preserves behavior.** If you cannot prove that behavior was preserved, it is not refactoring—it is a rewrite. Put characterization tests in place first.

## Workflow

1. **Characterize** - write tests that lock in current behavior, including quirks. Do not fix bugs yet; the goal is a safety net, not a correction.
2. **Take small, reversible steps** - apply one behavior-preserving transformation at a time. Commit after each one.
3. **Keep it green** - run tests after every step. Revert immediately if they turn red and you do not know why.
4. **Separate refactoring commits from behavior-change commits** - reviewers can focus, and bisect remains useful.
5. **Integrate frequently** - long-lived refactoring branches decay.

## Patterns

### Strangler Fig (for systems)

1. Put a facade (proxy, router, feature flag) in front of the old system.
2. Route a thin slice of traffic to the new implementation.
3. Grow the new implementation slice by slice while shrinking the old one.
4. Delete the old implementation when its traffic reaches zero.

### Mikado Method (for code)

1. Write down the goal.
2. Attempt it naively; record what breaks as **prerequisites**.
3. Revert. Address one prerequisite first. Recurse.
4. Complete the leaves first; achieve the original goal last.

### Branch by Abstraction

Introduce an interface, migrate callers to it, swap implementations, and retire the old one—all without a long-lived branch.

## Characterization tests - how

- Run the code with representative inputs and record the output (golden files / snapshot tests).
- Prefer observing from the outside (HTTP, CLI, database state)—this is resilient to internal refactoring.
- Cover unusual cases too; they are the ones that break.
- Accept that some behaviors are *bugs you are now preserving*. Mark them, then fix them after the safety net is in place.

## Antipatterns

- "Refactor" PRs that also fix bugs, change APIs, and rename files—impossible to review and impossible to revert.
- Big-bang rewrites with no delivery for months.
- Deleting old code before the new code handles 100% of traffic.
- Refactoring without tests and relying on manual happy-path verification.

## Output template

```markdown
## Refactor plan - <target>

| Field | Value |
|---|---|
| Goal | <behavior-preserving change> |
| Safety net | <characterization test path> |
| Pattern | Strangler Fig / Mikado / Branch by Abstraction |
| Steps | <ordered, reversible transformations> |

### Prerequisites (Mikado)
- <prerequisite discovered by attempting the goal>

### Commits
- refactor: <one behavior-preserving step per commit>
```

## Quality gate

- [ ] Characterization tests capture current behavior (including quirks) before any change.
- [ ] Refactoring commits are separate from behavior-change commits.
- [ ] Tests stay green after every step; a red step is reverted, not pushed through.
- [ ] Old code is deleted only after the new path handles all traffic.

## References

- [Martin Fowler - Refactoring (2nd ed.)](https://martinfowler.com/books/refactoring.html)
- [Michael Feathers - Working Effectively with Legacy Code](https://www.oreilly.com/library/view/working-effectively-with/0131177052/)
- [Mikado Method](https://mikadomethod.info/)
- [Fowler - Strangler Fig Application](https://martinfowler.com/bliki/StranglerFigApplication.html)
