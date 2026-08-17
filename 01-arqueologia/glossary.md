# Legacy SIFAP Glossary

> **Track:** [Team Kit](../README.md) › [Stage 1](README.md) › **Glossary**

**Artifact completed by the team during Stage 1.** A table of all terms, abbreviations, and acronyms found in the Natural/Adabas code—the foundation of the ubiquitous language for Stage 2.

| Field | Value |
|---|---|
| **Target audience** | All pairs—each pair contributes terms from its programs |
| **Prerequisites** | Open the assigned `.NSN` and `.ddm` files |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | 30 or more terms with a source program and CONFIRMED/HYPOTHESIS status |

> [!NOTE]
> Step-by-step guide: [`GUIDE.md`](GUIDE.md).

---

## Why the glossary matters

Legacy systems have their own vocabulary, which is rarely documented in an accessible place—it lives in variable names, field abbreviations, and code comments. If the Stage 2 team does not know what `DSCT`, `BENF`, `PE`, or `CTC` mean, it will write a specification based on assumptions about those terms.

The glossary turns 3-to-6-character abbreviations into a ubiquitous language shared by the entire team—and provides the basis for entity and attribute names in the Stage 3 domain model.

**Common mistake:** marking a term as CONFIRMED without literal evidence in the code or historical documentation. If you inferred the meaning from context, mark it as HYPOTHESIS and identify who is responsible for validation.

---

## How to complete it

| Column | What to record |
|---|---|
| **Term** | The abbreviation or acronym exactly as it appears in the code. |
| **Expansion** | The term's full meaning. |
| **Program** | The `.NSN` or `.ddm` file where the term was found. |
| **Context** | Brief explanation of how and where the term is used. |
| **Status** | `CONFIRMED`—literal evidence in code or documentation. `HYPOTHESIS`—inferred from context and awaiting validation. |

### Extraction tip with Copilot Chat

Before using the prompt below, paste the contents of 2 to 3 `.NSN` files into the chat:

> "List every abbreviation and acronym used in this Natural code. For each one, suggest the expansion and mark it as 'CONFIRMED' or 'HYPOTHESIS'."

Compare Copilot's suggestion with what you observed directly in the code. If they match, record it as CONFIRMED; otherwise, record it as HYPOTHESIS.

---

## Terms found

| # | Term | Expansion | Program | Context | Status |
|---|---|---|---|---|---|
| 1 | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |
| 2 | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |
| 3 | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

> [!NOTE]
> Organize by domain (registration, calculation, batch, validation) if it helps navigation. Add as many rows as needed—the target is 30 or more terms.

---

## Definition of done

- [ ] 30 or more terms recorded.
- [ ] Every term has a source program.
- [ ] Every term has CONFIRMED or HYPOTHESIS status.
- [ ] Hypotheses marked for validation with a facilitator.

---

### Continue reading

| Previous | Next |
|---|---|
| [Stage 1 GUIDE](GUIDE.md)<br/><sub>Step-by-step schedule.</sub> | [Discovery Report](discovery-report.md)<br/><sub>Final consolidation for the stage.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
