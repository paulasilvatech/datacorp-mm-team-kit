---
name: "routing-table"
agent: "tech-lead"
description: "Generate a task routing table by capability profile"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /routing-table

## Task

Produce a routing table that maps SDLC tasks to the required capability profile and explains the cost/quality trade-off without pinning a specific capability or provider.

## Steps

1. Read `specs/<NNN>-<feature>/tasks.md` (or the backlog) and categorize each task as Discovery, Design, Implementation, Refactor, Review, or Mechanical.
2. Recommend a profile for each category:

- Discovery / ambiguous design: deep reasoning.
- Implementation / code review: implementation.
- Mechanical edits / bulk renames / formatting: mechanical.

3. For each task, estimate token cost (approximate order of magnitude) and justify the profile in one sentence.
4. Flag tasks for which a more economical profile is sufficient without compromising acceptable quality. The user chooses the execution context at execution time.

## Output

Markdown table: `Task ID | Category | Capability Profile | Rationale | Est. Cost Tier`.

## Quality gate

- [ ] Every task has a capability profile and justification
- [ ] At least one mechanical-profile candidate is identified (or noted as "none applicable")
- [ ] Cost tiers are consistent (the same category rarely uses different tiers)
- [ ] The justification references the task content rather than generic language
