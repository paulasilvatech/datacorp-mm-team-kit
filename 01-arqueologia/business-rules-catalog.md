<!-- markdownlint-disable MD013 MD033 MD041 -->

# Business Rules Catalog — Legacy SIFAP

> **Track:** [Team Kit](../README.md) › [Stage 1](README.md) › **Business Rules Catalog**

**Artifact completed by the team during Stage 1.** Each pair extracts rules from its assigned `.NSN` programs and records them here with mandatory traceability to the source program.

| Field | Value |
|---|---|
| **Target audience** | All pairs—each pair completes its program section |
| **Prerequisites** | Read the assigned `.NSN` programs |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | Catalog with `Source Program` completed for every candidate rule |

> [!NOTE]
> Each rule cites the source program with a line range (`file.NSN:Lstart-Lend`) and is classified as **Confirmed** (corroborated by historical documentation in `legado-sifap/legacy-docs/`), **Inferred** (from code only), or **Mystery** (an open question—also record it in [`mysteries-found.md`](mysteries-found.md) with `path:line` evidence, an unconfirmed hypothesis, owner, and status).

> [!IMPORTANT]
> Step-by-step guide: [`GUIDE.md`](GUIDE.md).

**Team**: <!-- fill in -->

---

## Rules from `<fill in: PROGRAM.NSN>`

| # | Rule Statement | EARS Candidate | Source | Classification | Notes |
|---|---|---|---|---|---|
| 1 | <!-- fill in --> | <!-- fill in: EARS pattern --> | <!-- fill in: file:line --> | <!-- fill in: Confirmed/Inferred/Mystery --> | <!-- fill in --> |

> [!NOTE]
> Duplicate the section above for each `.NSN` program read by your pair.

---

## Overall summary

| Metric | Value |
|---|---:|
| Natural programs read | <!-- fill in --> |
| DDMs cross-referenced | <!-- fill in --> |
| Confirmed rules | <!-- fill in --> |
| Inferred rules | <!-- fill in --> |
| Mysteries | <!-- fill in --> |

---

## Definition of done

- [ ] Every conditional block in the assigned programs was examined.
- [ ] Every rule cites `file:line`.
- [ ] Every open question is recorded in `mysteries-found.md` without a conclusion.

---

### Continue reading

| Previous | Next |
|---|---|
| [Inventory](inventory.md)<br/><sub>Step 1 — file scan.</sub> | [Dependency Map](dependency-map.md)<br/><sub>Step 3 — call and access graph.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
