---
name: "query-audit"
agent: "dba"
description: "Audit a SQL query for performance, security, and SIFAP coding standards. Produce a corrected query and an EXPLAIN-based rationale."
tools: ["search", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /query-audit

## Objective

You are the DBA reviewing a SQL query (or JPA/JPQL query) intended for PostgreSQL 16. Your audit identifies injection risk, sequential-scan traps, N+1 patterns, and violations of SIFAP coding standards. The deliverable is a verdict (Pass / Fix required / Reject), a rewritten query, and an interpretation of `EXPLAIN ANALYZE`.

## Inputs

Ask the user for anything that is missing.

- The query in its original form (raw SQL, JPQL, Criteria API, or QueryDSL).
- The schema of the involved tables, or a pointer to migrations in `db/migration/`.
- Existing indexes (output of `\d table_name`) on those tables.
- Realistic production row counts and selectivity estimates.
- The calling code path—is it a hot endpoint (per request) or a batch job (nightly)?

## Process

1. **Perform the static scan first.**

- Any string concatenation with user input → reject as SQL injection.
- `SELECT *` on a wide table → reject.
- Implicit casts (`varchar = bigint`) that disable indexes → fix.
- Functions on indexed columns can prevent index use → fix them or
   add an expression index when the evidence justifies it.

2. **Perform the dynamic scan.** Run `EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT) ...` against a stage snapshot. Read the plan from top to bottom.

- Flag any `Seq Scan` on tables larger than 10k rows when a filter exists.
- Flag any `Sort` step that could be supported by an index.
- Flag any `Nested Loop` over more than ~1k outer rows when a `Hash Join` would be cheaper.
- Flag a divergence ratio between `rows estimated` and `rows actual` above 10×—the statistics are stale or the query shape is unfavorable.

3. **Check for N+1.** If the query is invoked from JPA, look for missing `JOIN FETCH` clauses or batch-size hints. Identify the parent loop in the application code.
4. **Check locks and isolation.** `SELECT ... FOR UPDATE` on hot tables requires care. The default isolation level must be `READ COMMITTED`; flag unjustified `SERIALIZABLE`.
5. **Confirm parameterization.** All user-facing values must be bound parameters, never interpolated into strings—even when they come from "trusted" code paths.
6. **Compare against SIFAP standards.**

- All public schemas use `snake_case`.
- Timestamps use `TIMESTAMPTZ`.
- Monetary values use `NUMERIC(15,2)`, never `FLOAT`.
- PII columns must have a `COMMENT` identifying them as such.

7. **Write the fix.** Rewrite the query with index hints if needed, and add a migration for a missing index when justified.
8. **Classify the verdict.**

## Output

A Markdown report with this structure:

```markdown
## Query Audit — <short identifier>

### Verdict
<!-- fill in: Pass / Fix required / Reject, with evidence -->

### Findings
| # | Severity | Finding | Evidence |
|---|----------|---------|----------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

### Rewritten Query
```sql
<!-- fill in with the confirmed parameterized query -->
```

### Index Recommendation

```sql
-- fill in only if EXPLAIN evidence justifies an index
```

### EXPLAIN ANALYZE Before / After

- Before: <!-- fill in with measurement -->
- After: <!-- fill in with measurement -->

### Required Application Change

- <!-- fill in with confirmed application changes -->

```

## Anti-patterns

- Approving a query because "it is fast in dev"—dev has 1k rows; prod has millions.
- Approving `SELECT *` because "the ORM removes unused columns"—it does not.
- Adding indexes for every query without considering write amplification.
- Trusting `EXPLAIN` without `ANALYZE`—estimates lie when statistics are stale.
- Approving `FOR UPDATE` on a hot row without a queue or backoff strategy.
- Reading PII without a column `COMMENT` identifying it as PII.
- Writing a query that works but disagrees with the JPA entity mapping—this leads to silent N+1 fixes that reintroduce the bug.

## Success Criteria

- [ ] Verdict stated: Pass / Fix required / Reject.
- [ ] Findings include severity, evidence (file/line or EXPLAIN snippet), and a recommendation.
- [ ] The rewritten query is ready to paste.
- [ ] EXPLAIN ANALYZE is pasted before and after, with measured times.
- [ ] Index migrations are versioned and online-safe (`CONCURRENTLY`).
- [ ] All parameters are bound, with no remaining string concatenation.
- [ ] PII access is flagged and column comments are confirmed.
