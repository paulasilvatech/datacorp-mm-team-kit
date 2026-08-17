<!-- markdownlint-disable MD013 MD033 MD041 -->

# First 15 minutes: start here

> **Track:** [Team kit](README.md) › **Start here**

**If you just got here and want to know, "What do I do now?" this page is for you.** It does not matter whether you are a Product Owner, Tech Writer, Developer, business analyst, or DBA. The 15 minutes below work for everyone.

![Start](https://img.shields.io/badge/Start-00-171717?style=flat-square) ![Duration: 15 min](https://img.shields.io/badge/Duration-15%20min-737373?style=flat-square) ![Audience: whole team](https://img.shields.io/badge/Audience-Whole%20team-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Any participant, regardless of technical profile |
| **Prerequisites** | None - this is reading only |
| **Estimated time** | 15 minutes |
| **Stage** | Warm-up (before Stage 1) |
| **Expected result** | You know which pair you are in, what you do today, and what happens in Stage 1 |

---

## 15-minute schedule

| Minute | What to do | Time |
|---|---|---|
| 0-2 | Step 1 - Confirm your pair | 2 min |
| 2-4 | Step 2 - Open the day's schedule | 2 min |
| 4-6 | Step 3 - Open the visual glossary | 2 min |
| 6-11 | Step 4 - Read your role's `PERSONA.md` | 5 min |
| 11-15 | Step 5 - Open Stage 1 and the Copilot cheat sheet | 4 min |

> [!NOTE]
> Still missing the full technical setup? That is fine. These 15 minutes are reading only. The technical setup comes next, guided by `00-SETUP.md`.

---

## Step 1: Confirm your pair (2 min)

The team has **five people and 10 personas** (each person covers two personas, in one pair).

| Pair | Personas | What you do |
|---|---|---|
| **1 - Vision** | Product Owner + Requirements Engineer | Decide **what** gets modernized |
| **2 - Architecture** | Enterprise Architect + Software Architect | Decide **how** the system is organized |
| **3 - Implementation** | Technical Lead + Developer | Write the **code** |
| **4 - Quality** | DBA + QA Engineer | Take care of **data** and **tests** |
| **5 - Operations** | DevOps Engineer + Tech Writer | Take care of **deployment** and **documentation** |

- [ ] **Confirm your pair.** Ask the facilitator which pair you are in. Write it down: My pair: _______ - My personas: _______ + _______

> [!TIP]
> Are you not a programmer? That is fine. PO, RE, Tech Writer, and part of QA do not need to code. Every persona has a clear mission. You will not spend the day watching someone compile Java in silence.

---

## Step 2: Open the day's schedule (2 min)

- [ ] **Open `00-TEAM-FLOW.md` in a tab.** Look only at the schedule. The day has four stages.

![Timeline for the day: pre-event, four stages, and demo, with the three H1, H2, and H3 handoffs](assets/timeline-stages.svg)

**What to pay attention to:**

- You cannot skip stages. Stage 2 depends on what comes out of Stage 1.
- **There is a handoff between stages** - the pair from one stage hands work to the next pair (a five-minute live sync). That is what keeps the day moving.
- If you are blocked for more than **20 minutes**, raise your hand. That rule applies to every team.

---

## Step 3: Open the visual glossary (2 min)

You will see acronyms and technical terms today (EARS, ADR, REQ-ID, DDM, Flyway, JPA...). You do not need to memorize any of them. Open this page in a tab and come back when you need it:

[`07-conceitos/03-glossario-visual.md`](07-conceitos/03-glossario-visual.md)

Every term has three lines: **what it is**, an **everyday analogy**, and **where it appears**. Use it freely.

- [ ] **Open the glossary in a browser or VS Code tab.**

> **Example:** the term "EARS" can look intimidating. The glossary translates it to: "a standard way to write unambiguous requirements - each requirement follows a template with condition, subject, action, and expected result."

---

## Step 4: Read your role's `PERSONA.md` (5 min)

You have **two personas**. Read the `PERSONA.md` for each one:

```text
05-personas/01-product-owner/PERSONA.md
05-personas/02-requirements-engineer/PERSONA.md
05-personas/03-enterprise-architect/PERSONA.md
05-personas/04-software-architect/PERSONA.md
05-personas/05-technical-lead/PERSONA.md
05-personas/06-developer/PERSONA.md
05-personas/07-dba/PERSONA.md
05-personas/08-qa-engineer/PERSONA.md
05-personas/09-devops-engineer/PERSONA.md
05-personas/10-tech-writer/PERSONA.md
```

- [ ] **Read the `PERSONA.md` for persona A.**
- [ ] **Read the `PERSONA.md` for persona B.**

**Focus on three sections in each `PERSONA.md`:**

1. **"Where you appear in each stage"** - a four-row table. It shows whether you lead, support, or observe in each stage.
2. **"If you get stuck (emergency defaults)"** - what to do when you feel lost.
3. **"Three sample prompts"** - copy-and-paste prompts that are ready to use in Copilot.

> [!TIP]
> If your two personas feel "the same," look at **when** each one leads. They rarely lead together. That is why two personas in one pair can cover the whole day without sitting idle.

---

## Step 5: Open Stage 1 and the Copilot cheat sheet (4 min)

### 5a. Open the Stage 1 guide

[`01-arqueologia/GUIDE.md`](01-arqueologia/GUIDE.md)

Read only:

- The **"Timed walkthrough"** section (Stage 1 deliverables)
- The **"Who reads what"** table (which three Natural programs your pair reads)
- The **11:00-12:00 + 13:30-14:00** schedule (what your pair does in Stage 1)

- [ ] **Read the "Timed walkthrough" section of the Stage 1 `GUIDE.md`.**

### 5b. Open the cheat sheet for Copilot's three modes

[`09-cheat-sheets/copilot-3-modes.md`](09-cheat-sheets/copilot-3-modes.md)

This saves you 30 minutes of confusion. Copilot has three modes:

| Mode | When to use it | Payment Inspection and Administration System (SIFAP) example |
|---|---|---|
| **Ask** | You want to understand something | *"Explain this section of the Natural program SIFAP0001.NSN"* |
| **Plan** | You want to change code carefully | *"Plan CPF validation. Show me the plan before you make changes."* |
| **Agent** | You want to delegate a whole feature | Stage 4 issue for the Copilot Agent |

- [ ] **Open the cheat sheet in a tab.**

### 5c. If you have never opened Copilot Chat

- VS Code -> Copilot icon in the activity bar -> open the chat
- Do not see the icon? Ask the facilitator. The extension may not be enabled.

---

## Checklist for the first 15 minutes

Before you move on, verify this:

- [ ] I know which pair I am in and which two personas I have
- [ ] I have `00-TEAM-FLOW.md` open in a tab (the day's schedule)
- [ ] I have `glossario-visual.md` open in another tab (for jargon lookups)
- [ ] I read the `PERSONA.md` files for my two personas (and focused on the three recommended sections)
- [ ] I know what will happen in Stage 1
- [ ] I know Copilot's three modes (Ask, Plan, Agent)

If everything is checked, **you are ready**. Go to the technical setup (`00-SETUP.md`) or directly to Stage 1, depending on the day's schedule.

---

## First hour: minute-by-minute walkthrough (for people who have never used VS Code or Copilot)

If you have never opened VS Code, Docker, or Copilot, this literal walkthrough gets you ready in 60 minutes. Follow it **in order**, without skipping steps.

> [!TIP]
> Do it with someone from your pair next to you. Two people get through setup issues in half the time.

| Minute | Action | How to know it worked |
|---:|---|---|
| **00** | Open a terminal and run `cd ~/Code/workshop-team-XX` | The repository name appears in the prompt |
| **02** | Run `code .` to open VS Code | VS Code opens and shows the folder list (`00-...`, `01-...`) |
| **04** | Open the integrated terminal (`` Ctrl+` ``) and run `git status` | The branch and repository state appear with no error |
| **08** | Validate tools: `java -version`, `node --version`, `git --version` | Each command prints a version |
| **13** | Validate Docker (do not start anything yet): `docker --version` | The command prints a Docker version |
| **18** | Validate Spec-Kit: `specify version` | The command prints a Specify CLI version |
| **20** | Go back to VS Code -> Copilot icon in the activity bar | The Copilot Chat panel opens on the right |
| **22** | In chat, type: *"Hello. What can you do?"* | Copilot responds and explains the three modes |
| **25** | Select the day's agent from the chat dropdown | You see `@archaeologist`, `@architect`, `@builder`, and `@evolution` in the list |
| **28** | Open two tabs in the browser: [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) and [`07-conceitos/03-glossario-visual.md`](07-conceitos/03-glossario-visual.md) | Two pinned tabs stay open for reference |
| **32** | Open your two persona folders in `05-personas/0X-.../` and read each `PERSONA.md` | You know your two missions for the day |
| **42** | Validate the consolidated `.github/`: `ls .github/agents .github/prompts .github/skills` | The folders exist and already contain agents, prompts, and skills |
| **45** | Reload VS Code: `Cmd+Shift+P` -> *Reload Window* | Slash commands such as `/ears-convert` appear when you type `/` in Chat |
| **50** | Open [`01-arqueologia/GUIDE.md`](01-arqueologia/GUIDE.md) and read the "Who reads what" section | You know which three `.NSN` programs your pair will read |
| **55** | Agree with your pair on who covers which persona | Both of you know who does what |
| **60** | You are ready to start Stage 1 | - |

### If something blocks you in this walkthrough

| Blocked at... | Go to |
|---|---|
| Minute 04 (terminal/Git) | [`docs/troubleshooting.md`](docs/troubleshooting.md) - *Setup* section |
| Minute 13 (Docker) | [`docs/troubleshooting.md`](docs/troubleshooting.md) - *Docker* section |
| Minute 20 (Copilot does not open) | [`docs/troubleshooting.md`](docs/troubleshooting.md) - *Copilot* section |
| Minute 45 (slash command does not work) | [`docs/troubleshooting.md`](docs/troubleshooting.md) - *"Slash command does not appear"* section |

> [!WARNING]
> Blocked for more than 20 minutes? Stop and ask for help. That rule is defined in `00-TEAM-FLOW.md` §6.

---

## Common situations in the first 15 minutes

<details>
<summary><strong>FAQ - click to expand</strong></summary>

| Situation | What to do |
|---|---|
| I do not know which pair I am in | Ask the room facilitator |
| I cannot find my `PERSONA.md` | The folder is `05-personas/0X-name/PERSONA.md` - confirm the number in Step 1 |
| A glossary term is still not clear | Open `07-conceitos/03-glossario-visual.md` and use Ctrl+F |
| VS Code or Copilot does not open | Go to `00-SETUP.md` § "Step 1: Check your laptop prerequisites" |
| The schedule looks very tight | It is. Trust the pair split. You will not do everything alone |
| I do not code. Will I get lost? | No. See `01-arqueologia/legado-sifap/COMO-LER-NATURAL.md` (for Stage 1) and the defaults in your `PERSONA.md` |

</details>

---

### Continue reading

| Previous | Next |
|---|---|
| [Team kit](README.md)<br/><sub>Main hub for this repository. Start there if this is your first time opening the kit.</sub> | [Team flow](00-TEAM-FLOW.md)<br/><sub>8-hour schedule, pair handoffs, 20-minute rule, definition of done.</sub> |

<sub>[Back to the kit index](README.md)</sub>
