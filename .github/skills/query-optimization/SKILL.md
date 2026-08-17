---
name: "query-optimization"
description: "Use when investigating slow queries, designing indexes, or reviewing execution plans. Triggers include \"slow query\", \"explain plan\", \"index\", \"query tuning\", \"N+1\", and \"table scan\"."
---
# Query optimization

## When to invoke

- "This query is slow."
- "Why is it not using the index?"
- "Should I add an index on...?"
- "Review this EXPLAIN output."

## Diagnostic workflow

1. **Measure before optimizing** - capture a baseline (p50/p95 latency, rows examined, rows returned, logical reads).
2. **Get the plan**: `EXPLAIN (ANALYZE, BUFFERS)` in PostgreSQL, `EXPLAIN ANALYZE FORMAT=JSON` in MySQL 8, or `SET STATISTICS IO, TIME ON` in SQL Server.
3. **Look for common suspects**:

- **Seq Scan / Table Scan** on a large table with a selective predicate → missing index
- **Row estimate off by >10×** → stale statistics; run `ANALYZE`
- **Nested Loop with many outer rows** → should be a Hash/Merge join
- **Sort spilled to disk** → `work_mem` is too low or an index is missing for the ORDER BY
- **Filter after the join** instead of pushdown → rewrite the query or add a predicate index

4. **Propose the smallest change**: an index, rewrite, statistics update, or parameter adjustment.
5. **Validate**: run ANALYZE again, confirm that the plan changed, and verify that latency decreased. Never "ship and hope."

## Index design heuristics

- **Equality columns first**, then range, then sort (the ESR rule).
- A **covering index** (INCLUDE columns) avoids heap lookups for read-heavy queries.
- A **partial index** supports highly selective filters on skewed data (`WHERE status = 'pending'`).
- Every index adds write cost. Justify each one.

## Anti-patterns

- `SELECT *` on hot paths - forces heap access and breaks covering indexes.
- `WHERE func(col) = x` - prevents index use; store a computed column or use an expression index.
- N+1 from the ORM - fix it in the ORM (eager load), not with an index.
- "Add an index to every column" - wastes storage and slows writes.

## Output template

```markdown
## Query optimization - <query id>

| Field | Before | After |
|---|---|---|
| p95 latency | <ms> | <ms> |
| Rows examined | <n> | <n> |
| Plan | Seq Scan | Index Scan on <index> |

**Change**: index / rewrite / ANALYZE / parameter
**DDL**: CREATE INDEX CONCURRENTLY <name> ON <table> (<cols>)
**Validation**: EXPLAIN (ANALYZE, BUFFERS) rerun confirms the new plan
```

## Quality gate

- [ ] A baseline (p50/p95, rows examined, plan) was captured before any change.
- [ ] The proposed change is the smallest that fixes the bottleneck.
- [ ] `EXPLAIN (ANALYZE, BUFFERS)` confirms the plan changed and latency dropped.
- [ ] Each new index is justified against its write cost.

## References

- [Use The Index, Luke!](https://use-the-index-luke.com/)
- [PostgreSQL - Performance Tips](https://www.postgresql.org/docs/current/performance-tips.html)
- [SQL Server - Query Store](https://learn.microsoft.com/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
