<!-- markdownlint-disable MD013 MD033 MD041 -->

# Sitemap: visual map of the kit

> **Track:** [Team kit](README.md) › **Sitemap**

**Complete navigation map for the kit:** where each file lives, how artifacts flow between stages, and which path each persona should follow in the Payment Inspection and Administration System (SIFAP) workshop.

![Sitemap](https://img.shields.io/badge/Navigation-Sitemap-171717?style=flat-square) ![Use: quick reference](https://img.shields.io/badge/Use-Quick%20reference-737373?style=flat-square)

---

## Overview: flow of the four stages

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart LR
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef handoff fill:#FFFFFF,stroke:#525252,color:#171717
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px

    E1["Stage 1<br/>Archaeology<br/>@archaeologist"]:::step
    H1["Handoff H1<br/>5 min"]:::handoff
    E2["Stage 2<br/>Specification<br/>@architect"]:::step
    H2["Handoff H2<br/>5 min"]:::handoff
    E3["Stage 3<br/>Implementation<br/>@builder"]:::step
    H3["Handoff H3<br/>5 min"]:::handoff
    E4["Stage 4<br/>Evolution<br/>@evolution"]:::step
    R["SIFAP 2.0<br/>running"]:::result

    E1 --> H1 --> E2 --> H2 --> E3 --> H3 --> E4 --> R
```

---

## Ordered repository structure

| Prefix | Folder / file | When to read it |
|---|---|---|
| **00** | [`README.md`](README.md) | First arrival - workshop overview |
| **00** | [`00-COMECE-AQUI.md`](00-COMECE-AQUI.md) | 15-minute walkthrough for anyone |
| **00** | [`00-SETUP.md`](00-SETUP.md) | Set up laptop and Copilot |
| **00** | [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) | Canonical schedule for the day |
| **00** | [`00-SITEMAP.md`](00-SITEMAP.md) | This file |
| **00** | [`00-GIT-WORKFLOW.md`](00-GIT-WORKFLOW.md) | Branches, PRs, merges |
| **01** | [`01-arqueologia/`](01-arqueologia/) | Stage 1 - read legacy SIFAP |
| **01** | [`01-arqueologia/legado-sifap/`](01-arqueologia/legado-sifap/) | 15 `.NSN` programs + four DDMs + historical docs |
| **02** | [`02-spec-moderna/`](02-spec-moderna/) | Stage 2 - EARS, ADRs, C4 |
| **03** | [`03-implementacao/`](03-implementacao/) | Stage 3 - Java + Next.js + tests |
| **04** | [`04-evolucao/`](04-evolucao/) | Stage 4 - Agent mode + Terraform |
| **05** | [`05-personas/`](05-personas/) | 10 personas (pick two - your pair) |
| **06** | [`06-agentes-de-estagio/`](06-agentes-de-estagio/) | Four Copilot agents (one per stage) |
| **07** | [`07-conceitos/`](07-conceitos/) | Core concepts: EARS, ADR, SDD, agents |
| **09** | [`09-cheat-sheets/`](09-cheat-sheets/) | Quick reference cards (one page each) |
| `docs/` | [`docs/`](docs/) | FAQ, troubleshooting, runbook, STATUS |
| `assets/` | [`assets/`](assets/) | SVGs and diagrams |
| `specs/` | [`specs/`](specs/) | Spec-Kit artifacts created by the team during the workshop |

---

## Contents of `07-conceitos/`

| File | Contents |
|---|---|
| [`00-README.md`](07-conceitos/00-README.md) | Index and overview of the folder |
| [`01-spec-driven-development.md`](07-conceitos/01-spec-driven-development.md) | What Spec-Driven Development is and why the workshop uses it |
| [`02-agentes-e-personas.md`](07-conceitos/02-agentes-e-personas.md) | Difference between stage agents and individual personas |
| [`03-glossario-visual.md`](07-conceitos/03-glossario-visual.md) | Glossary with 30+ domain terms |
| [`04-3-modos-do-copilot.md`](07-conceitos/04-3-modos-do-copilot.md) | Ask, Plan, and Agent - when to use each mode |
| [`05-notacao-ears.md`](07-conceitos/05-notacao-ears.md) | EARS notation for unambiguous requirements |
| [`06-architecture-decision-records.md`](07-conceitos/06-architecture-decision-records.md) | ADRs - what they are, how to write them, template |

---

## Artifact flow between stages

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart LR
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef artifact fill:#FAFAFA,stroke:#A3A3A3,color:#404040
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px

    subgraph E1["Stage 1: archaeology"]
        LEGACY["legado-sifap/<br/>15 .NSN + 4 DDMs"]:::artifact
        GLOSS["glossary.md"]:::artifact
        BR["business-rules-catalog.md"]:::artifact
        DEPS["dependency-map.md"]:::artifact
        REPORT["discovery-report.md"]:::artifact
    end

    subgraph E2["Stage 2: specification"]
        SPEC["spec.md<br/>(EARS + source_legacy)"]:::artifact
        PLAN["plan.md"]:::artifact
        TASKS["tasks.md"]:::artifact
    end

    subgraph E3["Stage 3: implementation"]
        CODE["Java + Next.js"]:::artifact
        MIGS["Flyway migrations"]:::artifact
        TESTS["JUnit / Vitest tests"]:::artifact
    end

    subgraph E4["Stage 4: evolution"]
        ISSUES["GitHub Issues<br/>(for Agent mode)"]:::artifact
        TF["Terraform"]:::artifact
        CI["GitHub Actions"]:::artifact
    end

    LEGACY --> GLOSS & BR & DEPS
    GLOSS & BR & DEPS --> REPORT
    REPORT --> SPEC
    SPEC --> PLAN --> TASKS
    SPEC --> CODE
    CODE --> TESTS & MIGS
    SPEC --> ISSUES
    CODE --> TF
    TESTS --> CI
```

> How to read it: arrow = dependency. The destination artifact depends on the source artifact to be created with quality.

---

## Recommended path by persona

| You are... | Start with... | Then... | Then... |
|---|---|---|---|
| **Anyone, first time here** | [00-COMECE-AQUI.md](00-COMECE-AQUI.md) | [00-TEAM-FLOW.md](00-TEAM-FLOW.md) | your `PERSONA.md` |
| **Team lead** | [00-SETUP.md](00-SETUP.md) | [00-TEAM-FLOW.md](00-TEAM-FLOW.md) | [docs/CHECKLIST-LIDER.md](docs/CHECKLIST-LIDER.md) |
| **PO or RE (Pair 1)** | [05-personas/01-product-owner/PERSONA.md](05-personas/01-product-owner/PERSONA.md) | [01-arqueologia/GUIDE.md](01-arqueologia/GUIDE.md) | [02-spec-moderna/GUIDE.md](02-spec-moderna/GUIDE.md) |
| **EA or SA (Pair 2)** | [05-personas/03-enterprise-architect/PERSONA.md](05-personas/03-enterprise-architect/PERSONA.md) | [02-spec-moderna/ADR-TEMPLATE.md](02-spec-moderna/ADR-TEMPLATE.md) | [02-spec-moderna/GUIDE.md](02-spec-moderna/GUIDE.md) |
| **TL or Dev (Pair 3)** | [05-personas/06-developer/PERSONA.md](05-personas/06-developer/PERSONA.md) | [03-implementacao/GUIDE.md](03-implementacao/GUIDE.md) | - |
| **DBA or QA (Pair 4)** | [05-personas/07-dba/PERSONA.md](05-personas/07-dba/PERSONA.md) | [03-implementacao/GUIDE.md](03-implementacao/GUIDE.md) | - |
| **DevOps or TW (Pair 5)** | [05-personas/09-devops-engineer/PERSONA.md](05-personas/09-devops-engineer/PERSONA.md) | [04-evolucao/GUIDE.md](04-evolucao/GUIDE.md) | - |
| **You do not read Natural** | [01-arqueologia/legado-sifap/COMO-LER-NATURAL.md](01-arqueologia/legado-sifap/COMO-LER-NATURAL.md) | [01-arqueologia/GUIDE.md](01-arqueologia/GUIDE.md) | (your persona) |
| **You found a strange term** | [07-conceitos/03-glossario-visual.md](07-conceitos/03-glossario-visual.md) | (go back to where you came from) | - |

---

## If you got lost

1. **Do you not know which stage you are in?** Check [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) - the schedule section.
2. **Do you not know what your persona does?** Open the persona overview: [`05-personas/OVERVIEW.md`](05-personas/OVERVIEW.md).
3. **Do you not know what to deliver?** Open the current stage `GUIDE.md` and find the "How to know you are done (DoD)" section.
4. **Did you find a strange term?** Check [`07-conceitos/03-glossario-visual.md`](07-conceitos/03-glossario-visual.md).
5. **Did something go wrong technically?** Check [`docs/troubleshooting.md`](docs/troubleshooting.md).
6. **Blocked for more than 20 minutes?** Signal the facilitator. The rule is described in [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md).

---

### Continue reading

| Previous | Next |
|---|---|
| [Team kit](README.md)<br/><sub>Workshop overview and main entry point.</sub> | [00 - Start here](00-COMECE-AQUI.md)<br/><sub>15-minute opening walkthrough for anyone.</sub> |

<sub>[Back to the kit index](README.md)</sub>
