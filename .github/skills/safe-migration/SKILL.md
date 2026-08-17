---
name: "safe-migration"
description: "Use when planning an online schema change, a zero-downtime migration, or a rollback for a deployment that changed a table. Triggers include 'migration', 'ALTER TABLE', 'zero-downtime', 'expand-contract', and 'backfill'."
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Safe Schema Migration

## When to invoke

- "Plan the migration to add column X."
- "Can we rename this column without downtime?"
- "How do we remove this table safely?"

## Expand / migrate / contract pattern

Every schema change that affects live traffic goes through **three deployments**, never just one.

1. **Expand** - add the new shape alongside the old one (new nullable column, new table, new index). No reads or writes use it yet.
2. **Migrate** - dual-write to the old and new shapes, backfill historical rows, and switch reads to the new shape behind a flag.
3. **Contract** - remove the old shape only after the new shape has been authoritative for at least one release cycle.

## Practical rules

- **Additive changes are always safe**: new nullable column, new index (CONCURRENTLY / ONLINE), new table.
- **Destructive changes never happen in a single deployment**: drop column, rename column, change type, drop table, add NOT NULL.
- **Backfills run in batches** with LIMIT, pauses between batches, and idempotency. Never run `UPDATE whole_table SET …` all at once.
- **Index construction**: `CREATE INDEX CONCURRENTLY` (Postgres), `ONLINE=ON` (MySQL 8 / SQL Server). Watch for lock escalation.
- **Renames**: DO NOT rename in place. Add a new column → dual-write → backfill → switch reads → remove the old column.

## Pre-flight checklist

- [ ] The migration has written **forward** and **rollback** plans.
- [ ] Duration estimated on a **production copy** (never estimate in development).
- [ ] Lock impact assessed (`pg_locks`, `SHOW ENGINE INNODB STATUS`, `sys.dm_tran_locks`).
- [ ] Backfill batch size selected based on the replication-lag budget.
- [ ] Monitoring installed for replica lag, long-running transactions, and deadlocks.
- [ ] Feature flag or dual-read path installed before the migrate stage.

## Red flags - do not ship

- A single `ALTER TABLE` that takes a full lock on a large table.
- A migration coupled to the application deployment that cannot be rolled back independently.
- An irreversible step without a backup.
- A backfill that rewrites every row in one transaction.

## References

- [Braintree - PostgreSQL at Scale: Safe Migrations](https://medium.com/paypal-tech/postgresql-at-scale-database-schema-changes-without-downtime-20d3749ed680)
- [GitHub - gh-ost online schema migration](https://github.com/github/gh-ost)
- [Martin Fowler - Evolutionary Database Design](https://martinfowler.com/articles/evodb.html)
