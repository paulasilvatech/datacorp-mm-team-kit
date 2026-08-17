# Agent failure register

> **Path:** [Team Kit](../../README.md) › [Docs](../README.md) › **Failure register**

**A record of AI-agent and harness failures that already happened in this repository, each paired with the automated check or review point that catches a recurrence.** A failure record without a named guardrail is incomplete.

| Field | Value |
|---|---|
| **Target audience** | Anyone changing agents, prompts, skills, hooks, instructions, or CI |
| **Prerequisites** | Read [`.github/copilot-instructions.md`](../../.github/copilot-instructions.md) |
| **When to read** | Before finishing any harness or documentation change |
| **Expected outcome** | You do not repeat a known mistake, and any new mistake gets a guardrail |

---

## How this register works

This file is the **Memory** layer of the agent harness (see [`.github/skills/harness-engineering/SKILL.md`](../../.github/skills/harness-engineering/SKILL.md)). It is not the same as [`lessons-learned.md`](../lessons-learned.md): that page records human-team process mistakes during the workshop, while this page records **coding-agent and harness-engineering** failures and the check that stops each from recurring.

Rules for every entry:

- Name the **guardrail** — the specific automated check, lint rule, CI job, hook, or review point that catches a recurrence. "Be careful" is not a guardrail.
- Seed only **verified** failures that actually happened in this repository. Do not invent plausible-sounding ones.
- Prefer an automated guardrail. When none is practical, record the manual review point and why automation would be brittle.

## Known failures and their guardrails

