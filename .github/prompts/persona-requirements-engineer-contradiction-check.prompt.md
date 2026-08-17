---
name: "contradiction-check"
agent: "requirements-engineer"
description: "Detect contradictions between requirements in spec.md—same feature, different rules—before they become production bugs."
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /contradiction-check

## Objective

You are the requirements engineer auditing `spec.md` for **contradictions**: pairs of requirements that cannot be satisfied at the same time. Contradictions found now are specification fixes; contradictions found in production are incidents. The deliverable is a list of potential conflicts with evidence, severity, and a proposed resolution.

## Inputs

Ask the user for any missing information.

- The specification file (`specs/<NNN>-<feature>/spec.md`).
- Any related parent specifications whose REQ-IDs are referenced by this one.
- The constitution (`.specify/memory/constitution.md`)—contradictions must also be checked against constitutional rules.
- Any clarification log already produced by `/speckit.clarify`.

## Process

1. **Index all requirements.** For each `REQ-ID`, capture the EARS pattern, trigger (event/state/condition), action, actor, outcome, and quantitative limits.
2. **Scan pairs within each domain.** Group REQ-IDs by domain (`PAY-*`, `BEN-*`, etc.). Compare each pair. Check cross-domain pairs afterward.
3. **Look for the four classic contradictions.**

- **Direct contradiction**—REQ-A says "the system shall X under condition C"; REQ-B says "the system shall not X under condition C."
- **Threshold conflict**—REQ-A says "respond within 200 ms"; REQ-B says "perform 5 sequential checks each up to 80 ms"—the budgets cannot both be met.
- **State conflict**—REQ-A allows an action while in state S1; REQ-B prohibits it during the overlapping state S2 ⊆ S1.
- **Actor conflict**—REQ-A grants permission to role R1; REQ-B prohibits the same operation for role R2 where R2 ⊇ R1.

4. **Check against the CONSTITUTION.** Any requirement that violates a constitutional rule contradicts the constitution itself (typically category C rules for security, data, or compliance).
5. **Check against legacy invariants.** If a REQ contradicts behavior enforced by the legacy SIFAP system (documented in `01-arqueologia/legado-sifap/legacy-docs/REGRAS-NEGOCIO-2012.md`), flag it as a regression risk.
6. **Rate the severity.**

- **Critical**—direct contradiction, with no possible implementation that satisfies both.
- **Major**—threshold or state conflict that can be resolved only by changing a REQ.
- **Minor**—terminology mismatch concealing actual agreement.

7. **Propose resolutions.** For each finding, suggest one option: (a) merge REQs, (b) split REQs by subcondition, (c) narrow the scope of a REQ, or (d) escalate to the product owner.

## Output

A Markdown report:

```markdown
## Contradiction Report — <feature>

### Summary
- Requirements analyzed: <count>
- Findings: <count by severity>
- Highest severity: <REQ-A vs REQ-B, if any>

### Critical
| # | REQ-A | REQ-B | Type | Evidence | Proposed resolution |
|---|-------|-------|------|----------|---------------------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

### Major
| # | REQ-A | REQ-B | Type | Evidence | Proposed resolution |
|---|-------|-------|------|----------|---------------------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

### Minor
| # | REQ-A | REQ-B | Type | Evidence | Proposed resolution |
|---|-------|-------|------|----------|---------------------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

### Constitutional conflicts
| # | REQ | Rule | Conflict |
|---|-----|------|---------|
| — | none found | | |

### Legacy regression risks
| # | REQ | Legacy invariant | Conflict |
|---|-----|------------------|---------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

### Recommended next step
Resolve Critical and Major findings before approving the specification.
```

## Anti-patterns

- Reporting "the spec is contradictory" without naming the pairs. Reviewers cannot act on it.
- Checking only within one domain. Many contradictions cross domains.
- Ignoring the constitution. Constitutional conflicts have higher severity than conflicts between peer REQs.
- Confusing ambiguity with contradiction. Ambiguity belongs in `/speckit.clarify`; contradiction means incompatibility.
- Resolving issues silently in your head. Always expose and route them—even when the answer seems "obvious."
- Skipping legacy regression checks. SIFAP modernization succeeds or fails based on fidelity to the legacy system.
- Treating threshold conflicts as "can fix in design." If the math does not work, the REQ is wrong.

## Success criteria

- [ ] Every finding cites two REQ-IDs (or one REQ-ID and a constitutional rule, or one REQ-ID and a legacy invariant).
- [ ] Findings are classified by type (Direct / Threshold / State / Actor) and severity (Critical / Major / Minor).
- [ ] Each finding has a one-line proposed resolution.
- [ ] Constitutional conflicts have been checked.
- [ ] Legacy regression risks have been checked against `01-arqueologia/legado-sifap/legacy-docs/`.
- [ ] Critical and Major findings are flagged for resolution before phase sign-off.
- [ ] The output is ready to paste into the specification PR or a clarification ticket.
