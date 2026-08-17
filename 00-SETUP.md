<!-- markdownlint-disable MD013 MD033 MD041 -->

# Setup guide: from zero to code

> **Track:** [Team kit](README.md) › **Setup**

**This guide takes you from "we do not have anything yet" to "repository created, Copilot working, every persona ready" in 45 minutes.**

![Setup](https://img.shields.io/badge/Setup-00-171717?style=flat-square) ![Duration: 45 min](https://img.shields.io/badge/Duration-45%20min-737373?style=flat-square) ![When: before Day 2](https://img.shields.io/badge/When-Before%20Day%202-A3A3A3?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Team lead + each member on their own laptop |
| **Prerequisites** | GitHub account with Copilot enabled |
| **Estimated time** | 45 minutes |
| **Expected result** | Protected repository, Copilot active, personas validated, smoke test green |

> [!WARNING]
> **Windows users:** terminal blocks with heredoc or `for` assume **Git Bash** or **WSL**. Do not use PowerShell or CMD for those blocks.

**You are five people. Each person uses two personas. You have one workday.** Everyone follows along on their own laptop. One person shares the screen for the steps, and the other four repeat them. At the end, every laptop is fully configured.

## Summary

- [Before you start: mental model](#before-you-start-mental-model)
- [Step 1: Check your laptop prerequisites](#step-1-check-your-laptop-prerequisites)
- [Step 2: Create the team repository from the template (lead only)](#step-2-create-the-team-repository-from-the-template-lead-only)
- [Step 3: Clone the repository and create `develop` (lead only)](#step-3-clone-the-repository-and-create-develop-lead-only)
- [Step 4: Protect the `main` branch (lead only)](#step-4-protect-the-main-branch-lead-only)
- [Step 5: Add the other four members (lead only)](#step-5-add-the-other-four-members-lead-only)
- [Step 6: Each member clones the repository](#step-6-each-member-clones-the-repository)
- [Step 7: Turn on GitHub Copilot in VS Code (everyone)](#step-7-turn-on-github-copilot-in-vs-code-everyone)
- [Step 8: Validate the agents and prompts for your personas (everyone)](#step-8-validate-the-agents-and-prompts-for-your-personas-everyone)
- [Step 9: Install Spec-Kit (everyone)](#step-9-install-spec-kit-everyone)
- [Step 10: Use the Spec-Kit flow (everyone)](#step-10-use-the-spec-kit-flow-everyone)
- [Step 11: Understand the branch strategy](#step-11-understand-the-branch-strategy)
- [Step 12: Daily flow by persona](#step-12-daily-flow-by-persona)
- [Step 13: Smoke test (whole team, at 10:30)](#step-13-smoke-test-whole-team-at-1030)
- [Troubleshooting](#troubleshooting)

---

## Before you start: mental model

You will work with **two GitHub repositories**:

```text
GitHub
├── <TEMPLATE_ORG>/workshop-preto-00/       (main workshop repository, used once as a template)
└── <WORKSHOP_ORG>/workshop-team-XX/        (YOUR team's working repository - where you commit)
```

On your laptop, you clone only your team's repository:

```bash
~/Code/workshop-team-XX/
```

| Repository | What you do with it | Where it lives |
|---|---|---|
| `workshop-preto-00` | Use it once as the template at the beginning | `github.com/<TEMPLATE_ORG>/workshop-preto-00` |
| `workshop-team-XX` | All of your work goes here | `github.com/<WORKSHOP_ORG>/workshop-team-XX` (private, you create it) |

> [!NOTE]
> The exact organization will be provided by the facilitators on the workshop day. It will belong to the Enterprise [software-gbb-workshops](https://github.com/enterprises/software-gbb-workshops).

> [!IMPORTANT]
> Never push to the main workshop repository. Your team's commits go only to `workshop-team-XX`. The legacy **Payment Inspection and Administration System (SIFAP)** already ships in the kit under `01-arqueologia/legado-sifap/` and is reading material, not editing material.

---

## Step 1: Check your laptop prerequisites

**Each team member runs this checklist on their own laptop.**

- [ ] **Check the tools.**

| Tool | Minimum version | How to check | If missing |
|---|---|---|---|
| **Git** | 2.40+ | `git --version` | <https://git-scm.com/downloads> |
| **GitHub account** | - | Sign in at github.com | <https://github.com/signup> |
| **GitHub CLI** | 2.40+ | `gh --version` | <https://cli.github.com> |
| **VS Code** | 1.93+ | Help -> About | <https://code.visualstudio.com/download> |
| **Docker Desktop** | 4.30+ | `docker --version` and open the app | <https://www.docker.com/products/docker-desktop> |
| **Java 21 JDK** | 21 | `java -version` | <https://learn.microsoft.com/java/openjdk/download> |
| **Node.js** | 20 LTS | `node --version` | <https://nodejs.org/en/download> |

> [!CAUTION]
> Missing most of these items? Install the tools before the workshop starts. This kit does not ship with a prebuilt environment or automatic bootstrap.

### License check (one person checks for the team)

- [ ] **Open <https://github.com/settings/copilot>** - you should see "Active subscription" (Individual) or "Business plan". If you see "Get GitHub Copilot", call a facilitator.

---

## Step 2: Create the team repository from the template (lead only)

**Choose one person to act as the team lead** (usually the person covering the Technical Lead persona in Pair 3). Only the lead performs Steps 2 through 5. The other four wait and continue from Step 6.

### Using the template on GitHub

- [ ] **Create the repository from the template.**

1. Open the main workshop repository on GitHub. The facilitators will provide the URL in the format `https://github.com/<TEMPLATE_ORG>/workshop-preto-00`.
2. Click **Use this template** -> **Create a new repository**.
3. Fill in:
   - **Owner**: the workshop organization provided by the facilitators, inside the `software-gbb-workshops` Enterprise. Do not choose your personal user.
   - **Repository name**: `workshop-team-XX` (replace XX with your team number, for example `workshop-team-01`)
   - **Description**: `DATACORP 2026 Workshop - Team XX`
   - **Visibility**: Private
4. Click **Create repository**.

You should now see a full copy of the kit at `https://github.com/<WORKSHOP_ORG>/workshop-team-XX`, including documentation, legacy code, templates, workflows, and `.github/` files.

---

## Step 3: Clone the repository and create `develop` (lead only)

- [ ] **Clone the repository and create the `develop` branch.**

```bash
# 1. Choose a folder for all your code
mkdir -p ~/Code && cd ~/Code

# 2. Clone your team's repository
git clone https://github.com/<WORKSHOP_ORG>/workshop-team-01.git
cd workshop-team-01

# 3. Confirm that the template came across intact
ls 01-arqueologia/legado-sifap .github/agents .github/prompts .github/instructions .github/skills

# 4. Create the team's integration branch
git checkout -b develop
git push -u origin develop
```

> [!WARNING]
> From this point on, never push directly to `main`. Step 4 protects that branch.

`develop` is where everyone's feature branches are integrated. Promotions to `main` happen through PRs after each stage.

---

## Step 4: Protect the `main` branch (lead only)

This prevents anyone, except a repository admin, from pushing directly to `main`. Every change must go through a Pull Request.

> [!NOTE]
> Because the repository is created in an organization inside the `software-gbb-workshops` Enterprise, branch protection should be available. If you do not see the option, ask a facilitator to verify permissions.

### Using the website

- [ ] **Create the protection rule.**

1. Go to **Settings** -> **Branches** (left sidebar).
2. Under **Branch protection rules**, click **Add rule**.
3. Branch name pattern: `main`
4. Check:
   - **Require a pull request before merging**
   - **Require approvals** - set it to `1`
   - **Require conversation resolution before merging**
5. Click **Create**.

### Using the CLI

```bash
gh api -X PUT "repos/<WORKSHOP_ORG>/workshop-team-01/branches/main/protection" \
  --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false
  },
  "restrictions": null,
  "required_conversation_resolution": true
}
JSON
```

> **Why this matters.** Without this rule, someone on the team eventually pushes a mistake to `main` at minute 90, and the demo fails at minute 480. Cost: 30 seconds. Savings: hours.

---

## Step 5: Add the other four members (lead only)

### Option A: use the website

- [ ] **Invite the other four teammates.**

1. Go to the repository on GitHub: `https://github.com/<WORKSHOP_ORG>/workshop-team-XX`
2. Click **Settings** -> **Collaborators and teams** -> **Manage access**.
3. Click **Add people**.
4. Type the GitHub username and select it from the list.
5. Choose the **Write** role (not Admin, not Read).
6. Click **Add ... to this repository**.
7. Repeat for the other three people.

> [!TIP]
> If the facilitators created a GitHub team for each workshop team, add the whole team with Write permission instead of inviting people one by one. Each invited person gets an email and must click **Accept invitation** before they can push.

### Option B: use the CLI

```bash
for user in alice bob carla dani; do
  gh api -X PUT "repos/<WORKSHOP_ORG>/workshop-team-01/collaborators/${user}" \
    -f permission=write
done
```

---

## Step 6: Each member clones the repository

**Now everyone joins.** The other four team members do this.

### 6.1 Accept the invitation

- [ ] **Accept the invitation from email or from the GitHub notification.**

### 6.2 Clone and switch to `develop`

- [ ] **Clone the repository and confirm access.**

```bash
mkdir -p ~/Code && cd ~/Code

# Replace 01 with your actual team number and <WORKSHOP_ORG> with the organization provided that day
git clone https://github.com/<WORKSHOP_ORG>/workshop-team-01.git
cd workshop-team-01

# Switch to the develop branch, where day-to-day work happens
git checkout develop
```

### 6.3 Open it in VS Code

```bash
code .
```

### 6.4 Confirm local tools

This kit does not include a prebuilt environment, ready-made prototype, or inherited containerization. Each person validates their own tools locally. The prototype is created from scratch in Stage 3.

```bash
git --version
java -version
node --version
docker --version
specify version
```

### 6.5 Confirm that the template came across intact

```bash
ls 01-arqueologia/legado-sifap .github/agents .github/prompts .github/instructions .github/skills
```

---

## Step 7: Turn on GitHub Copilot in VS Code (everyone)

### 7.1 Sign in

- [ ] **Authenticate with Copilot.**

1. In VS Code, click the Copilot icon in the lower status bar.
2. Choose **Sign in with GitHub**.
3. A browser window opens. Click **Authorize Visual Studio Code**.
4. Go back to VS Code. Wait for "Copilot ready" near the lower-right corner.

### 7.2 Open the Copilot Chat panel

| OS | Shortcut |
|---|---|
| Mac | Cmd+Ctrl+I |
| Windows / Linux | Ctrl+Alt+I |

### 7.3 Verify that the three modes are available

| Mode | When to use it |
|---|---|
| **Ask** | Ask questions, explore code, discuss options |
| **Plan** | Plan multi-file changes before execution |
| **Agent** | Delegate a whole feature through an Issue, then review the PR |

- [ ] **Confirm that Ask, Plan, and Agent appear in the dropdown.**

If **Plan** or **Agent** does not appear, update VS Code to a recent version or use VS Code Insiders.

### 7.4 Copilot smoke test

- [ ] **Send a test question.**

In Copilot Chat, type:

```text
What stack are we using in this project?
```

It should answer with **Java 21 + Spring Boot 3.3 + Next.js 15 + PostgreSQL 16**. If it does not, the project file `.github/copilot-instructions.md` is not being loaded. See [Troubleshooting](#troubleshooting).

---

## Step 8: Validate the agents and prompts for your personas (everyone)

### 8.1 Find your role

- [ ] **Read the `PERSONA.md` for both personas.**

Open `05-personas/` in VS Code. Inside each role folder, read `PERSONA.md` from start to finish (~10 minutes). It tells you:

- What you do in the four stages
- Which Copilot mode to use
- Specific prompts you can copy and paste
- Who you depend on and who depends on you

### 8.2 Validate your kit

```bash
# Should list consolidated agents, prompts, instructions, and skills
ls .github/agents .github/prompts .github/instructions .github/skills
```

Do not copy `.github/*` manually. The consolidated repository already includes everything.

### 8.3 Persona-to-kit mapping

| Persona | Consolidated kit |
|---|---|
| Product Owner | `05-personas/01-product-owner/PERSONA.md` |
| Requirements Engineer | `05-personas/02-requirements-engineer/PERSONA.md` |
| Enterprise Architect | `05-personas/03-enterprise-architect/PERSONA.md` |
| Software Architect | `05-personas/04-software-architect/PERSONA.md` |
| Technical Lead | `05-personas/05-technical-lead/PERSONA.md` |
| Developer | `05-personas/06-developer/PERSONA.md` |
| DBA | `05-personas/07-dba/PERSONA.md` |
| QA Engineer | `05-personas/08-qa-engineer/PERSONA.md` |
| DevOps Engineer | `05-personas/09-devops-engineer/PERSONA.md` |
| Tech Writer | `05-personas/10-tech-writer/PERSONA.md` |

### 8.4 Update the team `copilot-instructions.md`

- [ ] **The lead updates `.github/copilot-instructions.md` with the team names.**

Find the section:

```markdown
## Active Personas on This Team

- [ ] 01 — Product Owner
- [ ] 02 — Requirements Engineer
      ...
```

Check the boxes and write the name next to each role:

```markdown
- [x] 01 — Product Owner — Maria Santos
- [x] 02 — Requirements Engineer — João Silva
- [x] 03 — Enterprise Architect — Ana Costa
      ...
```

Commit and push to `develop`. Copilot suggestions now know who is on your team.

---

## Step 9: Install Spec-Kit (everyone)

[**Spec-Kit**](https://github.com/github/spec-kit) is GitHub's official toolkit for specification-driven development. Use it for **quick feature drafts** in Stage 2.

### 9.1 Install Specify CLI on your laptop

- [ ] **Install Specify CLI.**

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@vX.Y.Z
specify version
```

Replace `vX.Y.Z` with the latest version from <https://github.com/github/spec-kit/releases>.

### 9.2 Initialize it in the team repository

- [ ] **Initialize it at the repository root.**

```bash
specify init . --integration copilot
```

This creates the `.specify/` configuration, automation scripts, and `/speckit.*` slash commands for GitHub Copilot.

### 9.3 Verify the commands in Copilot

| Command | When to use it |
|---|---|
| `/speckit.constitution` | Define project principles, standards, and gates |
| `/speckit.specify` | Create the feature spec |
| `/speckit.clarify` | Resolve ambiguity before the plan |
| `/speckit.plan` | Create the technical plan |
| `/speckit.tasks` | Generate implementable tasks |
| `/speckit.analyze` | Check consistency and coverage |
| `/speckit.implement` | Implement the feature guided by the spec |

### 9.4 Write a feature

In Copilot Chat:

```text
/speckit.specify <describe the feature identified by the team in the legacy code>. Preserve legacy traceability with source_legacy in each requirement.
```

Spec-Kit creates a numbered branch and this structure:

```text
specs/<NNN>-<feature>/
└── spec.md
```

Then run:

```text
/speckit.clarify
/speckit.plan Use Java 21, Spring Boot 3.3, PostgreSQL 16, Next.js 15, and the workshop modular monolith architecture.
/speckit.tasks
```

### 9.5 Workshop rule

Every requirement that comes from the legacy system still needs `source_legacy:` pointing to a `.NSN` or `.ddm`. Requirements with no legacy counterpart use `[GREENFIELD]` with a justification.

---

## Step 10: Use the Spec-Kit flow (everyone)

| Phase | Command | Main output | Owning persona |
|---|---|---|---|
| Constitution | `/speckit.constitution` | `.specify/memory/constitution.md` | Technical Lead + Architect |
| Spec | `/speckit.specify` | `specs/<NNN>-<feature>/spec.md` | Requirements Engineer |
| Clarification | `/speckit.clarify` | Questions resolved in the spec | Requirements Engineer + Product Owner |
| Plan | `/speckit.plan` | `specs/<NNN>-<feature>/plan.md` | Software Architect |
| Tasks | `/speckit.tasks` | `specs/<NNN>-<feature>/tasks.md` | Technical Lead |
| Analysis | `/speckit.analyze` | Gaps and inconsistencies | QA Engineer + Architect |
| Implementation | `/speckit.implement` | Code + tests guided by the spec | Developer + QA Engineer |

> [!IMPORTANT]
> The team explicitly reviews `spec.md`, `plan.md`, and `tasks.md` before implementation starts (LGTM gates).

---

## Step 11: Understand the branch strategy

```text
main                    <- release-ready, protected, requires 1 review
develop                 <- integration of all features
spec/NNN-feature        <- specification work (Stage 2)
impl/NNN-feature        <- implementation work (Stage 3)
infra/NNN-azure         <- infrastructure work (Stage 4)
```

### Naming convention

| Type | Pattern | Example |
|---|---|---|
| Spec | `spec/<NNN>-<feature>` | `spec/001-calculo-beneficio` |
| Implementation | `impl/<NNN>-<feature>` | `impl/001-calculo-beneficio` |
| Infrastructure | `infra/<componente>` | `infra/azure-postgres` |

`NNN` is the feature number (it matches the folder in `specs/<NNN>-<feature>/`).

### Create a feature branch

- [ ] **Create a branch from `develop`.**

```bash
git checkout develop
git pull

git checkout -b spec/<NNN>-<feature>

git add -A
git commit -m "feat: draft EARS requirements"
git push -u origin spec/<NNN>-<feature>
```

### Open a Pull Request

- [ ] **Open the PR and complete the template.**

1. After the push, GitHub prints a URL to create the PR. Click it.
2. Title: use Conventional Commits - `feat: add feature spec`
3. Complete the template (`.github/PULL_REQUEST_TEMPLATE.md`): what changed, REQ-IDs, how to test, linked issues.
4. Add at least one reviewer from another persona.
5. Click **Create pull request**.
6. Wait for CI green.
7. After approval, click **Rebase and merge** (not Merge commit, not Squash).
8. Delete the feature branch when prompted.

---

## Step 12: Daily flow by persona

### Product Owner / Requirements Engineer

```text
1. Read the findings from Stage 1 (glossary, business rule catalog)
2. Run /speckit.specify "feature-name" with source_legacy guidance
3. Run /speckit.clarify and validate with stakeholder personas (PO + EA)
4. Run /speckit.plan with the workshop stack and architecture choices
5. Run /speckit.tasks after the plan is approved
6. Open a PR on the spec/<NNN>-<feature> branch
7. Hand work off to Software Architect (LGTM gate)
```

### Enterprise Architect / Software Architect

```text
1. Pull the latest develop
2. git checkout spec/NNN-feature (read the EARS spec)
3. Run /speckit.plan -> produces plan.md, research.md, and contracts
4. Add ADRs in docs/adr/ for non-trivial decisions
5. Open a PR and review the design section of the spec PR
6. Hand work off to Technical Lead (LGTM gate)
```

### Technical Lead

```text
1. Read the approved plan.md and ADRs
2. Run /speckit.tasks -> produces tasks.md with task IDs (T001, T002, ...)
3. Open one GitHub Issue per task using .github/ISSUE_TEMPLATE/task.yml
4. Assign each issue to Developer / DBA / QA
5. Watch CI green/red and unblock people
```

### Developer

```text
1. Pick a task issue (T-NNN) from the team board
2. git checkout -b impl/NNN-feature (from develop)
3. In Copilot, run /implement (active prompt: .github/prompts/persona-developer-implement.prompt.md)
4. Tests first (red), code (green), refactor
5. Run the local gate defined by the prototype (./mvnw verify, npm test, npm run lint, or equivalent)
6. git commit, git push, open PR
7. Mark the issue with "Closes #NN" in the PR body
```

### DBA

```text
1. Pick a schema or migration task
2. git checkout -b impl/NNN-feature
3. Add the Flyway migration in backend/src/main/resources/db/migration/
4. Run the /migration prompt (active prompt: .github/prompts/persona-dba-migration.prompt.md)
5. Test locally against the team's Postgres or with Testcontainers
6. Open PR and ask Developer for review
```

### QA Engineer

```text
1. Follow every implementation PR
2. Run the /coverage-gaps prompt to find REQ-IDs without coverage
3. Add tests on the implementation branch (pairing with Developer)
4. The /test-strategy prompt produces a test plan for new features
5. Block the merge if coverage drops below 70%
```

### DevOps Engineer

```text
1. Pick an infrastructure task (Azure config, CI/CD, deployment)
2. git checkout -b infra/NNN-azure-foo
3. Edit Terraform modules in infra/
4. Run terraform fmt + terraform validate locally
5. Run the /iac-module prompt (active prompt: .github/prompts/persona-devops-engineer-iac-module.prompt.md)
6. Open PR; workflows/ci.yml runs Terraform validation
```

### Tech Writer

```text
1. After each merge to develop, look for drift in ADRs and the glossary
2. Run the /doc-drift prompt (active prompt: .github/prompts/persona-tech-writer-doc-drift.prompt.md)
3. Update 01-arqueologia/glossary.md, docs/adr/, and the READMEs
4. Open one small PR per documentation update
```

---

## Step 13: Smoke test (whole team, at 10:30)

The team lead reads each item aloud. Each person confirms it on their own laptop.

- [ ] Every member cloned `workshop-team-XX`
- [ ] Every member can run `git checkout develop && git pull origin develop` (write access confirmed)
- [ ] CI ran on the initial template commit - green check in the **Actions** tab
- [ ] The team confirmed that there is no ready-made prototype: `backend/`, `frontend/`, and Docker/infra files will be created in Stage 3 when needed
- [ ] Every Copilot Chat answers "What stack are we using in this project?" with the correct answer
- [ ] Every member installed the official Spec-Kit: `specify version` prints a version
- [ ] The `/speckit.*` commands appear in Copilot after `specify init . --integration copilot`
- [ ] Opening **New issue** on GitHub shows three templates (spec, adr, task)
- [ ] All five team members appear in repo Settings -> Collaborators
- [ ] Every persona read its card in `05-personas/XX-role/PERSONA.md`
- [ ] The team lead updated `.github/copilot-instructions.md` with everyone's names
- [ ] `.github/agents`, `.github/prompts`, `.github/instructions`, and `.github/skills` are present and consolidated
- [ ] [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) was read aloud once (the day's timeline)

When all 13 items are green, your team is ready for **Stage 1: archaeology**.

---

## Troubleshooting

<details>
<summary><strong>Common errors and how to fix them</strong> - click to expand</summary>

### Copilot does not read `copilot-instructions.md`

- VS Code must be open **at the repository root**, not inside a subfolder.
- Restart VS Code after editing the file.
- In Settings, confirm that `github.copilot.chat.useProjectInstructions` is `true` (default in 1.93+).

### The **Use this template** button does not appear

- Confirm that you opened the main workshop repository, not another team's repository.
- If it still does not appear, ask the facilitators to confirm whether **Template repository** is enabled in Settings -> General.
- Do not use **Import repository**. The official workshop path is **Use this template**.

### The name `workshop-team-XX` is already in use

- Confirm that you are using the correct team number.
- If the facilitators allow it, add a short suffix, for example `workshop-team-01b`.

### `specify init` fails or `/speckit.*` commands do not appear

- Confirm that `uv`, Python 3.11+, and Git are installed.
- Run `specify version` to confirm that you installed the official CLI.
- Run `specify init . --integration copilot` again at the repository root.
- Reload VS Code: Command Palette -> **Developer: Reload Window**.

### CI fails on the first push with "no tests found"

- Expected. The `ci.yml` workflow only runs jobs whose paths changed. When backend or frontend code lands, the relevant jobs run.

### Docker is not available when the team needs it

- Ports 5432, 8080, or 3000 may already be in use. Run:

  ```bash
  lsof -i :5432 -i :8080 -i :3000
  ```

  Kill the process that is using the port (`kill -9 <PID>`) before you start the environment created by the team.

- Make sure Docker Desktop is **running** (the menu bar icon should be steady, not animated).

### Copilot Agent mode does not appear in the dropdown

- Update VS Code to **1.93 or later** (or install **VS Code Insiders**).
- Reload the window: Command Palette -> **Developer: Reload Window**.

### "Permission denied" when pushing to `main`

- Branch protection (Step 4) is doing its job. Open a Pull Request from your feature branch instead.

### I pulled the latest `develop`, but my IDE still shows old code

- Reload the VS Code window: Command Palette -> **Developer: Reload Window**.
- If VS Code still shows stale state, close and reopen the repository folder.

### The `.github/` folder looks broken

- Do not copy persona kits manually over the consolidated `.github/`.
- If something looks broken, restore it with `git checkout develop -- .github/` or ask a facilitator for help before you try to overwrite files.

</details>

---

### Continue reading

| Previous | Next |
|---|---|
| [Team flow](00-TEAM-FLOW.md)<br/><sub>8-hour schedule, pair handoffs, 20-minute rule, definition of done.</sub> | [Overview of the 10 personas](05-personas/OVERVIEW.md)<br/><sub>Comparison table: pair, stage lead, emergency defaults.</sub> |

<sub>[Back to the kit index](README.md)</sub>
