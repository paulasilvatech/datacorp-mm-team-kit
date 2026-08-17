---
name: "ears-convert"
agent: "requirements-engineer"
description: "Convert informal requirements to EARS notation with mandatory legacy traceability"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /ears-convert

## Mandatory pre-check (SIFAP workshop)

Before writing any EARS statement, **require a legacy source** for each input statement. Acceptable sources:

- a file in `01-arqueologia/legado-sifap/natural-programs/*.NSN` (preferred, with a line range)
- a file in `01-arqueologia/legado-sifap/adabas-ddms/*.ddm`
- the literal marker `[GREENFIELD]` with a one-line justification

If the user provides a statement **without** identifying a legacy source, DO NOT produce an EARS statement. Respond:

> "I cannot issue this EARS statement yet. Specify which file in `01-arqueologia/legado-sifap/` is the source (for example, `01-arqueologia/legado-sifap/natural-programs/<PROGRAM>.NSN`) or mark it as `[GREENFIELD]` with a one-line justification. CI rejects EARS statements without `source_legacy`."

Proceed to the steps below only after every statement has an acceptable source.

## Task

Convert a list of informal requirements to EARS notation, classify each by pattern, attach the legacy source, and flag anything that cannot be expressed in EARS.

## Steps

1. For each input statement, identify the pattern: Ubiquitous, Event-driven, State-driven, Optional, Unwanted, or Complex.
2. Rewrite the statement using the correct EARS template:

- Ubiquitous: `The system shall ...`
- Event-driven: `WHEN <gatilho> the system shall ...`
- State-driven: `WHILE <state> the system shall ...`
- Optional: `WHERE <feature> is included the system shall ...`
- Unwanted: `IF <indesejado> THEN the system shall ...`
- Complex: combine the patterns above with `AND / OR` inside the trigger clause.

3. Assign a REQ-ID in the format `REQ-<DOMAIN>-NNN`.
4. Attach the `source_legacy:` line provided by the user (do not invent one).
5. If a requirement cannot be made testable (vague, contradictory, or lacking a metric), flag it as `NEEDS-CLARIFICATION` with the specific ambiguity.

## Output

For each requirement, emit the YAML block below (not a flat table) so the `legacy-traceability` CI job can process it:

```yaml
REQ-<DOMAIN>-NNN:
 pattern: <ubiquitous|event-driven|state-driven|optional|unwanted|complex>
 text: "<EARS statement>"
 source_legacy: <legacy path with line range, or [GREENFIELD] + justification>
 original: "<literal input>"
 notes: "<optional, for example, reason for NEEDS-CLARIFICATION>"
```

## Quality gate

- [ ] 100% of input statements have been processed
- [ ] **Every emitted REQ-ID has a non-empty `source_legacy:` line**
- [ ] No EARS statement contains words such as "appropriate," "reasonable," or "fast" without a metric
- [ ] Every REQ-ID is unique
- [ ] `NEEDS-CLARIFICATION` items include a specific question
