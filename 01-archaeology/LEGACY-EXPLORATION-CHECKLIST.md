# Legacy Exploration Checklist

> **Track:** [Team Kit](../README.md) › [Stage 1](README.md) › **Exploration Checklist**

**Mandatory gate before Stage 2.** This checklist ensures that each pair read its assigned programs and that candidate rules are traceable to legacy code.

| Field | Value |
|---|---|
| **Target audience** | All pairs—complete during Stage 1 |
| **Prerequisites** | Access to `legacy-sifap/natural-programs/` and `adabas-ddms/` |
| **Estimated time** | Completed throughout the 90 minutes |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | Complete reading matrix by pair and verified completion criteria |

> [!IMPORTANT]
> **Mandatory gate before Stage 2.** No EARS requirement is accepted without a reference to a Natural program or DDM file. Greenfield requirements (with no legacy equivalent) must be marked `[GREENFIELD]` and justified in writing in the spec.

> [!WARNING]
> In the previous workshop edition, several teams skipped legacy exploration and wrote specs based only on the modernization brief. The result was specifications that did not preserve the real business rules from SIFAP's 29 years as the Payment Inspection and Administration System. This gate is mandatory.

---

## 1. The traceability rule

Every `REQ-ID` in `specs/<NNN>-<feature>/spec.md` must have a `source_legacy:` line pointing to one of the following:

- a specific `.NSN` program in `01-archaeology/legacy-sifap/natural-programs/` (preferably with a line range);
- a specific `.ddm` file in `01-archaeology/legacy-sifap/adabas-ddms/`;
- `[GREENFIELD]` with a one-line justification.

CI rejects PRs to `develop` if any `REQ-ID` lacks a `source_legacy:` line. Facilitators perform spot checks during the H2 handoff at 15:00.

---

## 2. The 15 Natural programs—who reads what

Each pair receives 3 programs. No program may be left without a reader.

| Pair | Programs to read | Mysteries | Why |
|---|---|---|---|
| **1 · Vision** (PO + RE) | `CADBENEF.NSP`, `CADDEPEN.NSP`, `CADPROG.NSP` | `SIFAP-M-01` … `M-04` | Registration logic—core entities that become EARS subjects. |
| **2 · Architecture** (EA + SA) | `BATCHPGT.NSP`, `BATCHREL.NSP`, `BATCHCON.NSP` | `SIFAP-M-05` … `M-08` | Batch flows reveal module boundaries (bounded contexts). |
| **3 · Implementation** (TL + Dev) | `CALCBENF.NSN`, `CALCCORR.NSP`, `CALCDSCT.NSP`\* | `SIFAP-M-09` … `M-12` | Calculations are where the modern code will live; the team must reproduce them. |
| **4 · Quality** (DBA + QA) | `VALBENEF.NSN`, `VALDOCS.NSP`, `VALELEG.NSN` | `SIFAP-M-13` … `M-16` | Validations become tests; the DBA also maps DDM fields. |
| **5 · Operations** (DevOps + TW) | `CONSBENF.NSP`, `RELPGT.NSP`, `RELAUDIT.NSP` | `SIFAP-M-17` … `M-20` | Read paths feed the glossary and runbook. |

\* `CALCDSCT.NSP` is **supporting reading** for Pair 3: no canonical mystery lives in it. It is still worth asking why it exists and who calls it.

> [!IMPORTANT]
> **There are 20 canonical mysteries, 4 per pair**—this is the only numeric target in Stage 1. IDs and areas are in [`mysteries-checklist.md`](mysteries-checklist.md); record them in [`mysteries-found.md`](mysteries-found.md). Findings outside the list count as bonuses and **do not** change the denominator.

### Checklist for each program

For each program assigned to your pair, record enough reading notes to confirm it was examined:

- [ ] **Identify the program.** Record its name, author, and year of last modification.
- [ ] **Map inputs.** Which DDMs it reads.
- [ ] **Map outputs.** Which DDMs it writes.
- [ ] **Record calls.** Other programs called through `CALLNAT`.
- [ ] **Catalog candidate rules.** When the program contains a rule relevant to the scope, record it in `business-rules-catalog.md` with `Source Program` and a line range.

> [!WARNING]
> A row without `Source Program` cannot support an EARS requirement.

---

## 3. The 4 DDMs—field mapping

Pair 4 (DBA + QA) leads. All other pairs contribute reviews.

| DDM | Owner | Target artifact in PostgreSQL |
|---|---|---|
| `BENEFIC.ddm` | Pair 4 | <!-- define from evidence --> |
| `PAYMENT.ddm` | Pair 4 | <!-- define from evidence --> |
| `SOCPROG.ddm` | Pair 4 | <!-- define from evidence --> |
| `AUDIT.ddm` | Pair 4 | <!-- define from evidence --> |

Review the DDMs needed for the selected feature. Complete PostgreSQL mapping belongs in planning and implementation; it is not a prerequisite for starting the spec.

---

## 4. Recording open questions

Use [`mysteries-checklist.md`](mysteries-checklist.md) to record open questions without anticipating answers. The record is a catalog of uncertainties, not an answer key or a source of rules.

Record in `mysteries-found.md` only questions that affect the scope. Each record must include:

| Field | Description |
|---|---|
| Open question | Question text without a conclusion |
| Evidence | `path:line` |
| Impact | Effect on the scope |
| Hypothesis | Explicitly marked as unconfirmed |
| Owner | Person or area that can validate |
| Status | `open` / `awaiting human validation` / `closed after human validation` |

A question may be closed or used as the basis for a rule only after explicit human validation supported by the recorded evidence.

---

## 5. Verification before opening Stage 2

At approximately 13:50, a facilitator checks the pair's work against this matrix. A red line blocks progression to Stage 2.

| Check | Gate criterion |
|---|---|
| Assigned reading | Each pair confirmed reading the three programs it received. |
| Rules catalog | Every candidate rule in scope has a non-empty `Source Program`. |
| Scope | The discovery report identifies a small feature and what was postponed. |
| Open questions | Relevant uncertainties were recorded without becoming requirements. |

---

## 6. Mandatory Stage 2 format

Write EARS only in `specs/<NNN>-<feature>/spec.md` using Spec-Kit. Every `REQ-ID` needs an EARS pattern, Given/When/Then criteria, and `source_legacy:`. Do not complete any requirement until the team confirms the source or greenfield justification.

---

### Continue reading

| Previous | Next |
|---|---|
| [Stage 1 GUIDE](GUIDE.md)<br/><sub>Timed schedule.</sub> | [Templates](templates/)<br/><sub>Fillable templates for the stage artifacts.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
