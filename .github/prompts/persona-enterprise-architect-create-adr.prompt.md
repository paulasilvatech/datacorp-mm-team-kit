---
name: "create-adr"
agent: "enterprise-architect"
description: "Write an Architecture Decision Record (ADR) capturing the context, options, decision, and consequences of a SIFAP 2.0 architectural choice."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /create-adr

## Objective

You are writing an **Architecture Decision Record** for SIFAP 2.0 using the format in `specs/<NNN>-<feature>/ADRs/`. An ADR is the durable answer to "why did we do it this way?" It captures the context at the time of the decision, the options considered, the chosen path, and the consequences. ADRs are immutable after acceptance—corrections are made through a *new* ADR that supersedes the previous one.

## Inputs

Ask the user for any missing information.

- The decision topic in plain language (for example, "How will SIFAP integrate with the legacy Adabas wrapper?").
- The feature folder where the ADR belongs (`specs/<NNN>-<feature>/ADRs/`).
- The next ADR number—inspect existing files to avoid collisions.
- The linked `REQ-ID`s affected by the decision.
- Stakeholders who must be cited (architect, security, DevOps, product).
- A draft of the chosen direction, even if vague.

## Process

1. **Choose a precise title.** Use a verb-led title framed as a decision: "Integrate legacy Adabas through a REST adapter"—not "Integration approach" or "Ideas about Adabas."
2. **Set the status correctly.**

- `Proposed`—decision drafted and awaiting review.
- `Accepted`—approved by the architecture forum, with a date.
- `Superseded by NNNN`—replaced by another ADR.
- `Rejected`—considered and rejected (still recorded to prevent future rediscussion).

3. **Write the context honestly.** What forces are at play now? Constraints (Java 21, Postgres 16, Azure only, regulatory)? Existing decisions (previous ADRs)? Known and unknown factors?
4. **List at least three options.** Include the status quo and a "do nothing" option when applicable. Each option needs:

- A one-line description.
- Pros (maximum 3 bullets).
- Cons (maximum 3 bullets).
- A cost/risk profile in plain language.

5. **State the decision and rationale.** Use one paragraph for each. Refer to the chosen option by name.
6. **Capture both positive *and* negative consequences.** What becomes possible? What becomes harder? What new risks arise? What other decisions are now forced or constrained?
7. **Link forward and backward.** Cite the REQ-IDs, previous ADRs in the same feature, and non-negotiable items in `.specify/memory/constitution.md` on which this decision depends.
8. **Record the date and signatories.** Include the architecture forum date and the names of approvers (technical lead, software architect, affected persona owners).

## Output

The deliverable is a single file at `specs/<NNN>-<feature>/ADRs/<NNNN>-<title-slug>.md`:

```markdown
# ADR <NNNN> — <decision title>

- **Status**: Proposed
- **Date**: <YYYY-MM-DD>
- **Approvers**: <people participating in the decision>
- **Linked REQs**: REQ-XXX
- **Linked ADRs**: <!-- fill in, if any -->
- **Supersedes**: <!-- fill in, if any -->

## 1. Context
<!-- fill in with evidence, constraints, and questions provided by the team -->

## 2. Options considered

### Option A — <name>
- Pros: <!-- fill in -->
- Cons: <!-- fill in -->
- Cost/risk: <!-- fill in -->

### Option B — <name>
- Pros: <!-- fill in -->
- Cons: <!-- fill in -->
- Cost/risk: <!-- fill in -->

### Option C — <name, if applicable>
- Pros: <!-- fill in -->
- Cons: <!-- fill in -->
- Cost/risk: <!-- fill in -->

## 3. Decision
<!-- fill in only after an explicit team decision -->

## 4. Rationale
<!-- fill in with the rationale stated by the team -->

## 5. Consequences
<!-- fill in with positive effects, negative effects, and confirmed risks -->

## 6. Validation
<!-- fill in with the criteria agreed upon by the team -->
```

## Anti-patterns

- Predetermined ADRs that present only the chosen option. Always list rejected options—half the value lies there.
- "We chose X because it is better." This is not a rationale; describe the forces involved.
- Missing consequences. ADRs without consequences mislead your future self.
- Rewriting an accepted ADR. Create a new one with status `Supersedes NNNN`.
- ADRs without dates. They have no archaeological value.
- No links. ADRs that cite neither REQ-IDs nor previous ADRs are isolated and unreliable.
- Never considering "do nothing." Sometimes the right answer is "later."

## Success Criteria

- [ ] File name follows `<NNNN>-<title-slug>.md`, with no number collision.
- [ ] Status is one of `Proposed`, `Accepted`, `Superseded by NNNN`, or `Rejected`.
- [ ] Date and approvers are recorded.
- [ ] At least three options, each with pros, cons, and cost/risk.
- [ ] The decision explicitly names the chosen option.
- [ ] Consequences include positive effects, negative effects, and risks.
- [ ] Linked `REQ-ID`s and previous ADRs are cited.
- [ ] Validation criteria are included so the decision can be checked later.
