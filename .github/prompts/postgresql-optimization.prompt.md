---
name: "postgresql-optimization"
description: "Optimize PostgreSQL 16 queries, indexes, and schema using PostgreSQL-specific features, deferring the workflow to the postgresql-optimization skill."
argument-hint: "selection=<sql-or-query>"
agent: "agent"
tools: ["read", "search", "execute"]
---
# /postgresql-optimization

## What This Does

Provides PostgreSQL-specific optimization: reading `EXPLAIN (ANALYZE, BUFFERS)`, index strategy (GIN/GiST/partial/covering), JSONB and array patterns, window functions, and maintenance. The full workflow lives in the [`postgresql-optimization`](../skills/postgresql-optimization/SKILL.md) skill; this prompt is a thin wrapper that defers to it so the guidance is not duplicated and cannot drift.

## When to Use

During Stage 3/4, when a query is slow or a schema needs tuning for the SIFAP 2.0 database.

## Steps

1. Provide the query or schema to optimize.
2. Follow the [`postgresql-optimization`](../skills/postgresql-optimization/SKILL.md) workflow.
3. Honor the kit constraints below.

## Kit Constraints

- The target database is **PostgreSQL 16**, accessed through **JPA/Hibernate**; keep entity mappings and queries in sync.
- Base every recommendation on a measured `EXPLAIN ANALYZE`, and make index changes online-safe (`CREATE INDEX CONCURRENTLY`) through a rollback-safe migration.
- Parameterize all queries — never concatenate user input.
