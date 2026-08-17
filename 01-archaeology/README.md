# Stage 1 — Archaeology

> **Track:** [Team Kit](../README.md) › **Stage 1 — Archaeology**

**Stage 1 overview.** Read this page before opening the GUIDE; it presents the objective, expected artifacts, and participants.

| Field | Value |
|---|---|
| **Target audience** | All 5 team pairs |
| **Prerequisites** | None — this is the starting point |
| **Estimated time** | 90 min (11:00–12:00 + 13:30–14:00) |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | Rules catalog, dependency map, glossary, and discovery report |

![Stage 1](https://img.shields.io/badge/Stage-1%20%C2%B7%20Archaeology-171717?style=flat-square) ![Mandatory gate](https://img.shields.io/badge/Gate-Hard%20Gate-404040?style=flat-square) ![All pairs in parallel](https://img.shields.io/badge/Pairs-All%20in%20parallel-737373?style=flat-square)

> [!IMPORTANT]
> **Read first:** [`LEGACY-EXPLORATION-CHECKLIST.md`](LEGACY-EXPLORATION-CHECKLIST.md) — mandatory gate before starting Stage 2. No EARS requirement is accepted without traceability to legacy code.

---

## What Stage 1 is

**Software archaeology** is the practice of extracting knowledge from legacy systems by systematically reading source code without modifying it. In this workshop, archaeology has a precise objective: gather enough evidence to write traceable requirements in Stage 2.

SIFAP, the Payment Inspection and Administration System, has operated for 29 years. Most knowledge about its business rules is in the Natural code, not in documentation. Without reading the code, the team would write specifications based on assumptions—which CI rejects because it requires a valid `source_legacy:`.

---

## Where this fits in the workshop flow

![Day timeline: pre-event, 4 stages, and demo, with the three H1, H2, and H3 handoffs](../assets/timeline-stages.svg)

---

## Who works here

All 5 pairs work in parallel, each responsible for 3 Natural programs. Pair 1 (Vision) leads the synthesis at the end of the stage. See [`GUIDE.md`](GUIDE.md) for the full assignment.

---

## Stage 1 artifacts

| File | Purpose |
|---|---|
| [`LEGACY-EXPLORATION-CHECKLIST.md`](LEGACY-EXPLORATION-CHECKLIST.md) | **Mandatory gate.** Program ownership by pair and completion criteria before Stage 2. |
| [`GUIDE.md`](GUIDE.md) | Step-by-step guide with a timed schedule. |
| [`glossary.md`](glossary.md) | Glossary of SIFAP domain terms and abbreviations. |
| [`business-rules-catalog.md`](business-rules-catalog.md) | Catalog of extracted business rules with mandatory `Source Program`. |
| [`dependency-map.md`](dependency-map.md) | Dependency map between programs and DDMs. |
| [`discovery-report.md`](discovery-report.md) | Discovery report consolidating the stage evidence. |
| [`mysteries-checklist.md`](mysteries-checklist.md) | Traceability checklist for open questions. |
| [`mysteries-found.md`](mysteries-found.md) | Detailed record of open questions with evidence and owner. |
| [`COMO-COMPILAR-E-EXECUTAR.md`](COMO-COMPILAR-E-EXECUTAR.md) | **Optional track.** How to compile and run the legacy corpus in a real Adabas/Natural environment. It is not a prerequisite for any stage. |

The legacy code is in [`legado-sifap/`](legado-sifap/) (shared by the kit).

Anyone who wants to run the legacy system instead of only reading it can provision the optional lab in [`infra/adabas-natural-lab/`](../infra/adabas-natural-lab/README.md): an Azure VM with Adabas and Natural Community Edition. The path from the corpus to a running program—loading sources, creating Adabas files, compiling, and running—is documented in [`COMO-COMPILAR-E-EXECUTAR.md`](COMO-COMPILAR-E-EXECUTAR.md). This advanced track requires your own Azure subscription, and no Stage 1 artifact depends on it.

---

### Continue reading

| Previous | Next |
|---|---|
| [Team Kit](../README.md)<br/><sub>Main repository hub.</sub> | [Stage 1 GUIDE](GUIDE.md)<br/><sub>90-minute timed schedule for reading the legacy system and cataloging rules.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
