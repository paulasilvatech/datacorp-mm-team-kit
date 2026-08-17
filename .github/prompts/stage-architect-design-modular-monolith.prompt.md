---
name: "design-modular-monolith"
description: "Records in plan.md only the Modular Monolith design required for the selected feature."
argument-hint: "feature=NNN-feature-name"
agent: "architect"
tools: ["read", "search", "edit"]
---
# /design-modular-monolith

## Objective

Record in `specs/<NNN>-<feature>/plan.md` only the design decisions that
unblock the first implementation. The prompt does not create a generic
architecture, endpoints, contracts, or diagrams without evidence from the feature.

## Preconditions

- `specs/<NNN>-<feature>/spec.md` exists and every REQ-ID has `source_legacy:`;
- the team confirmed the scope in Stage 2;
- the design question to resolve has been stated.

## Process

1. Read `spec.md`, `plan.md`, and the scope decisions in `02-spec-moderna/`.
2. Request evidence for any boundary, integration, or contract not described
   by the feature. Record the question; do not fill gaps through assumptions.
3. Describe in `plan.md` the smallest module, data, and communication structure
   required by the first task.
4. Create a Mermaid diagram or contract only when it resolves a concrete
   implementation question. Reference it from `plan.md`.
5. Link the design to existing REQ-IDs and relevant supporting decisions.

## Constraints

- Do not suggest microservices; the target is a Modular Monolith.
- Do not write implementation code.
- Do not fill in requirements, endpoints, schemas, or decisions that the team
  has not confirmed.
- Do not use `02-spec-moderna/` as the location for `spec.md`, `plan.md`, or
  `tasks.md`.

## Definition of Done

- [ ] `plan.md` describes only the design required for the narrow feature.
- [ ] Every decision has evidence or an explicit open question.
- [ ] Every supporting artifact is linked from `plan.md`.
- [ ] The plan allows Pairs 3 and 4 to start the first task without creating
      additional scope.
