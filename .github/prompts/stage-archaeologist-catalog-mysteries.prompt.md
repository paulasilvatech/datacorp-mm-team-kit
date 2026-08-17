---
name: "catalog-mysteries"
description: "Records open questions with traceable evidence without attempting to resolve them."
argument-hint: "scope=01-arqueologia/"
agent: "archaeologist"
tools: ["search", "edit"]
---
# /catalog-mysteries

## Objective

Record Stage 1 open questions in a neutral, traceable structure. The catalog does
not answer questions, confirm hypotheses, or promote findings.

## When to Invoke

After a team member has identified an open question and can provide or point to
the available evidence.

## Preconditions

- The requester identifies the artifacts authorized for review.
- The legacy content in `01-arqueologia/legado-sifap/` is available as read-only.
- Each record contains or awaits evidence in `path:line` format.

## What I Will Do

- Record each question without providing an answer.
- Copy the available evidence as `path:line`.
- Preserve the impact, explicitly unconfirmed hypothesis, responsible person/area, and status.
- Keep the question open when human validation or evidence is missing.

## What I Will NOT Do

- Resolve, explain, confirm, or infer an answer to a mystery.
- Treat a hypothesis as fact or change its status independently.
- Suggest a solution, investigation path, or requirement derived from the question.
- Modify any file under `01-arqueologia/legado-sifap/`.
- Remove evidence or traceability provided by the team.

## Output Format

Update only `01-arqueologia/mysteries-found.md` with this structure:

```markdown
| ID | Open question | Evidence (`path:line`) | Impact | Hypothesis (unconfirmed) | Responsible person/area | Status |
| -- | ------------- | ---------------------- | ------ | ------------------------ | ----------------------- | ------ |
|    |               |                        |        |                          |                         |        |
```

In `ID`, use the canonical identifier provided by the person (`SIFAP-M-01` … `SIFAP-M-20`)
or `BONUS` for a finding outside the canonical list. There are **20 canonical mysteries, 4 per
pair** — see `01-arqueologia/mysteries-checklist.md`. Do not infer or assign the ID
independently: the person reading the code decides which mystery the evidence corresponds to.

Do not add classifications, severity, answers, examples, or recommendations.

## HARD GATE and Traceability

A question cannot be marked as closed, converted into a business rule, or
used in a requirement until a responsible person provides explicit human validation
supported by evidence in `path:line` format. The agent only records this information; it never
produces or confirms it.

## Definition of Done

- [ ] Each row contains the six fields in the record structure.
- [ ] All available evidence uses `path:line`.
- [ ] Every hypothesis is explicitly marked as unconfirmed.
- [ ] Each row identifies a responsible person or area and a status.
- [ ] No row contains an agent-generated answer, conclusion, or solution.
- [ ] No legacy file was modified.

## Invocation Example

```text
/catalog-mysteries scope=01-arqueologia/
```
