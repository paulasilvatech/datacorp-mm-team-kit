# Stage 1 — Digital Archaeology (90 min)

> **Track:** [Team Kit](../README.md) › [Stage 1](README.md) › **GUIDE**

**A 90-minute schedule for reading assigned Natural programs, recording traceable evidence, and defining the prototype scope.**

| Field | Value |
|---|---|
| **Target audience** | All 5 pairs |
| **Prerequisites** | Read [`README.md`](README.md) and access the `legacy-sifap/` directory |
| **Estimated time** | 90 min (11:00–12:00 + 13:30–14:00) |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | Candidate rules catalog, discovery report, and completed H1 handoff |

> [!IMPORTANT]
> **Mandatory gate.** Before writing EARS in Stage 2, the pair must have read the assigned Natural programs and have evidence for every selected behavior. Every subsequent formal requirement needs a valid `source_legacy:` or `[GREENFIELD]` with justification. The gate is not a quantity target.

---

## Objective

Read the assigned Natural programs, record traceable evidence, and choose a small scope that can become a feature. The goal is not to explain the entire SIFAP Payment Inspection and Administration System, complete encyclopedic documentation, or solve mysteries.

---

## Timed schedule

| Time | Activity | Minimum outcome |
|---|---|---|
| 11:00–11:10 | Open the three programs assigned to the pair and agree on who reads each one. | Program coverage and reader names. |
| 11:10–11:40 | Guided reading: inputs, outputs, calls, and domain decisions. | Notes with paths and line ranges. |
| 11:40–12:00 | Record candidate rules and questions without inferring absent behavior. | Evidence in the catalog and explicit open items. |
| 13:30–13:45 | Consolidate only the evidence supporting the prototype scope. | Updated catalog and discovery report. |
| 13:45–13:55 | The PO prioritizes **one thin feature**; the team discards or postpones the rest. | Scope decision for Stage 2. |
| 13:55–14:00 | H1 handoff with Pair 2. | Sources, scope, and questions transferred live. |

---

## Who reads what

Each pair reads the three programs below. Reading may focus on domain decisions; do not try to translate every Natural statement during this step.

| Pair | Programs |
|---|---|
| 1 · Vision | `CADBENEF.NSP`, `CADDEPEND.NSP`, `CADPROG.NSP` |
| 2 · Architecture | `BATCHPGT.NSP`, `BATCHREL.NSP`, `BATCHCON.NSP` |
| 3 · Implementation | `CALCBENF.NSN`, `CALCCORR.NSP`, `CALCDSCT.NSP` |
| 4 · Quality | `VALBENEF.NSN`, `VALDOCS.NSP`, `VALELEG.NSN` |
| 5 · Operations | `CONSBENF.NSP`, `RELPGT.NSP`, `RELAUDIT.NSP` |

Pair 4 also reviews the DDMs needed for the selected feature. Mapping every field or proposing the complete schema is not mandatory at this stage.

---

## What to record

Use the [templates](templates/) for support. For every candidate rule in scope, record at least:

- a short description of the observed behavior;
- the `.NSN` or `.ddm` path and, when possible, the line range;
- the question that still prevents a conclusion, without turning it into a requirement;
- the rule's impact on the prioritized feature.

`business-rules-catalog.md` is the input to the formal spec; use the [catalog template](templates/business-rules-catalog.template.md) if the file does not yet exist. The glossary, dependency map, and mystery record may be enriched if they help the scope, but numeric targets do not block the handoff.

> [!IMPORTANT]
> **Exception—the mysteries have a fixed denominator.** SIFAP contains **20 canonical mysteries**, **4 per pair**. This is the only numeric target in Stage 1, because without it each pair reported a different quantity after reading the same material. See [`mysteries-checklist.md`](mysteries-checklist.md) for your pair's IDs and record them in [`mysteries-found.md`](mysteries-found.md). Findings outside the list are bonuses and do not change the denominator.

---

## H1 handoff

In five minutes, Pair 1 hands the following to Pair 2:

1. the selected thin feature and what remains out of scope;
2. rules that may become requirements, with legacy paths;
3. open questions that **must not** become EARS;
4. DDM and dependency references only when they affect the feature.

Pair 2 confirms that it received enough evidence to start `specs/<NNN>-<feature>/spec.md`. If not, the team reduces the scope; it does not invent a source.

---

## Definition of done

- [ ] The three programs assigned to each pair were read.
- [ ] The selected behavior has evidence in `.NSN` or `.ddm`, or was explicitly separated as a greenfield proposal.
- [ ] The catalog identifies the source of every candidate rule.
- [ ] The discovery report records the scope and relevant questions.
- [ ] The H1 handoff occurred before 14:00.

---

## References

- [Exploration checklist](LEGACY-EXPLORATION-CHECKLIST.md)—gate verification and criteria by pair.
- [Stage 2 guide](../02-modern-spec/GUIDE.md)—next step after the H1 handoff.
- [How to read Natural](legacy-sifap/HOW-TO-READ-NATURAL.md)—syntax tutorial for non-developers.

---

### Continue reading

| Previous | Next |
|---|---|
| [Stage 1 — README](README.md)<br/><sub>Stage overview.</sub> | [Exploration Checklist](LEGACY-EXPLORATION-CHECKLIST.md)<br/><sub>Mandatory gate before Stage 2.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
