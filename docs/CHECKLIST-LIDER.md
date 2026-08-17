# Team Leader Checklist

![Checklist](https://img.shields.io/badge/Type-Checklist-171717?style=flat-square)
![Technical Lead Persona](https://img.shields.io/badge/Persona-Technical%20Lead-737373?style=flat-square)
![Duration All day](https://img.shields.io/badge/Duration-All%20day-A3A3A3?style=flat-square)

> **Path:** [Team Kit](../README.md) › [Docs](README.md) › **Leader Checklist**

**Chronological checklist for the Technical Lead** — from the period before the workshop through the final demonstration.

| Field | Value |
|---|---|
| **Target audience** | Person with the Technical Lead persona (Pair 3) |
| **Prerequisites** | Read [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) |
| **Expected outcome** | Team maintains pace, handoffs occur on time, and the demo is delivered |

---

## Before the workshop starts (D-1, previous evening)

- [ ] **Check laptops** — five laptops have VS Code Insiders installed.
- [ ] **Check GitHub accounts** — five accounts have active Copilot access (verify at <https://github.com/settings/copilot>).
- [ ] **Check repository** — `workshop-team-XX` is created and cloned by everyone.
- [ ] **Validate local tools** — Git, Java 21, Node, Docker, and Spec-Kit work on at least one laptop.
- [ ] **Protect branch** — `develop` exists and is protected.
- [ ] **Confirm attendance** — all five members are confirmed (one pair and two personas per person).

---

## Hour-by-hour checkpoints

### 10:00–11:00 · Setup and personas

- [ ] **10:15** — Every laptop has opened the repository in VS Code.
- [ ] **10:30** — Git, Java/Node, Docker, and Spec-Kit are validated on every laptop.
- [ ] **10:45** — Everyone has read their two `PERSONA.md` files and confirmed that `.github/` is consolidated.
- [ ] **10:55** — Everyone has tested one slash command from their persona.

### 11:00–12:00 · Stage 1 — Archaeology (part 1)

- [ ] **11:00** — The entire team has selected `@archaeologist` in Chat.
- [ ] **11:10** — Every pair knows which three Natural programs it will read.
- [ ] **11:10** — Every pair knows **which four canonical mysteries** it owns (`SIFAP-M-NN`; see [`mysteries-checklist.md`](../01-archaeology/mysteries-checklist.md)).
- [ ] **11:30** — Two-minute stand-up: each pair states one finding.
- [ ] **11:45** — Every pair has recorded evidence and questions from its assigned programs.

> [!TIP]
> **Mysteries use a denominator of 20** (four per pair). The answer key **does not live in this repository** because the repository is public; facilitators receive it through a private channel. Never project the answer key. A hint does not reduce the score, but a pair blocked for more than 40 minutes does — provide the hint.

### 13:30–14:00 · Stage 1 — Synthesis and Handoff H1

- [ ] **13:35** — The catalog contains sources for rules considered for the scope.
- [ ] **13:40** — Mystery score consolidated: **≥16/20**, with no pair below 2/4.
- [ ] **13:45** — Product Owner has selected one thin feature and recorded deferrals.
- [ ] **13:50** — Facilitator has validated `LEGACY-EXPLORATION-CHECKLIST.md`.
- [ ] **14:00** — **Handoff H1**: Pair 1 delivers `discovery-report.md` to Pair 2.

> [!WARNING]
> If any rule lacks a `Source Program` at 13:50, pause everything and complete it. CI rejects pull requests without this field.

### 14:00–15:00 · Stage 2 — Modern Specification

- [ ] **14:05** — The team has selected `@architect`.
- [ ] **14:30** — Product Owner has approved one thin feature.
- [ ] **14:45** — `spec.md`, `plan.md`, and `tasks.md` are in the feature folder.
- [ ] **15:00** — **Handoff H2**: formal artifacts delivered to Pairs 3 and 4.

> [!WARNING]
> Any REQ-ID without `source_legacy:` blocks the pull request. Check every requirement before the handoff.

### 15:00–16:10 · Stage 3 — Implementation

- [ ] **15:05** — The team has selected `@builder`.
- [ ] **15:30** — Flyway migration V2 has been created and runs locally.
- [ ] **15:50** — One or more REST endpoints work through Swagger.
- [ ] **16:00** — At least one test passes.
- [ ] **16:10** — **Handoff H3**: code merged into `develop`, CI green.

> [!WARNING]
> If CI fails or coverage is below 70%, prioritize the fix before adding features.

### 16:10–16:50 · Stage 4 — Evolution with Agent

- [ ] **16:15** — The team has selected `@evolution`.
- [ ] **16:20** — At least one well-written Issue exists for Copilot Agent.
- [ ] **16:35** — Available pull request reviewed; if there is no PR, the next step is recorded.
- [ ] **16:45** — CI/IaC status recorded, without creating infrastructure merely to meet a metric.
- [ ] **16:50** — `agent-experience-report.md` completed.

### 16:50–17:00 · Demo preparation

- [ ] **Coordinate speaking roles** — each pair has a defined 30-second segment.
- [ ] **Test execution** — run the demo once using the approach created by the team.
- [ ] **Prepare the browser** — Swagger, frontend, and merged PR are open and ready.

### 17:00–17:30 · Demonstrations

- [ ] Product Owner presents and keeps time.
- [ ] Entire team is visible on camera.
- [ ] SIFAP 2.0 is demonstrated live.

---

## Three questions the Technical Lead asks every 30 minutes

```text
1. Has anyone been blocked for more than 20 minutes?
2. Is CI green?
3. Is the next handoff (H1/H2/H3) on schedule?
```

Any negative answer requires immediate intervention.

---

## Emergency responses

| Situation | Technical Lead action |
|---|---|
| Pair lacks direction for 15 minutes | Sit with them and ask: "What is the objective right now?" |
| CI has failed for 30 minutes | Stop other work and focus the team on the fix |
| Product Owner changes scope after H2 | Reject the change. Scope freezes at H2. |
| Developer wants to refactor without an existing test | Reject it. Abort refactoring without coverage. |
| Agent generates a low-quality pull request | Do not merge. Request changes or implement manually. |
| Thirty minutes remain and the demo does not work | Reduce demo scope instead of trying to fix the problem. |
| Copilot is unavailable | Use Plan B in [troubleshooting.md](troubleshooting.md#plan-b--copilot-outage). |

---

## Technical Lead objective

> The Technical Lead's role is not to do everyone's work — it is to ensure no one is idle.

You contribute code in the same proportion as everyone else. Your distinct responsibility is to maintain **pace** and **scope**.

---

### Continue reading

| Previous | Next |
|---|---|
| [TEAM-FLOW](../00-TEAM-FLOW.md)<br/><sub>Complete schedule for the day.</sub> | [Lessons Learned](lessons-learned.md)<br/><sub>Common team mistakes.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
