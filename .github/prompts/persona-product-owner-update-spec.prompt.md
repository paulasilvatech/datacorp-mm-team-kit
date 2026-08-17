---
name: "update-spec"
agent: "product-owner"
description: "Update spec.md for a new or changed feature. Use before implementation."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /update-spec

## Steps

1. Read `specs/<NNN>-<feature>/spec.md`
2. Read `.specify/memory/constitution.md` to understand constraints
3. Identify the section to update
4. Preserve unchanged requirements
5. Add or modify requirements for the new feature
6. Update the version in the frontmatter

## Quality Gate

- [ ] New requirements have acceptance criteria
- [ ] No existing requirement was accidentally removed
- [ ] Constraints in `.specify/memory/constitution.md` are respected
