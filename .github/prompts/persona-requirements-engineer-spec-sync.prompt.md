---
name: "spec-sync"
agent: "requirements-engineer"
description: "Synchronize spec.md with the current codebase"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /spec-sync

## Task

Detect drift between `specs/<NNN>-<feature>/spec.md` and the implementation. Produce a synchronization report and a proposed specification update.

## Steps

1. Parse the REQ-IDs from `spec.md`.
2. Use grep in the codebase to find REQ-ID references (in comments, test names, and commit messages).
3. For each REQ-ID, classify it as Implemented (has code + test), Partial (code only), Orphaned (no code), or Undocumented (the code references an unknown REQ-ID).
4. For behavioral drift, select three representative flows and compare the specification with the actual code path.
5. Propose additions or updates to `spec.md` for any Undocumented items found.

## Output

- Drift table: `REQ-ID | Status | Evidence (file:line) | Action`
- Proposed specification patch in a fenced diff block
- "Top 3 drifts by risk" summary

## Quality gate

- [ ] Every REQ-ID in the specification is classified
- [ ] Every Undocumented finding has a proposed REQ-ID and an EARS statement
- [ ] Evidence cites the exact file:line
- [ ] The proposed patch applies cleanly to the current `spec.md` structure
