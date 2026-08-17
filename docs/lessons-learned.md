# Lessons Learned — Common Team Mistakes

![Reference Type](https://img.shields.io/badge/Type-Reference-171717?style=flat-square)
![5 min read](https://img.shields.io/badge/Read-5%20min-737373?style=flat-square)

> **Path:** [Team Kit](../README.md) › [Docs](README.md) › **Lessons Learned**

**A record of the ten most common mistakes observed in previous teams**, with their consequences and remedies.

| Field | Value |
|---|---|
| **Target audience** | The entire team, especially the Technical Lead |
| **When to read** | Before the workshop starts |
| **Expected outcome** | Recognize failure patterns and know the remedy before it is needed |

---

## The ten most common mistakes

### 1. "We do not need to inspect the legacy system — the briefing is enough"

- **Consequence:** the team writes EARS without `source_legacy:`. CI rejects the pull request at 14:30. The team loses an hour redoing the work.
- **Remedy:** enforce the Stage 1 hard gate — the facilitator validates it at 13:50. See [`01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md`](../01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md).

### 2. "I will start coding while someone else writes the specification"

- **Consequence:** the code does not match the EARS requirements. Refactoring happens at the end of the day. The demonstration is incomplete.
- **Remedy:** Stage 3 starts only after handoff H2. The Technical Lead stops attempts to work ahead.

### 3. The Product Owner approves everything and nothing becomes out of scope

- **Consequence:** the team tries to implement 12 features in three hours and completes none.
- **Remedy:** the Product Owner declines requests at least three times during the day. Decision rule: _"Does it affect the monthly payment cycle? Yes → v1. No → backlog."_

### 4. Everyone uses Copilot differently

- **Consequence:** responses are inconsistent. The team debates with the assistant instead of producing artifacts.
- **Remedy:** the entire team selects the same stage agent (`@archaeologist`, `@architect`, and so on) in Chat.

### 5. Skipping `/speckit.clarify` to save time

- **Consequence:** ambiguities become bugs in Stage 3. Thirty minutes of questions now prevents two hours of rework later.
- **Remedy:** each `clarify` question represents a bug avoided. Answer all of them.

### 6. Running `git push --force` on `develop`

- **Consequence:** two people's work is lost without a straightforward recovery path.
- **Remedy:** protect `develop` (Step 4 of `00-SETUP.md`). Never use `--force` on a shared branch.

### 7. Editing an old migration instead of creating a new one

- **Consequence:** Flyway detects a checksum mismatch and the database stops starting.
- **Remedy:** never edit an applied migration file. Always create `V<N+1>__description.sql`. See [`docs/troubleshooting.md`](troubleshooting.md).

### 8. Delegating a vague Issue to Copilot Agent

- **Consequence:** the generated pull request is unusable and the work is discarded.
- **Remedy:** link the Issue to evidence and write verifiable acceptance criteria before delegating. A well-written Issue produces a usable pull request.

### 9. Running `terraform apply` instead of `plan`

- **Consequence:** Azure resources are created and billed immediately. The workshop does not authorize `apply`.
- **Remedy:** run only `terraform plan`. See [`04-evolution/GUIDE.md`](../04-evolution/GUIDE.md).

### 10. Not rehearsing the demonstration

- **Consequence:** the team spends its three demonstration minutes searching for the correct tab, a failing command, or a lost pull request.
- **Remedy:** 16:50–17:00 is reserved for rehearsal. Use [`demo-script.md`](demo-script.md).

---

## Five habits that distinguish good teams from excellent teams

1. **Two-minute stand-up** at the end of each stage — everyone knows the current state.
2. **Every pull request has a description** — use the GitHub template.
3. **Small commits include a REQ-ID** in the commit message.
4. **The 20-minute rule** — blocked? Ask for help. Do not struggle in silence.
5. **Trust the process** — do not invent a different workflow halfway through the day.

---

## The fundamental rule

> **Modernization is digital archaeology, not a greenfield project.**
> A team that treats SIFAP as a new system loses 29 years of business rules.
> A team that performs the archaeology first delivers a SIFAP 2.0 that can truly replace version 1.0.

---

### Continue reading

| Previous | Next |
|---|---|
| [Leader Checklist](CHECKLIST-LIDER.md)<br/><sub>Hour-by-hour checks for the day.</sub> | [Demo Script](demo-script.md)<br/><sub>Script for the final minutes.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
