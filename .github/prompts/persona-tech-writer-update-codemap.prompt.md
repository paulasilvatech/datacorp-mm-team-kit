---
name: "update-codemap"
agent: "tech-writer"
description: "Generate or update CODEMAP.md—a navigable index of the SIFAP 2.0 codebase showing modules, owners, and entry points."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /update-codemap

## Objective

You produce or update `docs/CODEMAP.md`, a one-page navigation guide that a new team member can read in 10 minutes and use to find any module, its owner, its entry points, and its tests. The code map is **not** automatically generated documentation; it is curated. It complements `plan.md` (architecture) and the specification (requirements).

## Inputs

Ask the user for any missing information.

- The repository root path (this workspace).
- Whether to update in place (`update`) or rebuild (`rebuild`).
- The persona ownership table, once created by the team.
- A previous version of `CODEMAP.md`, if one exists.

## Process

1. **List top-level service folders.** Backend services in `backend/src/main/java/br/gov/sifap/<service>/`, frontend routes in `frontend/app/<route>/`, and infrastructure in `infra/modules/<name>/` or the layout created by the team.
2. **Capture five facts for each module.**

- Purpose (one sentence).
- Public entry points (REST endpoints, page routes, CLI commands, IaC entry points).
- Persistent state (tables, queues, blob containers).
- Linked `REQ-ID` ranges.
- Owning persona.

3. **Find tests.** For each module, find the corresponding test directory and link to it.
4. **Find the legacy mapping.** When a module corresponds to a Natural program in
   `01-arqueologia/legado-sifap/natural-programs/`, cite the file and evidence
   confirmed by the team. This makes modernization lineage explicit.
5. **Find non-obvious dependencies.** Look for imports between modules, shared libraries (`commons-*`), and external Azure services. Highlight any module that depends on more than three others because this is a design smell.
6. **Order modules by user-visible value.** Put critical user journeys first, supporting modules next, and infrastructure last.
7. **Render as a single navigable Markdown file.** Keep it under 200 lines. If it exceeds that limit, split it into sub-code maps by service area and link to them.

## Output

The deliverable is `docs/CODEMAP.md` (or subfiles), with this structure:

```markdown
# SIFAP 2.0 Code Map

> Last updated: <YYYY-MM-DD>. Owners: <reference created by the team>.

## 1. Reading guide
- Critical paths: <!-- fill in from the code -->
- See `plan.md` for the architectural rationale; see `spec.md` for requirements.

## 2. Backend services

### <module> — <confirmed purpose>
- **Path**: `<path created by the team>`
- **Tests**: `<test path>`
- **Entry points**: <!-- fill in -->
- **State**: <!-- fill in from the schema and configuration -->
- **REQ-IDs**: <!-- fill in -->
- **Owner**: <!-- fill in -->
- **Legacy lineage**: <!-- fill in with source and evidence, when applicable -->
- **Cross-module dependencies**: <!-- fill in -->

## 3. Frontend routes

### <route> — <confirmed purpose>
- **Path**: `<path created by the team>`
- **Tests**: `<test path>`
- **REQ-IDs**: <!-- fill in -->
- **Owner**: <!-- fill in -->
- **Consumes API from**: <!-- fill in -->

## 4. Infrastructure modules

### <module>
- **Path**: `<path created by the team>`
- **REQ-IDs**: <!-- fill in -->
- **Owner**: <!-- fill in -->

## 5. Cross-cutting libraries
- <!-- fill in only with existing libraries -->

## 6. Observed concerns
- <!-- fill in only with observed findings -->

## 7. How to update this file
Run `/update-codemap` after adding or renaming any module. Do not generate it automatically; curate it.
```

## Anti-patterns

- Generating from `find . -type d`: that is a directory listing, not a map.
- Including every file. The code map names modules, not lines.
- Listing endpoints as `*`. Be specific.
- Omitting legacy lineage for SIFAP. Modernization without lineage is invisible.
- Using teams as owners. The on-call person is the owner.
- Skipping the "Observed smells" section. The code map is also a health check.
- Allowing the file to drift for more than 30 days. An outdated code map is worse than no code map.

## Success criteria

- [ ] Every backend service, frontend route, and IaC module is listed.
- [ ] Each entry has Purpose, Path, Tests, Entry Points, State, REQ-IDs, and Owner.
- [ ] Legacy lineage is named for every module that maps to a Natural program.
- [ ] Cross-module dependencies are declared; modules with > 3 dependencies are flagged.
- [ ] The file remains under 200 lines (or is split into linked subfiles).
- [ ] The last-updated date is set to today.
- [ ] Owning persona names match `pt-br/05-personas/`.
