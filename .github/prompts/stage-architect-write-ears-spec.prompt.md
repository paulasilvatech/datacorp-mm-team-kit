---
name: "write-ears-spec"
description: "Guides the team in recording confirmed EARS requirements in spec.md with mandatory traceability."
argument-hint: "feature=NNN-feature-name rules=01-arqueologia/business-rules-catalog.md"
agent: "architect"
tools: ["search", "edit"]
---
# /write-ears-spec

## Objective

Transform only confirmed Stage 1 rules into formal EARS requirements
in `specs/<NNN>-<feature>/spec.md`. Open questions remain questions; the
prompt does not fill in requirements, acceptance criteria, or architecture through assumptions.

## Preconditions

- `01-arqueologia/business-rules-catalog.md` contains the scope evidence;
- the team identified the `specs/<NNN>-<feature>/` folder;
- the team read each source before drafting.

## Process

1. Confirm with the team which rules belong to the narrow feature. Record
   deferrals in `02-spec-moderna/scope-decisions.md`.
2. For each confirmed rule, validate the `.NSN` or `.ddm` source and only then
   propose a testable EARS requirement.
3. Assign unique REQ-IDs and include `source_legacy:` in each one with the path and,
   when available, line range. For a capability with no legacy equivalent,
   use `[GREENFIELD]` with justification provided by the team.
4. Record Given/When/Then criteria only for behaviors supported by the
   evidence or scope decision.
5. For every question not yet validated in
   `01-arqueologia/mysteries-found.md`, preserve the question, evidence
   in `path:line` format, impact, unconfirmed hypothesis, owner, and status under
   “Open Questions.” Do not convert it into a requirement, propose an answer, or
   change its status.
6. Maintain a `REQ-ID | EARS Pattern | source_legacy | Source Rule |
   Source File` matrix in `spec.md`.

## Constraints

- Do not create a requirement without `source_legacy:`.
- Do not promote a hypothesis or open question to a requirement.
- Do not require a specific number of requirements, C4 diagrams, ADRs, or endpoints: reduce the
  scope if Stage 2 runs out of time.
- Do not write formal artifacts in `02-spec-moderna/`.

## Definition of Done

- [ ] `specs/<NNN>-<feature>/spec.md` contains only the feature requirements.
- [ ] Every requirement has EARS wording, a verifiable criterion, and a valid `source_legacy:`
      or justified `[GREENFIELD]`.
- [ ] Open questions remain outside the requirements.
- [ ] The traceability matrix links each REQ-ID to the reviewed evidence.
