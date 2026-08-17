# Open Questions Checklist — Stage 1

> **Track:** [Team Kit](../README.md) › [Stage 1](README.md) › **Open Questions Checklist**

**Traceability of uncertainties before Stage 2.** Ensures every open question is recorded with evidence, a hypothesis marked as unconfirmed, and an identified owner.

| Field | Value |
|---|---|
| **Target audience** | All pairs—complete during Stage 1 |
| **Prerequisites** | Read the assigned programs |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | List of questions without conclusions, with traceability and an owner |

> [!IMPORTANT]
> **Traceability gate.** A question remains open until it receives explicit evidence-based human validation. It must not become an answer, rule, or requirement without that validation.

---

## The denominator is 20

SIFAP, the Payment Inspection and Administration System, contains **20 canonical mysteries**—business rules, contradictions, and decisions that were never documented and exist only in the code. There are **4 per pair**, following the ladder **2 Obvious + 1 Medium + 1 Difficult**.

| Rule | Value |
|---|---|
| Total canonical mysteries in the cohort | **20** (`SIFAP-M-01` … `SIFAP-M-20`) |
| Per pair | **4** |
| Complete pair | 4 of 4 |
| Complete cohort | **≥16 of 20**, with no pair below 2 |

> [!NOTE]
> **Why use a fixed number.** Without a denominator, each pair reported a different quantity after reading exactly the same material—a variation of more than 30 items depending on aggregation granularity and how many artifacts each person opened. The denominator **does not change**: findings outside the list are **bonuses** recognized in the debrief, but they do not replace a missing canonical mystery, and facilitators do not create canonical IDs during the workshop.

Eight of the twenty are **two-sided**: they count only with both pieces of evidence (code **and** DDM, or code **and** legacy document). Comparing sources is not optional.

### Where to look—by pair

Labels indicate the mystery's **area**, never the finding.

| Pair | Domain | IDs | Programs |
|---|---|---|---|
| 1 | Registration | `M-01` … `M-04` | `CADBENEF`, `CADDEPEN`, `CADPROG` |
| 2 | Batch | `M-05` … `M-08` | `BATCHPGT`, `BATCHREL`, `BATCHCON` |
| 3 | Calculation | `M-09` … `M-12` | `CALCBENF`, `CALCCORR`, `CALCDSCT`\* |
| 4 | Validation | `M-13` … `M-16` | `VALBENEF`, `VALDOCS`, `VALELEG` |
| 5 | Queries and reports | `M-17` … `M-20` | `CONSBENF`, `RELPGT`, `RELAUDIT` |

\* `CALCDSCT.NSP` is supporting reading for Pair 3—no canonical mystery lives in it. It is worth asking why it exists.

> [!TIP]
> **If you are stuck for more than 40 minutes, ask the facilitator for a hint.** A hint does not cost points; remaining stuck takes you out of the exercise.

---

## For every open question

- [ ] The question was recorded without an answer or conclusion.
- [ ] The evidence contains `path:line`.
- [ ] The impact was recorded.
- [ ] The hypothesis is explicitly marked as **unconfirmed**.
- [ ] A responsible person or area was identified.
- [ ] The status was recorded.

---

## Record structure

| Open question | Evidence (`path:line`) | Impact | Hypothesis (unconfirmed) | Responsible person/area | Status |
|---|---|---|---|---|---|
| <!-- fill in --> | <!-- fill in: path:line --> | <!-- fill in --> | <!-- fill in: unconfirmed --> | <!-- fill in --> | <!-- fill in: open / awaiting human validation / closed after human validation --> |

---

## Pair scorecard

Enter your pair's IDs (for example, Pair 2 enters `M-05` through `M-08`).

| Canonical ID | Found | Recorded in `mysteries-found.md` |
|---|---|---|
| `SIFAP-M-__` | [ ] | [ ] |
| `SIFAP-M-__` | [ ] | [ ] |
| `SIFAP-M-__` | [ ] | [ ] |
| `SIFAP-M-__` | [ ] | [ ] |

**Additional findings (bonus):** <!-- list here; they do not change the denominator -->

---

## Methods for finding mysteries

None of these tips reveals a finding—they are all reusable legacy-code reading techniques.

1. **Read comments before code.** In 29-year-old code, comments are often the only place where someone tried to explain *why*. A comment with a name and date is gold.
2. **Read the program header.** Lines such as `* CHANGED: yyyy-mm-dd - NAME - reason` tell the system's story chronologically.
3. **Compare code with documentation.** When `legacy-docs/` and the code disagree, you have found something.
4. **Compare code with the DDM.** Type, size, and value domain must match between the program and `adabas-ddms/`—and they do not always match.
5. **Look for numeric literals.** Every unexplained number in a calculation raises questions: where did it come from, who decided it, and what breaks if it changes?
6. **Ask "who writes this field?"** Choose a DDM field and find every program that writes to it. Sometimes the answer is: none.
7. **Read commented-out code.** Disabled blocks reveal what the system once did—and why it stopped.
8. **Be suspicious of `ESCAPE`, `IF` without `ELSE`, and unconditional assignment.** Early exits and rules that always apply hide decisions nobody recorded.
9. **Cross-reference the pair's three programs.** Several mysteries appear only when comparing two files.

---

### Continue reading

| Previous | Next |
|---|---|
| [Stage 1 GUIDE](GUIDE.md)<br/><sub>Step-by-step schedule.</sub> | [Open Questions Record](mysteries-found.md)<br/><sub>Detailed record with evidence and owner.</sub> |

<sub>[Back to the kit index](README.md)</sub>
