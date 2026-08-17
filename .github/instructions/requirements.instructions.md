---
description: "Use when writing or reviewing requirements, EARS specifications, acceptance criteria, traceability, and docs-backed requirements."
applyTo: "docs/**/*.md,specs/**/*.md,02-spec-moderna/**/*.md"
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Requirements Documentation Conventions

## Format

- EARS notation for formal requirements
- Given/When/Then for acceptance criteria
- Sequential numbering within features
- MUST/SHALL for mandatory requirements, SHOULD for recommendations
- **Every requirement MUST include a `source_legacy:` line** pointing to `01-arqueologia/legado-sifap/natural-programs/*.NSN`, `01-arqueologia/legado-sifap/adabas-ddms/*.ddm`, or `[GREENFIELD] + justification`. CI rejects requirements without this line.
