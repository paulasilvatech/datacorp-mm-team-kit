---
name: "context-map"
description: "Produce a map of the files relevant to a task — files to modify, dependencies, related tests, reference patterns, and risks — before any code is written. Use when the user wants to scope impact, plan changes, or understand which files a task touches before implementing."
---
# Context map

Build a written map of everything a task touches before any code is written. The map converts an open-ended change into a bounded, reviewable plan, so the implementer edits the right files, updates the right dependents, writes the right tests, and sees the risks up front.

> [!IMPORTANT]
> Do not start implementation until the context map is written and reviewed. The map is the artifact this skill produces; coding begins only after it is agreed.

## When to invoke

- "Scope the impact of adding a status field to the payment API before I code it."
- "Which files does this refactor touch, and what tests cover them?"
- "Map the blast radius of changing this repository interface."
- "Plan the file changes for this Stage 3 feature before implementation."

## How to build the map

1. **Restate the task in one sentence.** Name the observable outcome, not the implementation detail.
2. **Locate the entry points.** Find the files that own the behavior: controllers, services, components, or migrations.
3. **Trace direct dependencies.** Follow imports and exports into and out of each file to find what breaks if a signature changes.
4. **Find the tests.** Identify unit and integration tests that already cover the affected code, and note where coverage is missing.
5. **Collect reference patterns.** Point to an existing file that already solves a similar problem, to copy its shape.
6. **Assess risk.** Flag public API changes, database migrations, and configuration or secret changes explicitly.

> [!NOTE]
> In this workshop `backend/` and `frontend/` do not exist until Stage 3, so a map for a new feature lists files to **create**, not only files to modify. `infra/` already exists. Treat everything under `01-archaeology/legacy-sifap/` as read-only evidence and never assert what a legacy program or field contains — cite the reading gate in [`01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md`](../../../01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md) instead.

## Scope signals

| Signal | Meaning | Action |
|---|---|---|
| The change touches a public `/api/v1` contract | Blast radius reaches every caller | List the callers and plan an API-compatibility note |
| The change alters a JPA entity or schema | A migration is required | Add a `db/migration` row to the map |
| No test covers the target code | Regression risk | Add a "test to write" row before coding |
| A similar feature already exists | Reuse opportunity | Record it as a reference pattern to follow |

## Output template

```markdown
## Context map: add a status field to Payment

### Files to create or modify
| File | Create or modify | Purpose | Change |
|---|---|---|---|
| backend/src/main/java/com/sifap/payment/PaymentController.java | modify | REST entry point | Add PATCH `/api/v1/payments/{id}/status` |
| backend/src/main/java/com/sifap/payment/PaymentStatus.java | create | Status enum | Define allowed values and transitions |

### Dependencies to check
| File | Relationship |
|---|---|
| backend/src/main/java/com/sifap/payment/PaymentService.java | Calls the modified controller mapping |
| frontend/app/payments/page.tsx | Renders the status returned by the API |

### Tests
| Test | Status | Coverage |
|---|---|---|
| backend/src/test/java/com/sifap/payment/PaymentControllerTest.java | exists | Extend for the new endpoint |
| PaymentStatus transition test | to write | New state-machine behavior |

### Reference patterns
| File | Pattern to follow |
|---|---|
| backend/src/main/java/com/sifap/benefit/BenefitController.java | Existing PATCH plus `@Valid` shape |

### Risks
- [ ] Breaking change to a public `/api/v1` contract
- [ ] Database migration required
- [ ] Configuration or secret change required
- [ ] Legacy behavior must be confirmed against read-only `01-archaeology/legacy-sifap/` evidence
```

## Quality gate

- [ ] Every file the task touches is listed as create or modify, with the concrete change described.
- [ ] Direct dependents of each changed signature are listed.
- [ ] Existing tests are identified and missing tests are marked "to write".
- [ ] At least one reference pattern is cited, or its absence is stated.
- [ ] Public API, migration, and configuration risks are flagged before coding starts.
- [ ] Any legacy-derived item cites read-only evidence and asserts no legacy program contents.
