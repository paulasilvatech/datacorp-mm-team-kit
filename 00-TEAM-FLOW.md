<!-- markdownlint-disable MD013 MD033 MD041 -->

# Team flow: how five people cover 10 personas

> **Track:** [Team kit](README.md) › **Team flow**

**Keep this document pinned on your screen during the whole workshop.** It answers the four essential questions: which SDLC phase your personas lead, who feeds your work, who receives your handoff, and when to ask for help.

![Flow](https://img.shields.io/badge/Flow-Team-171717?style=flat-square) ![Duration: 10 min read](https://img.shields.io/badge/Duration-10%20min%20read-737373?style=flat-square) ![Use: all the time](https://img.shields.io/badge/Use-All%20the%20time-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Every workshop participant |
| **Prerequisites** | Read this document before the persona cards |
| **Estimated time** | 10 minutes |
| **Expected result** | You know what each pair does, when it does it, and who receives the work next |

---

## Where this fits in the SDLC

![Flow of the four Day 2 stages: archaeology, modern spec, implementation, and evolution with Agent](assets/stage-flow.svg)

The five pairs work **in parallel inside each stage**, and leadership shifts as the SDLC moves forward. The three handoffs between stages (**H1** legacy -> spec, **H2** spec -> code, **H3** code -> ops) are the points where the day either flows or stalls. No one sits idle. No one repeats work.

---

## 1. The five pairs and their SDLC phases

Each person chooses **one pair** (two personas). The two personas in a pair co-own the work. There is no internal handoff between them. They collaborate continuously.

| # | Pair | Personas | SDLC phase led |
|---|---|---|---|
| 1 | **Vision** | Product Owner + Requirements Engineer | Discovery + Specification |
| 2 | **Architecture** | Enterprise Architect + Software Architect | Specification + Design |
| 3 | **Implementation** | Technical Lead + Developer | Implementation + Evolution |
| 4 | **Quality** | DBA + QA Engineer | Implementation (data + tests) |
| 5 | **Operations** | DevOps Engineer + Tech Writer | Cross-cutting + Evolution |

> Persona kits live together in [`05-personas/`](05-personas/) as the role reference. The active artifacts are already consolidated in `.github/`: read your role's `PERSONA.md` and validate the agents/prompts/skills at the repository root.

![Persona distribution by pair: vision, architecture, implementation, quality, and operations](assets/personas-team.svg)

### Suggested split inside each pair

| Pair | Focus of persona A | Focus of persona B |
|---|---|---|
| 1 - Vision | **PO**: scope, value, priorities, demo storyline | **RE**: EARS requirements, acceptance criteria, REQ-IDs |
| 2 - Architecture | **EA**: external dependencies and scope decisions | **SA**: boundaries and technical slice plan |
| 3 - Implementation | **TL**: standards, PR review, agent orchestration | **Dev**: Java + TypeScript code, unit tests |
| 4 - Quality | **DBA**: PostgreSQL schema, Flyway migrations | **QA**: BDD scenarios, coverage gates, contract tests |
| 5 - Operations | **DevOps**: Terraform, GitHub Actions, secrets | **TW**: glossary, ADR clarity review, runbook, README |

Rotate inside the pair every ~45 minutes so no one monopolizes knowledge.

---

## 2. Timeline (8 hours, Day 2, 10:00-18:00)

> [!IMPORTANT]
> Copilot setup, Docker, and repository clone must be done **before 10:00**. On the morning of Day 2, at 10:00, the team only confirms that everything opens. It does not install from scratch. Without setup ready, the schedule does not fit.

![Timeline for the day: pre-event, four stages, and demo, with the three H1, H2, and H3 handoffs](assets/timeline-stages.svg)

| Time | Block | Lead pairs | Support pairs |
|---|---|---|---|
| **10:00-10:15** | Opening + pair confirmation | Facilitator | Each person confirms their two personas and opens their `PERSONA.md` |
| **10:15-10:45** | Setup validation + persona kits | Pair 3 + Pair 5 | Git, Java/Node, Docker, Spec-Kit `specify version`, Copilot Chat |
| **10:45-11:00** | Quick legacy orientation | Pair 1 + Pair 4 | Overview of the 15 Natural programs + four DDMs |
| **11:00-12:00** | **Stage 1** - Archaeology (part 1) | All five pairs in parallel | Each pair gets three programs - discovery + extraction |
| **12:00-13:30** | Lunch | - | - |
| **13:30-14:00** | **Stage 1** - Synthesis + **Handoff H1** | **Pair 1** consolidates evidence + scope | Pair 5 clarifies terms; Pair 2 identifies dependencies |
| **14:00-15:00** | **Stage 2** - Modern spec | **Pair 2** (EA + SA) | Pair 1 validates scope · Pair 5 reviews clarity · **Handoff H2** at the end |
| **15:00-16:10** | **Stage 3** - Implementation | **Pair 3** (TL + Dev), **Pair 4** (DBA + QA) | Pair 5 drafts CI scaffold · **Handoff H3** at the end |
| **16:10-16:50** | **Stage 4** - Evolution with agents | **Pair 5** (DevOps + TW) | **Pair 3** writes Issues and reviews Agent PRs |
| **16:50-17:00** | Buffer + demo prep | Everyone | Each team rehearses 30 seconds per persona |
| **17:00-17:30** | **Team demos** (~3 min each) | Whole team | PO leads · facilitator keeps time |
| **17:30-17:50** | Retrospective | Everyone | Keep / Change / Try - by persona |
| **17:50-18:00** | Wrap-up + final feedback | Facilitator | - |

> [!NOTE]
> No one stays idle. Pairs that are not leading a stage still have concrete support work. See §4.

---

## 3. Handoff map

![Handoffs H1, H2, and H3 between the four stages of the day, with transfer rules](assets/handoffs.svg)

Each pair has concrete work in every stage. The critical points are the three handoffs (H1, H2, H3). The rule is always the same: **a five-minute live conversation** between the pair leaving the stage and the pair entering it.

**How to read the handoff diagram:**

- Arrows are blocking dependencies. Without the slice `spec.md`, `plan.md`, and `tasks.md`, Pairs 3 and 4 cannot start correctly.
- Every handoff is a five-minute conversation between pairs. "Just read the document" is not enough. Talk live.

---

## 4. What each pair does in each stage

No pair stays idle. Even when a pair is not leading, it still has explicit support work.

| Pair | Stage 1 (Archaeology) | Stage 2 (Spec) | Stage 3 (Implementation) | Stage 4 (Evolution) |
|---|---|---|---|---|
| **1 - Vision** | **Leads.** Extracts rules; PO prioritizes scope. | Validates EARS; signs off on scope at H2. | Stays available to clarify requirements. Builds the demo narrative. | Rehearses the demo. |
| **2 - Architecture** | Maps evidence and dependencies relevant to the slice. | **Leads.** `spec.md`, `plan.md`, and `tasks.md`; records blocking decisions. | Stays available for boundary questions; reviews PRs that touch contracts. | Validates IaC against existing decisions. |
| **3 - Implementation** | Defines conventions (branches, PR template, DoD) and the prototype target skeleton. | Comments on feasibility; estimates complexity. | **Leads.** Code, tests, integration. | **Co-leads.** Agent mode delegation, PR review. |
| **4 - Quality** | Reads DDMs, plans schema mapping. | Comments on data implications; writes the first BDD scenarios. | **Leads.** Schema, migrations, test coverage. | Final coverage gate; contract tests in CI. |
| **5 - Operations** | Builds the glossary and terms that support the slice. | Reviews clarity and scope decisions. | Drafts the CI pipeline structure. | **Leads.** One small delegation; CI/IaC only if relevant. |

---

## 5. First 45 minutes: checklist by pair

Between **10:00 and 10:45**, **every pair** does the same four actions. Specialization starts after that.

- [ ] **Step 1: Read `00-TEAM-FLOW.md` (this file).** (10 min)
- [ ] **Step 2: Read the `PERSONA.md` for both kits in [`05-personas/`](05-personas/).** (15 min)
- [ ] **Step 3: Validate the consolidated `.github/`.** `ls .github/agents .github/prompts .github/instructions .github/skills` - agents, prompts, instructions, and skills already ship ready. (5 min)
- [ ] **Step 4: Open Copilot Chat, run the smoke-test prompt, and validate local tools.** (15 min)

### First action for each pair in archaeology, at 11:00

| Pair | Action at 11:00 |
|---|---|
| **1 - Vision** | PO opens [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) and the day schedule; RE opens [`01-arqueologia/legado-sifap/natural-programs/`](01-arqueologia/legado-sifap/natural-programs/) and starts the rule catalog. |
| **2 - Architecture** | EA opens [`01-arqueologia/legado-sifap/legacy-docs/`](01-arqueologia/legado-sifap/legacy-docs/) and records dependencies that affect the slice; SA prepares boundary questions. |
| **3 - Implementation** | TL defines branch strategy, PR template, definition of done, and standard paths (`backend/`, `frontend/`, `infra/` when needed). |
| **4 - Quality** | DBA opens [`01-arqueologia/legado-sifap/adabas-ddms/`](01-arqueologia/legado-sifap/adabas-ddms/) and starts the field mapping; QA prepares the test strategy for the prototype that the team will create. |
| **5 - Operations** | DevOps plans the CI/IaC work that the team will create in this repository; TW opens the template at [`01-arqueologia/glossary.md`](01-arqueologia/glossary.md). |

---

## 6. The 20-minute rule

> [!IMPORTANT]
> **If you, or your pair, stay stuck on the same problem for 20 minutes, stop and ask for help.**

The rule applies to everyone. Asking for help is not weakness. Staying silent and pushing alone puts the team schedule at risk.

### Escalation ladder

| Stuck for | Talk to |
|---|---|
| 5 min | Try Copilot Chat with different framing, or check with the person in your pair |
| 10 min | Talk to the pair immediately before or after yours (see §3) |
| 20 min | Talk to Pair 3 (the TL coordinates the team) |
| 30 min | Raise your hand for a facilitator (blue lanyard) |

### How to escalate (three-line format)

```text
1. Goal: What I am trying to achieve
2. Tried: What I already tried (and what happened)
3. Blocker: What is stopping me right now
```

Bad: "This is not working."

Good: "Goal: validate CPF in `BeneficioService`. Tried: `@CPF` from Bean Validation and manual validation. Blocker: I need to confirm whether the Payment Inspection and Administration System (SIFAP) accepts CPF for foreign users in a different format."

---

## 7. Definition of done by handoff

### Handoff H1: legacy to spec (end of Stage 1, ~14:00)

**Owner:** Pair 1 (Vision)
**Receivers:** Pair 2 (Architecture), Pair 5 (Operations)

| Artifact | Path | Done means |
|---|---|---|
| Rule catalog | `01-arqueologia/business-rules-catalog.md` | Candidate slice rules have the source `.NSN` or `.ddm` recorded |
| Discovery report | `01-arqueologia/discovery-report.md` | Thin slice, evidence, and open questions for the chosen feature |
| Supporting materials consulted | `01-arqueologia/` | Glossary, dependencies, and mysteries appear only when they help explain the slice |

### Handoff H2: spec to code (end of Stage 2, ~15:00)

**Owner:** Pair 2 (Architecture)
**Receivers:** Pair 3 (Implementation), Pair 4 (Quality)

| Artifact | Path | Done means |
|---|---|---|
| Formal specification | `specs/<NNN>-<feature>/spec.md` | Thin feature with REQ-IDs, EARS, and `source_legacy:` in every requirement |
| Formal plan | `specs/<NNN>-<feature>/plan.md` | Decisions, risks, and approach are sufficient to start implementation |
| Formal tasks | `specs/<NNN>-<feature>/tasks.md` | Implementation and test order are defined for the feature |
| Scope decision | `02-spec-moderna/scope-decisions.md` | The PO confirmed what is in scope and what stays deferred |

### Handoff H3: code to ops (end of Stage 3, ~16:10)

**Owner:** Pair 3 (Implementation)
**Receivers:** Pair 5 (Operations)

| Artifact | Path | Done means |
|---|---|---|
| Working backend | `backend/` | `mvn test` is green; OpenAPI is documented |
| Working frontend | `frontend/` | `npm test` is green; core flows are usable |
| Migrations | `backend/src/main/resources/db/migration/` | Flyway scripts are numbered and idempotent (Pair 4 owns this) |
| Coverage report | CI artifact | Backend >= 70%, frontend >= 60% line coverage (Pair 4 verifies) |

---

## 8. Communication patterns

| Pattern | When | Example |
|---|---|---|
| **Stand-up** | At every stage transition (4x) | Two-minute round, one sentence per pair: "We finished X, we are doing Y, we are blocked by Z" |
| **Pair check-in** | Every 30 minutes inside a stage | "Are the two of us still aligned?" |
| **Pair-to-pair sync** | During handoffs | Five-minute conversation, no slides |
| **PR comments** | Async between pairs | Mention the receiving pair explicitly (`@par-3`) |
| **Quiet hour** | Final 30 minutes of Stage 3 | No meetings; everyone codes or tests |

---

## 9. Anti-patterns: do not do this

| Anti-pattern | Do this instead |
|---|---|
| One persona in the pair does everything | Rotate every ~45 minutes so the other person stays warm |
| Skip a handoff | Hold the five-minute pair-to-pair conversation at every transition |
| Pair 4 (Quality) waits until the end of Stage 3 to start | Pair 4 writes BDD scenarios as soon as REQ-IDs exist (middle of Stage 2) |
| Pair 5 (Operations) stays idle until Stage 4 | Pair 5 leads glossary work in Stage 1, ADR clarity in Stage 2, and CI scaffold in Stage 3 |
| Pair 1 (Vision) disappears after Stage 1 | PO validates scope at H2 and rehearses the demo in Stage 4 |
| Pair 3 merges without review | Every PR gets at least one cross-pair review |

---

## 10. Quick reference

| Question | Where to find it |
|---|---|
| Which pair am I? | §1 (table of the five pairs) |
| What does my pair do in stage N? | §4 (pair x stage matrix) |
| Stuck? | 20-minute rule (§6) |
| Do I need a handoff? | Definition-of-done criteria (§7) |
| Which Copilot mode? | `09-cheat-sheets/copilot-3-modes.md` |
| Which model? | `09-cheat-sheets/model-routing.md` |
| Which Spec-Kit command? | `09-cheat-sheets/spec-kit-workflow.md` |

---

### Continue reading

| Previous | Next |
|---|---|
| [First 15 minutes](00-COMECE-AQUI.md)<br/><sub>Opening walkthrough with five numbered steps for anyone to get started.</sub> | [Setup](00-SETUP.md)<br/><sub>Laptop setup: Git, VS Code, Copilot, Spec-Kit, branch protection.</sub> |

<sub>[Back to the kit index](README.md)</sub>
