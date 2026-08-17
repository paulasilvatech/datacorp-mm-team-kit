---
name: "audit-context"
agent: "tech-lead"
description: "Audit the repository's context engineering files"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /audit-context

## Task

Audit the repository's context engineering surface (AGENTS.md, CODEMAP.md, `.github/instructions/*`, `.github/prompts/*`, `.github/agents/*`) and return a prioritized list of corrections.

## Steps

1. List all files in `.github/instructions/`, `.github/prompts/`, and `.github/agents/`, and report line counts.
2. Check the `applyTo:` scope in every instructions file. Flag any file with `applyTo: "**"` or a missing scope.
3. Read CODEMAP.md. Flag it as stale if it has not been updated in the last 30 days or references deleted files.
4. Check the frontmatter of every prompt/agent for an informative `description` (not "TBD"), an `agent` that points to an existing agent when used, minimal tools, and no pinned model selection.
5. Use grep to find stale folder references (rename tracking) and broken relative links.
6. Summarize the findings in a table: `File | Issue | Severity (High/Medium/Low) | Correction`.

## Output

- A Markdown table with one row per finding, sorted by severity.
- A short "Top 3 corrections" summary at the end.

## Quality gate

- [ ] No false positives (every flagged item is an actual issue)
- [ ] Every High-severity item has a concrete correction, not a vague suggestion
- [ ] CODEMAP.md freshness is explicitly reported
- [ ] No suggestions to edit code, only context files
