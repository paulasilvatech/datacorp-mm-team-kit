---
name: "java-junit"
description: "Write effective JUnit 5 unit and parameterized tests, deferring the best-practice checklist to the java-junit skill."
argument-hint: "class=<ClassUnderTest>"
agent: "agent"
tools: ["read", "search", "edit"]
---
# /java-junit

## What This Does

Guides focused JUnit 5 tests — standard and data-driven — following the Arrange-Act-Assert structure, descriptive naming, proper mocking, and good test organization. The full checklist lives in the [`java-junit`](../skills/java-junit/SKILL.md) skill; this prompt is a thin wrapper that defers to it so the guidance is not duplicated and cannot drift.

## When to Use

During Stage 3/4, while implementing backend business logic — write the tests alongside the code, never after the fact.

## Steps

1. Name the class or behavior under test.
2. Apply the best practices in the [`java-junit`](../skills/java-junit/SKILL.md) skill.
3. Honor the kit constraints below.

## Kit Constraints

- The kit's backend test stack is **JUnit 5 + Testcontainers** — use Testcontainers (real PostgreSQL 16) for integration tests instead of in-memory substitutes.
- Trace every test to its requirement with a `// REQ-NNN` comment so the `spec-traceability` job can link test to spec.
- Build and run with Maven (`./mvnw test`).
