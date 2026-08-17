---
name: "gen-specs-as-issues"
description: "Identify gaps between the SIFAP legacy behavior and the modern spec, prioritize them, and open EARS-backed GitHub issues with legacy traceability."
argument-hint: "area=<focus-area> repo=<owner/name>"
agent: "agent"
tools: ["read", "search", "edit", "execute"]
---
# /gen-specs-as-issues

## What This Does

Systematically finds missing or under-specified behavior for the SIFAP 2.0 modernization, prioritizes it, and turns the top items into detailed GitHub issues. Each issue is written as an EARS specification with a unique REQ-ID and a mandatory `source_legacy:` line, so the work stays traceable from legacy code to modern requirement.

## When to Use

During Stage 2 (specification) or Stage 4 (evolution), when the team needs to convert observed gaps into a prioritized, trackable backlog of specifications.

## Preconditions

- The pair has read the relevant legacy programs — the HARD GATE in [`LEGACY-EXPLORATION-CHECKLIST.md`](../../01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md).
- The archaeology artifacts exist (`01-archaeology/business-rules-catalog.md`, `inventory.md`).
- A target GitHub repository is identified. Do not assume `backend/` or `frontend/` exist — they are created from scratch in Stage 3.

## Inputs the Team Must Provide

- `area` — the focus area or bounded context to analyze (optional; defaults to the whole project).
- `repo` — the `owner/name` of the GitHub repository where issues are created.
- Ask the user for anything that is missing.

## Steps

### 1. Understand the current state

- Read the modern spec in `02-modern-spec/` and `specs/`, the archaeology artifacts in `01-archaeology/`, and any documentation under `docs/`.
- Read the confirmed rules in [`business-rules-catalog.md`](../../01-archaeology/business-rules-catalog.md) with their legacy source ranges.
- Separate what is already specified from what the legacy system does but the modern spec does not yet cover.

### 2. Run a gap analysis

- Compare confirmed legacy behavior against the modern spec only — never invent behavior from memory.
- List 5–7 candidate gaps. For each, note its legacy source (file and line range), current status, and the user impact if it stays missing.

### 3. Prioritize

- Score each gap from 1–5 on User Impact, Strategic Alignment, Implementation Feasibility, Effort, and Risk.
- Rank with `Priority = (User Impact × Strategic Alignment) / (Effort × Risk)` and select the top 3.

### 4. Write each specification in EARS

- Phrase every requirement with one EARS pattern and `SHALL` (see [`requirements.instructions.md`](../instructions/requirements.instructions.md) and the [`ears-validate`](../skills/ears-validate/SKILL.md) skill).
- Assign a unique `REQ-NNN` (or `REQ-AREA-NNN`) ID and a `source_legacy:` line pointing at a real file under `01-archaeology/legacy-sifap/natural-programs/` or `adabas-ddms/`, or `[GREENFIELD] <justification>`.
- Add Given/When/Then acceptance criteria, each tied to the REQ-ID.

### 5. Create the GitHub issues

- Create one issue per prioritized specification with the `gh` CLI (GitHub is the kit's source of truth), plus a parent/EPIC issue when the work needs coordination.
- Label appropriately (for example, `enhancement`, `spec`) and record `blocks`/`blocked by` relationships.
- Name the branch the work will land on: `spec/<NNN>-<feature>` (see [`00-GIT-WORKFLOW.md`](../../00-GIT-WORKFLOW.md)).

### 6. Review

- Summarize the created issues, their dependencies, and a suggested implementation order.

## Issue Body Template

```markdown
## REQ-NNN — <short title>

WHEN <trigger>, the system SHALL <response>.

- source_legacy: 01-archaeology/legacy-sifap/natural-programs/<PROGRAM>.NSP#L<start>-L<end>
- acceptance:
  - AC-NNN.1: Given <context>, When <action>, Then <outcome>.

### Scope
What is included and what is explicitly excluded.

### Priority
Justification from the scoring matrix.

### Dependencies
- Blocks: <issues>
- Blocked by: <issues>
```

## Definition of Done

- [ ] Every gap is backed by a real legacy source (or an explicit `[GREENFIELD]` justification).
- [ ] Every issue states one EARS requirement with a unique REQ-ID and a valid `source_legacy:` line.
- [ ] Every requirement has at least one Given/When/Then acceptance criterion.
- [ ] Issues are prioritized, labeled, and linked by dependency.
- [ ] No behavior is asserted that the team has not read in the legacy code.

## Invocation Example

```text
/gen-specs-as-issues area=payments repo=my-org/sifap-2
```