| # | Failure | Why it happened (root cause) | Guardrail that catches a recurrence | Evidence |
|---|---|---|---|---|
| 1 | Three separate AI agents each rewrote the Stage-3 `impl/` branch prefix to `spec/` in developer prompts. | `.github/copilot-instructions.md` summarised the flow as only `spec/… → develop → main`, presenting the spec-branch flow as if it were the whole branch strategy. | Root cause removed: the branch-strategy line in [`.github/copilot-instructions.md`](../../.github/copilot-instructions.md) now lists all five persona prefixes and states "Do not collapse `impl/` … into `spec/`". Review point: any PR touching a branch prefix is checked against the per-persona table in [`00-GIT-WORKFLOW.md`](../../00-GIT-WORKFLOW.md). | `00-GIT-WORKFLOW.md` "How to name your branch" table. |
| 2 | 159 inline `<!-- markdownlint-disable … -->` comments spread across 158 files, duplicating rules the root config already disables and burning context-window tokens inside Copilot primitives. | Contributors disabled rules per file instead of trusting the single config, and generators copied the pragma forward. | [`.markdownlint-cli2.jsonc`](../../.markdownlint-cli2.jsonc) is the single config; [`docs/DOC-STYLE-GUIDE.md`](../DOC-STYLE-GUIDE.md) §9 forbids inline pragmas. The `markdown-lint` job in [`.github/workflows/spec-quality.yml`](../../.github/workflows/spec-quality.yml) runs the shared config on every `**/*.md`. Only sanctioned exception: `MD024` in [`docs/adr/0000-template.md`](../adr/0000-template.md). | `.markdownlint-cli2.jsonc` header comment; DOC-STYLE-GUIDE §9. |
| 3 | All 8 hooks were stored as `.github/hooks/<name>/hooks.json` and never ran — Copilot discovers only flat `.github/hooks/NAME.json` manifests. | The nested layout looked tidy but did not match Copilot's flat discovery contract, and nothing checked that a hook actually loads. | Hooks are now flat `.github/hooks/NAME.json` manifests. Detection: `copilot /env` lists loaded hooks — a hook absent from that list is dead — and the Copilot-primitives drift check (`.github/scripts/validate-copilot-primitives.py`, tracked separately) fails on nested `hooks.json`. | Flat `.github/hooks/*.json` manifests. |
| 4 | A skill silently failed to load because its `name:` frontmatter did not exactly match its parent directory. | Copilot resolves a skill by matching `name` to the directory; a mismatch fails with no error, so nothing signals the break. | Detection: the Copilot-primitives drift check (`.github/scripts/validate-copilot-primitives.py`, tracked separately) asserts every `.github/skills/*/SKILL.md` `name` equals its directory; `copilot /env` confirms the skill loads. | `.github/skills/*/SKILL.md` frontmatter. |
| 5 | Directories were renamed to English (`01-arqueologia`→`01-archaeology`, `02-spec-moderna`→`02-modern-spec`, `06-agentes-de-estagio`→`06-stage-agents`, `legado-sifap`→`legacy-sifap`) and 7 stale links survived in `infra/adabas-natural-lab/README.md`. | A bulk rename updated most references, but relative links elsewhere were not swept and no build step failed on a dead relative link. | Guardrail: the `fix-broken-links` hook ([`.github/hooks/fix-broken-links.json`](../../.github/hooks/fix-broken-links.json)) runs a link-fix script on `postToolUse`; the DOC-STYLE-GUIDE per-file checklist (R6, §11) requires a relative-link review before a file is considered done. | Fixed links in `infra/adabas-natural-lab/README.md`. |
| 6 | Two instruction files used `applyTo: "**"`, injecting themselves into every request, and six files competed for `**/*.tf` with contradictory Terraform guidance. | `applyTo` globs were written too broadly, so path-scoped instructions behaved like repository-wide ones and collided. | Guardrail: the Copilot-primitives drift check (`.github/scripts/validate-copilot-primitives.py`, tracked separately) flags over-broad or duplicated `applyTo` globs; reviewers keep one authoritative instruction file per path. | `.github/instructions/*.instructions.md` `applyTo` frontmatter. |
| 7 | A blanket "`mode:` is deprecated, use `agent:`" cleanup was applied mechanically to prompts imported from `github/awesome-copilot`, rewriting the chat-mode selector `mode: 'agent'` into a dangling reference `agent: "agent"` in 11 prompts that named no real agent. | `mode: 'agent'` was a mode *selector* (`ask`/`edit`/`agent`) meaning "run this prompt in agent mode", not an agent name; renaming the key turned it into a reference to an agent that does not exist, and Copilot silently falls back to the default agent, so the intended agent's tools and context were dropped with no error. | Guardrail: the Copilot-primitives drift check (`.github/scripts/validate-copilot-primitives.py`, tracked separately) now requires every prompt's `agent:` to resolve to a real file in `.github/agents/`, so `agent: "agent"` and any other dangling binding fail the gate; the 11 prompts were rebound to named agents. | `.github/prompts/*.prompt.md` `agent:` frontmatter checked against the `.github/agents/` registry. |
| 8 | An agent tried to remove the manual DDM step by forging Natural cataloged DDM objects (`.NGD`) byte by byte. The attempt failed, but its bench (`provisioning/ngd-work/`, `provisioning/ddm-work/`) and an untested 9.6 KB `ngd_encoder.py` were committed into `provisioning/` — the exact directory Terraform stages onto the lab VM, so a dead end shipped as if it were a supported path. | Natural Community Edition ships no `SYSDDM`, so DDM creation genuinely cannot be automated inside the image. Forging the compiled object looked like a way around that, and nothing distinguished "experimental bench" from "code that boots a VM": every file under `provisioning/` was uploaded by a `fileset()` with no exclusions. | Guardrail: the `provisioning-contracts` job in [`.github/workflows/ci.yml`](../../.github/workflows/ci.yml) fails if any `ngd-work/`, `ddm-work/`, `__pycache__/`, `work/` path or `ngd_encoder.py` is tracked under `provisioning/`, and `local.provisioning_scratch_prefixes` in [`infra/adabas-natural-lab/main.tf`](../../infra/adabas-natural-lab/main.tf) excludes the same set from the VM payload. DDMs are created once in NaturalONE and then preserved by `05-backup-restore.sh`. | 15 × `NAT0002` across the forging bench; every generated `.NGD` was rejected by Natural CE 9.3.3. |

## Adding a new entry

- [ ] **Confirm the failure is real.** It happened in this repository (a PR, a CI log, or observed agent behaviour), not a hypothesis.
- [ ] **Write the root cause.** One sentence on why it happened; avoid blame.
- [ ] **Name the guardrail.** The specific check, lint rule, CI job, hook, or review point that catches a recurrence. If none exists, add one or record why automation is impractical.
- [ ] **Cite evidence.** File paths, a PR, or command output.
- [ ] **Run the lint.** `npx --yes markdownlint-cli2 docs/failures/README.md` returns 0 issues.

---

### Continue reading

| Previous | Next |
|---|---|
| [Lessons learned](../lessons-learned.md)<br/><sub>Human-team process mistakes during the workshop.</sub> | [ADR-0001 — Single source of truth for agent instructions](../adr/0001-agent-instructions-single-source-of-truth.md)<br/><sub>Why there is no root AGENTS.md.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
