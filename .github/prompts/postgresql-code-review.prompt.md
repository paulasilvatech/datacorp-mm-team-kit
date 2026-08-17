---
name: "postgresql-code-review"
description: "Review SQL and schema for PostgreSQL 16 best practices and anti-patterns, deferring the checklist to the postgresql-code-review skill."
argument-hint: "selection=<sql-or-schema>"
agent: "agent"
tools: ["read", "search"]
---
# /postgresql-code-review

## What This Does

Reviews PostgreSQL SQL, schema, functions, and security features (JSONB, arrays, custom types, Row Level Security) against PostgreSQL-specific best practices and anti-patterns. The full checklist lives in the [`postgresql-code-review`](../skills/postgresql-code-review/SKILL.md) skill; this prompt is a thin wrapper that defers to it so the guidance is not duplicated and cannot drift.

## When to Use

During Stage 3/4 code review of migrations, queries, or schema changes for the SIFAP 2.0 database.

## Steps

1. Select the SQL or schema to review (defaults to the current selection, or the whole project).
2. Apply the [`postgresql-code-review`](../skills/postgresql-code-review/SKILL.md) checklist.
3. Honor the kit constraints below.

## Kit Constraints

- The target database is **PostgreSQL 16**, accessed through **JPA/Hibernate** — no string-concatenated SQL; parameterize every query.
- Migrations live under `backend/src/main/resources/db/migration/` and must be rollback-safe.
- Flag any PII column (CPF, benefit amounts) that lacks masking or a `COMMENT`.
