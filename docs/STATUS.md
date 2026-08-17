# Daily STATUS — Progress Dashboard

> **Path:** [Team Kit](../README.md) › [Docs](README.md) › **STATUS**

**Real-time workshop tracking dashboard:** stage status, handoffs, and daily metrics.

![Dashboard](https://img.shields.io/badge/Dashboard-Daily%20status-171717?style=flat-square) ![Update](https://img.shields.io/badge/Update-every%2030%20min-737373?style=flat-square) ![Owner](https://img.shields.io/badge/Owner-Technical%20Lead-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Technical Lead (updates) and facilitator (reads at a glance) |
| **Update frequency** | Every 30 minutes or at each stage transition |
| **Expected outcome** | One-page view of what is ready, in progress, and blocked |

---

## Overall status

| Indicator | Status | Notes |
|---|---|---|
| Entire team present | — | Update: OK or Partial |
| Local tools validated on 5/5 laptops | — | — |
| `develop` branch protected | — | — |
| CI green on `develop` | — | — |
| Demo rehearsed | — | — |

---

## Progress across the four stages

| Stage | Status | Owner | Start | DoD complete? | Notes |
|---|---|---|---|---|---|
| **1 — Archaeology** | Not started | All pairs | — | No | — |
| **2 — Specification** | Waiting for handoff H1 | Pair 2 | — | No | — |
| **3 — Implementation** | Waiting for handoff H2 | Pairs 3 and 4 | — | No | — |
| **4 — Evolution** | Waiting for handoff H3 | Pair 5 | — | No | — |

**Status legend:** Not started · In progress · Complete · Delayed · Blocked

---

## Stage handoffs

| Handoff | From and to | When | Status |
|---|---|---|---|
| **H1** | Pair 1 to Pair 2 | End of Stage 1 | Not completed |
| **H2** | Pair 2 to Pairs 3 and 4 | End of Stage 2 | Not completed |
| **H3** | Pairs 3 and 4 to Pair 5 | End of Stage 3 | Not completed |

> [!NOTE]
> Each handoff is a five-minute synchronous conversation between the delivering and receiving pairs. The detailed schedule is in [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md).

---

## Daily metrics

| Metric | Target | Current |
|---|---|---|
| Legacy sources confirmed for the scope | Every REQ-ID | — |
| Formal specification (`spec.md`, `plan.md`, `tasks.md`) | One complete feature | — |
| Scope decisions recorded | At least one | — |
| First increment implemented | One | — |
| Backend test coverage | At least 70% | — |
| Frontend test coverage | At least 60% | — |
| Issues created for Agent mode | At least one | — |
| PRs merged into `develop` | — | — |

---

## Active alerts

> [!WARNING]
> Add an entry below whenever a blocker or risk appears. The Technical Lead reads it aloud at the next stand-up.

- [ ] (no current alerts)

---

## Milestones reached

Check each milestone as it is achieved:

- [ ] **First business rule documented with `Source Program`** — Stage 1 entry completed.
- [ ] **First EARS specification written** with the `source_legacy:` field completed.
- [ ] **First scope decision recorded** and linked to the plan.
- [ ] **CI green on the first Pull Request** — integration pipeline approved.
- [ ] **First REST endpoint working** and visible through Swagger.
- [ ] **Backend test coverage at or above 70%**.
- [ ] **First Agent-mode Pull Request reviewed and merged**.
- [ ] **Terraform plan completed without errors**.
- [ ] **Final SIFAP 2.0 demonstration completed successfully**.

---

## Stand-up record (one sentence per pair at each transition)

### H1 — end of Stage 1

| Pair | Persona | Record |
|---|---|---|
| Pair 1 | Vision (PO + RE) | ___ |
| Pair 2 | Architecture (EA + SA) | ___ |
| Pair 3 | Implementation (TL + Dev) | ___ |
| Pair 4 | Quality (DBA + QA) | ___ |
| Pair 5 | Operations (DevOps + TW) | ___ |

### H2 — end of Stage 2

| Pair | Record |
|---|---|
| Pair 1 | ___ |
| Pair 2 | ___ |
| Pair 3 | ___ |
| Pair 4 | ___ |
| Pair 5 | ___ |

### H3 — end of Stage 3

| Pair | Record |
|---|---|
| Pair 1 | ___ |
| Pair 2 | ___ |
| Pair 3 | ___ |
| Pair 4 | ___ |
| Pair 5 | ___ |

---

### Continue reading

| Previous | Next |
|---|---|
| [Demo Script](demo-script.md)<br/><sub>Script for the final three-minute demonstration.</sub> | [Leader Checklist](CHECKLIST-LIDER.md)<br/><sub>Hour-by-hour guide for the Technical Lead.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
