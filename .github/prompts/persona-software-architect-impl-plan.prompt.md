---
name: "impl-plan"
agent: "software-architect"
description: "Structure the feature plan.md with phased tasks and capability profiles"
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /impl-plan

## Task

Structure `specs/<NNN>-<feature>/plan.md` to sequence tasks into phases, mark parallelizable work, record the capability profile required for each task, and define exit criteria.

## Steps

1. Read the feature's `spec.md`, `plan.md`, and `tasks.md`.
2. Group tasks into phases based on dependency order (foundation → features → hardening).
3. Within each phase, mark tasks as parallelizable with `[P]` if they touch disjoint files and have no runtime dependency.
4. Assign a capability profile to each task: deep reasoning (architectural), implementation, or mechanical. The user chooses the execution context when running the task.
5. Define a Definition of Done for each phase: tests passing, documentation updated, and code review complete.

## Output

A `plan.md` section containing:

- Phase headings, each with an objective, duration estimate, and exit criteria
- Task table for each phase: `Task ID | Title | [P] | Capability Profile | Est. Effort | Traces To (REQ-ID)`
- Global risks section with mitigations

## Quality gate

- [ ] Every task traces to at least one REQ-ID
- [ ] `[P]` tasks actually touch independent files (verified with grep)
- [ ] Phase exit criteria are measurable
- [ ] No task exceeds one day of effort without decomposition
