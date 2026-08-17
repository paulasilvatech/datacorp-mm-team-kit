---
name: "java-springboot"
description: "Apply Spring Boot best practices for the SIFAP 2.0 backend, deferring the detailed checklist to the java-springboot skill."
argument-hint: "target=<file-or-module>"
agent: "agent"
tools: ["read", "search", "edit"]
---
# /java-springboot

## What This Does

Guides high-quality Spring Boot code: package-by-feature structure, constructor injection, DTOs, a global exception handler, service-layer transactions, and test slices. The full checklist lives in the [`java-springboot`](../skills/java-springboot/SKILL.md) skill; this prompt is a thin wrapper that defers to it so the guidance is not duplicated and cannot drift.

## When to Use

During Stage 3/4, while building or reviewing the backend modules.

## Steps

1. Point at the file or module to build or review.
2. Apply the best practices in the [`java-springboot`](../skills/java-springboot/SKILL.md) skill.
3. Honor the kit constraints below.

## Kit Constraints

- Fixed stack: **Java 21 + Spring Boot 3.3 + JPA/Hibernate + PostgreSQL 16** — do not substitute another framework or database.
- For secrets, use environment variables backed by **Azure Key Vault** and **Managed Identity** — not HashiCorp Vault or AWS Secrets Manager.
- REST paths follow `/api/v1/{resource}`; every endpoint carries OpenAPI annotations and validates input with `@Valid`.
- Keep `@Transactional` in the service layer only; never return `null` from public methods (use `Optional`).
