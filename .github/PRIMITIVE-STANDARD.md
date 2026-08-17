# Copilot Primitive Standard

`.github/` holds this kit's Copilot **primitives**: agents, prompts, instructions, skills, and hooks. This file is the written, citable standard for how every one of them is structured, so a new primitive can match the existing set without reverse-engineering it. The gold-standard reference the team names is the archaeologist agent ([`archaeologist.agent.md`](agents/archaeologist.agent.md)); the patterns below are derived from it and its peers.

> [!IMPORTANT]
> The documentation style guide ([`../docs/DOC-STYLE-GUIDE.md`](../docs/DOC-STYLE-GUIDE.md), rule R4) deliberately governs `docs/` and the numbered stage folders **only** — never `.github/`. Copilot primitives follow *this* standard instead, so a documentation pass must not restructure a primitive as prose.

## The harness model

A primitive is one surface of the repository's agent harness. The model (from [`skills/harness-engineering/SKILL.md`](skills/harness-engineering/SKILL.md)) is:

```text
Harness = Instructions + Constraints + Feedback + Memory + Evaluation + Governance
```

| Layer | Primitive that carries it |
|---|---|
| Instructions | `copilot-instructions.md`, `instructions/*.instructions.md` |
| Constraints | `hooks/*.json` that block a tool call; instruction `applyTo` scoping |
| Feedback | prompts and agents that run checks and report back |
| Memory | [`../docs/failures/README.md`](../docs/failures/README.md) |
| Evaluation | `workflows/spec-quality.yml` plus `scripts/validate-copilot-primitives.py` |
| Governance | this standard, enforced by the `copilot-primitives` CI job |

Prefer updating an existing primitive over adding a near-duplicate one.

## Rules that apply to every primitive

### Markdown and style

