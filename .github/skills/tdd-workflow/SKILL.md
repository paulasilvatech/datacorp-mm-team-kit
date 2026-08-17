---
name: "tdd-workflow"
description: "Use when practicing test-driven development, writing a failing test first, or guiding red-green-refactor. Triggers include \"TDD\", \"red-green-refactor\", \"test first\", \"failing test\", and \"write a test\"."
---
# TDD workflow

## When to invoke

- When starting a new behavior or bug fix.
- When pair programming or mobbing on unfamiliar code and needing a safety net.
- When changes keep breaking things no one expected.

## The cycle

```
RED → write the smallest failing test that expresses the next behavior
GREEN → write the smallest amount of code that makes the test pass
REFACTOR → improve the design while the tests remain green
```

Commit at every green stage. One behavior per cycle.

## Rules

1. **No production code without a failing test.** No test, no change.
2. **One failing test at a time.** Never have two reds.
3. **Take the smallest failing step.** If your first test is difficult to write, the design is telling you something.
4. **Test names describe behavior**, not implementation: `calculates_tax_for_tax_exempt_customer`, not `test_method1`.
5. Use **Given-When-Then / Arrange-Act-Assert** structure in the test body.
6. **The refactoring phase is not optional** - it is where most of the value lies.

## Choosing the next test

Order tests to guide the design:

- Start with the simplest nontrivial case (the "0→1" case or happy path with one input).
- Then add a single variation (a boundary, a branch, an error).
- Resist writing one giant test that covers everything.

## Faking and stubbing

- Use a test double only when the real collaborator is slow, nondeterministic, or not yet written.
- Do not mock types you do not control—wrap them in a thin abstraction first.
- A test that mocks everything tests nothing.

## When TDD is difficult, the design is usually the problem

- Difficult to construct the object under test → too many collaborators, SRP violation.
- Cannot make an assertion without reading three other objects → Law of Demeter / encapsulation problem.
- Must mock the world → hidden coupling; introduce an abstraction.

## Antipatterns

- Writing the code and then the test (that is verification, not TDD).
- Skipping the refactoring phase.
- Tests that duplicate the implementation (change detectors).
- Huge test fixtures shared across files—they are fragile.
- Asserting implementation details (private methods, exact SQL strings).

## Output template

```java
// REQ-NNN: <behavior under test>
@Test
void calculatesTaxForTaxExemptCustomer() {
    // Arrange
    var customer = new Customer(TAX_EXEMPT);
    // Act
    var tax = calculator.taxFor(customer);
    // Assert
    assertThat(tax).isEqualTo(Money.ZERO);
}
```

Commit sequence per behavior: `red: add failing test` -> `green: make it pass` -> `refactor: <improvement>`.

## Quality gate

- [ ] No production code was written without a failing test first.
- [ ] Only one test is red at a time, and each cycle covers one behavior.
- [ ] The refactor step ran while the tests were green.
- [ ] Test names describe behavior and reference their REQ-ID in a comment.

## References

- [Kent Beck - Test Driven Development: By Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/)
- [GOOS - Growing Object-Oriented Software, Guided by Tests](http://www.growing-object-oriented-software.com/)
- [Martin Fowler - Mocks Aren't Stubs](https://martinfowler.com/articles/mocksArentStubs.html)
