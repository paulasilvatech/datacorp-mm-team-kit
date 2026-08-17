# Dependency Map — Legacy SIFAP

> **Track:** [Team Kit](../README.md) › [Stage 1](README.md) › **Dependency Map**

**Artifact completed by the team during Stage 1 — Step 3.** Records the dependencies between Natural programs and Adabas DDMs that support the selected scope.

| Field | Value |
|---|---|
| **Target audience** | All pairs, led by Pair 2 (Architecture) |
| **Prerequisites** | Rules catalog with identified sources |
| **Stage** | Stage 1 — Archaeology |
| **Expected outcome** | Mermaid diagram and edge tables with `file:line` evidence |

> [!IMPORTANT]
> Map only dependencies that explain the selected scope: `.NSN` programs calling other programs (`CALLNAT`, `FETCH`) and programs accessing DDMs (`READ`, `FIND`, `STORE`, `UPDATE`, `DELETE`). Every edge must be supported by `file:line`—no inference without evidence. This map informs the carving hypotheses in [`discovery-report.md`](discovery-report.md).

> [!NOTE]
> Step-by-step guide: [`GUIDE.md`](GUIDE.md).

**Team**: <!-- fill in -->
**Scope**: programs and DDMs that support the selected feature

---

## Mermaid diagram

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart TD
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef alt fill:#FFFFFF,stroke:#525252,color:#171717
    classDef muted fill:#FAFAFA,stroke:#A3A3A3,color:#404040
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px

    %% fill in: nodes = programs and DDMs; edges = calls and data access
    %% syntax example:
    %% PROGRAMA1 -->|"CALLNAT"| PROGRAMA2
    %% PROGRAMA1 -->|"READ"| DDM1[("DDM1")]
```

---

## Program → Program edges

| # | From | To | Type (`CALLNAT`/`FETCH`) | Evidence (`file:line`) |
|---|---|---|---|---|
| 1 | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

---

## Program → DDM edges

| # | Program | DDM | Operation (`READ`/`FIND`/`STORE`/`UPDATE`/`DELETE`) | Evidence (`file:line`) |
|---|---|---|---|---|
| 1 | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

---

## Observations

- **Most connected programs (hubs):** <!-- fill in -->
- **Isolated programs or dead code:** <!-- fill in -->
- **Batch dependency order:** <!-- fill in -->

---

## Definition of done

- [ ] Every edge relevant to the scope cites `file:line`.
- [ ] Mermaid diagram generated with the `%%{init:...}%%` header and a neutral palette.

---

### Continue reading

| Previous | Next |
|---|---|
| [Rules Catalog](business-rules-catalog.md)<br/><sub>Step 2 — rule extraction.</sub> | [Open Questions](mysteries-found.md)<br/><sub>Step 4 — uncertainty record.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