- [ ] English only. No emojis — convey NOTE, TIP, IMPORTANT, WARNING, and CAUTION with GFM alerts such as `> [!NOTE]`.
- [ ] Exactly one H1 (`#`) per file — the document title, below the frontmatter.
- [ ] The blank line between the closing `---` and the H1 is optional, and both forms lint clean: agents, prompts, and skills omit it, while the instruction files keep one. MD022 does not fire on the frontmatter boundary and is not overridden, so match the sibling files in the same directory rather than forcing a churn-only diff.
- [ ] Never skip a heading level; go `#`, then `##`, then `###`.
- [ ] Every fenced code block declares a language (for example `java`, `json`, `text`, or `bash`).
- [ ] Use real GFM tables (with the `|---|` separator row) whenever there are two or more dimensions, and `- [ ]` checklists for anything the reader must verify.
- [ ] End with exactly one trailing newline. No trailing whitespace, hard tabs, or consecutive blank lines.
- [ ] Never disable a markdownlint rule inline with an HTML comment pragma (failure #2). The root [`../.markdownlint-cli2.jsonc`](../.markdownlint-cli2.jsonc) is the only lint config; an inline pragma duplicates it and burns context-window tokens for zero instructional value.

### Content and accuracy

- [ ] **Cite the authoritative source for every convention** — do not restate it from the summary in `copilot-instructions.md`. Branch names come from [`../00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md); legacy-reading rules from [`instructions/natural-adabas.instructions.md`](instructions/natural-adabas.instructions.md); EARS and `source_legacy` from [`skills/ears-validate/SKILL.md`](skills/ears-validate/SKILL.md).
- [ ] **Branch prefixes** (authoritative table in [`../00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md)): `spec/<NNN>-<feature>`, `impl/<NNN>-<feature>`, `infra/<component>`, `docs/<topic>`, and `agent/<issue-NN>` — each cut from `develop`. Never collapse `impl/` into `spec/` (failure #1).
- [ ] **Never invent SIFAP facts.** A primitive teaches *how to discover* legacy behavior; it never states what a business rule is. The corpus under `01-archaeology/legacy-sifap/` is 24 Natural members (12 `.NSP`, 5 `.NSN`, 2 `.NSC`, 2 `.NSA`, 1 `.NSL`, 2 `.jcl`), 4 `.ddm` DDMs, and 1 FDT `.txt` listing. No `.NSD` file exists.
- [ ] **Approved toolchain only.** Never recommend, install, or switch to Cursor, Windsurf, Codex, Cline, Continue, Aider, Codeium, Tabnine, IntelliJ, Eclipse, or Neovim; VS Code with GitHub Copilot is the only approved editor and assistant.
- [ ] Call the event a workshop, never a `hackathon`.
- [ ] Use the current English paths only; the retired Portuguese directory names are rejected by the validator's stale-path check (failure #5). `backend/` and `frontend/` do **not** exist yet (the team creates them in Stage 3); `infra/` **does** exist.

## Frontmatter by primitive type

Frontmatter is a closed schema per type: an unknown, retired, or invalid key **fails the `copilot-primitives` gate**. Keys marked platform-specific are silently ignored on other surfaces, so they are safe to keep. Quote `name` and `description` string values — the established house convention across the kit; the few unquoted skill imports are drift still being normalized, not a counter-pattern.

### Agent frontmatter

File: `agents/<id>.agent.md`.

| Key | Notes |
|---|---|
| `name` | Agent id; conventionally present. Renaming an agent silently breaks every prompt that binds to it via `agent:`. |
| `description` | The only key the gate strictly requires. |
| `tools` | For example `[read, search, edit]`; add `execute` or `"github/*"` only when needed. |
| `model` | Optional. |
| `handoffs` | Stage agents only (VS Code only). Persona agents never use it. |
| `target`, `user-invocable`, `disable-model-invocation`, `metadata`, `agents` | Optional. |
| `mcp-servers` | GitHub.com and CLI only. |
| `argument-hint` | VS Code only. |

The `infer:` key is retired — remove it.

> [!NOTE]
> Only the sequential **Stage** agents carry `handoffs`, and only when a next stage exists: `archaeologist -> architect -> builder` each hand off to the next, while the terminal Stage 4 agent (`evolution`) has none. No persona agent has `handoffs`.

### Prompt frontmatter

File: `prompts/<name>.prompt.md`. The slash-command name derives from the filename unless `name:` overrides it. Valid keys: `name`, `description`, `agent`, `model`, `tools`, `argument-hint`.

- `agent:` must resolve to a built-in (`ask`, `agent`, or `plan`) or a file in `agents/`.
- `mode:` is stale (old chat-mode syntax, superseded by `agent:`) — remove it.
- `tested_with:` is invented and does nothing — remove it.

### Instruction frontmatter

File: `instructions/<name>.instructions.md`. Valid keys: `applyTo`, `name`, `description`, `excludeAgent`.

- Scope `applyTo` to concrete globs. `applyTo: "**"` injects the file into every request and **fails the gate**; many files competing for one path such as `**/*.tf` caused failure #6.

### Skill frontmatter

File: `skills/<dir>/SKILL.md`. Only `name` and `description` are valid.

- `name` **must exactly equal the parent directory name** (lowercase letters, digits, and hyphens; 64 characters max) or the skill silently fails to load (failure #4).
- `description` must state **when to use** the skill, because it drives semantic auto-loading, and is capped at 1024 characters.
- `license`, `allowed-tools`, `compatibility`, and `metadata` are **not** in the schema; remove them.

### Hook configuration

A hook is a flat JSON file at `hooks/<name>.json`. A nested `<name>/hooks.json` is **never discovered** and silently never runs (failure #3). The handler script lives in `hooks/<name>/` and must be executable.

- `version` must be `1`; `hooks` maps an event to a list of handlers.
- Events include `sessionStart`, `sessionEnd`, `userPromptSubmitted`, `preToolUse`, and `postToolUse`. A handler `type` is `command`, `http`, or `prompt`.

A `preToolUse` hook blocks a tool call by writing this object to stdout:

```json
{"permissionDecision":"deny","permissionDecisionReason":"..."}
```

## Required body sections

Section structure is machine-checked by `scripts/validate-copilot-primitives.py`. Use these headings, in order.

| Primitive | Required `##` sections, in order |
|---|---|
| Agent | `Mission`, `Lead Personas`, `Operating Principles`, `What This Agent Knows`, `What This Agent Does NOT Know`, `Available Prompts`, a heading ending in `Definition of Done`, `Anti-Patterns This Agent Rejects`, `Spec-Kit Integration` |
| Prompt | `Objective`, `When to Invoke`, `Preconditions`, `Inputs the Team Must Provide`, `What I Will Do`, `What I Will NOT Do`, `Output Format`, optional `Rules from <file>`, `Definition of Done`, `Prompt Body`, `Invocation Example` |
| Instruction | concrete topic sections, then `Conventions`, `Do / Do Not`, `Checklist Before Opening a PR` |
| Skill | `When to invoke`, a substantive procedure section, `Output template`, `Quality gate` |

## Skeletons

Copy a skeleton, keep the frontmatter and section order, then replace every placeholder in angle brackets.

### Agent skeleton

````markdown
---
name: "<agent-id>"
description: "<Stage N or Persona> assistant — one line"
tools: [read, search, edit]
# handoffs:                 # Stage agents only, and only if a next stage exists
#   - label: "Start Stage <N+1>"
#     agent: <next-agent-id>
#     prompt: "<what the next agent does with this stage's artifacts>"
#     send: false
---
# @<agent-id>-agent

## Mission

<What the agent helps the team do, and the boundary it will not cross.>

## Lead Personas

| Role | Involvement |
|------|-----------|
| **<Persona>** | LEAD — <responsibility> |

## Operating Principles

- **<Principle>.** <One or two sentences of judgment or routing.>

## What This Agent Knows

<General, transferable patterns — never system-specific answers.>

## What This Agent Does NOT Know

<Everything that must emerge from the team's own investigation.>

## Available Prompts

| Command | Purpose |
|---------|---------|
| [`/<command>`](../prompts/<file>.prompt.md) | <purpose> |

## Definition of Done

- [ ] <verifiable outcome>

## Anti-Patterns This Agent Rejects

1. **<Anti-pattern>.** <Why it is rejected, and the redirect.>

## Spec-Kit Integration

<Where the agent sits in the /speckit.* flow.>
````

A Stage agent may prefix the last-but-two heading with its stage, for example `## Stage 1 Definition of Done`.

### Prompt skeleton

````markdown
---
name: "<slash-command>"
description: "<one line>"
argument-hint: "<arg=... arg=...>"
agent: "<agent-id>"
tools: ["read", "search", "edit"]
---
# /<slash-command>

## Objective

<The single outcome this prompt produces.>

## When to Invoke

## Preconditions

## Inputs the Team Must Provide

## What I Will Do

## What I Will NOT Do

## Output Format

```markdown
<the exact shape the prompt appends or emits>
```

## Definition of Done

- [ ] <verifiable outcome>

## Prompt Body

You are the `@<agent-id>`. <Numbered, step-by-step instructions.>

## Invocation Example

```text
/<slash-command> arg=<value>
```
````

When the prompt depends on an instruction or skill, add an optional `## Rules from <file>` section that inlines the rules you enforce, immediately before `## Definition of Done`.

### Instruction skeleton

````markdown
---
description: "Use when <situation this file scopes>."
applyTo: "<glob>,<glob>"
---

# <Topic> — Guide

<One paragraph: what opens this file, what it covers, and which sibling instruction owns the rest.>

## <Concrete topic>

<Guidance with examples.>

## Conventions

| Rule | Rationale |
|---|---|
| <rule> | <why> |

## Do / Do Not

| Do | Do not |
|---|---|
| <do> | <do not> |

## Checklist Before Opening a PR

- [ ] <verifiable item>
````

### Skill skeleton

`name` must equal the `skills/<dir>/` directory name.

````markdown
---
name: "<dir>"
description: "Use when <trigger>. Triggers include \"<keyword>\", \"<keyword>\"."
---
# <Skill title>

## When to invoke

- "<paraphrase a request that should load this skill>"

## <Substantive procedure>

<A checklist, table, or numbered steps — the operational core.>

## Output template

```markdown
<the shape the skill produces>
```

## Quality gate

- [ ] <objective pass/fail check>
````

### Hook skeleton

Flat file `hooks/<name>.json`, with the referenced script in `hooks/<name>/` and marked executable.

```json
{
  "version": 1,
  "hooks": {
    "preToolUse": [
      {
        "type": "command",
        "bash": ".github/hooks/<name>/<script>.sh",
        "cwd": ".",
        "env": { "MODE": "block" },
        "timeoutSec": 10
      }
    ]
  }
}
```

## How the standard is enforced

- The **`copilot-primitives`** job in [`workflows/spec-quality.yml`](workflows/spec-quality.yml) runs [`scripts/validate-copilot-primitives.py`](scripts/validate-copilot-primitives.py): frontmatter schemas, `prompt -> agent` and `handoff -> agent` integrity, one H1, a single trailing newline, relative-link resolution under `.github/`, banned pragmas, banned tooling, stale paths, and the required body sections above.
- The **`markdown-lint`** job runs the root [`../.markdownlint-cli2.jsonc`](../.markdownlint-cli2.jsonc); **`spec-traceability`** and **`legacy-traceability`** enforce REQ-ID and `source_legacy` coverage.
- Every recurring mistake earns an entry and a named guardrail in [`../docs/failures/README.md`](../docs/failures/README.md). Read it before finishing a primitive change, and add an entry when a mistake recurs.

Reference implementations to copy from: [`agents/archaeologist.agent.md`](agents/archaeologist.agent.md), [`prompts/stage-archaeologist-extract-business-rules.prompt.md`](prompts/stage-archaeologist-extract-business-rules.prompt.md), [`skills/ears-validate/SKILL.md`](skills/ears-validate/SKILL.md), [`instructions/modular-monolith.instructions.md`](instructions/modular-monolith.instructions.md), and [`hooks/tool-guardian.json`](hooks/tool-guardian.json).

## Authoring checklist

- [ ] The primitive is in the right folder with the right suffix (`.agent.md`, `.prompt.md`, `.instructions.md`, `SKILL.md`, or a flat `hooks/<name>.json`).
- [ ] Frontmatter uses only valid keys, with no retired (`infer`, `mode`) or invented (`tested_with`) keys, and a skill `name` that equals its directory.
- [ ] All required body sections are present, in order.
- [ ] Exactly one H1, no skipped heading levels, every fence has a language, one trailing newline, and no markdownlint pragma.
- [ ] Every convention cites its authoritative document; no invented SIFAP facts; no banned tooling; English, no emojis.
- [ ] Every relative link resolves on disk.
- [ ] `python3 .github/scripts/validate-copilot-primitives.py` and `npx markdownlint-cli2 "<file>"` both report zero issues.
