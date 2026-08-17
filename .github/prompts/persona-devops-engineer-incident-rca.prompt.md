---
name: "incident-rca"
agent: "devops-engineer"
description: "Conduct a blameless root cause analysis for a SIFAP 2.0 incident, producing a timeline, contributing factors, and prioritized actions."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /incident-rca

## Objective

You facilitate a **blameless root cause analysis** for a SIFAP 2.0 incident. The deliverable is a single document—`docs/incidents/<YYYYMMDD>-<short-slug>.md`—that captures the timeline, what happened, why it happened, which changes prevent recurrence, and how we will know they worked. The output is read by engineering, SRE, the InfoSec officer, and the platform architect.

## Inputs

Ask the user for anything that is missing.

- Incident ticket ID and severity (`SEV-1` through `SEV-4`).
- Detection time, mitigation time, and resolution time (UTC).
- Affected systems and the `REQ-ID`s linked to violated SLOs.
- Raw timeline data: PagerDuty, Slack channel, Application Insights traces, and deployment timestamps.
- Responder names (for the timeline only—never for assigning blame).

## Process

1. **Restate the impact in customer terms.** Describe the observable effect,
   not only the internal infrastructure symptom.
2. **Reconstruct the timeline minute by minute.** Use UTC. Cite the source for every entry: log, metric, chat message, or human recollection (mark as `[recall]`).
3. **Distinguish detection, mitigation, and resolution.**

- `T0` — first symptom in production.
- `Td` — first detection by automation or a person.
- `Tm` — mitigation (customer impact stops).
- `Tr` — full resolution (system fully recovered).

4. **Find contributing factors, not "the" cause.** Use the "Five Whys," then categorize each factor as code, configuration, dependency, process, observability, or organizational.
5. **Identify what *almost* worked.** Defenses that activated but were insufficient—alerts that paged too late, runbooks that were 80% correct, fallbacks that activated but timed out. This is valuable prevention evidence.
6. **Propose actions.** For every contributing factor, write at least one action with:

- Owner (one person, not a team).
- Target date.
- Verification criteria (how we will know it worked).
- Type—`code`, `config`, `monitoring`, `process`, `documentation`, or `architecture`.

7. **Remain blameless.** Do not associate personal names with mistakes. "The engineer made a typo" is wrong; "The deployment process did not detect the typo" is correct.
8. **Add one risk you did not fix.** Be honest. Record what is too costly to address now and will be reassessed next quarter.

## Output

The deliverable is a Markdown file with this structure:

```markdown
# Incident <YYYYMMDD>-<slug>

- **Severity**: <SEV>
- **Customer impact**: <!-- fill in -->
- **SLO violation**: <!-- fill in: REQ-ID or not applicable -->
- **Total duration**: <!-- fill in -->

## 1. Summary
Two paragraphs. What happened, why, what we did, and what will change.

## 2. Timeline (UTC)
| Time | Source | Event |
|-------|---------------|-------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

## 3. Contributing Factors
<!-- fill in with confirmed factors and their evidence -->

## 4. What Almost Worked
<!-- fill in with observed defenses -->

## 5. Actions
| # | Action | Owner | Type | Due Date | Verification |
|---|--------|-------|------|-----|--------------|
| <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> | <!-- fill in --> |

## 6. Accepted Risks (for now)
<!-- fill in with the accepted risk, owner, and reassessment date -->
```

## Anti-patterns

- Naming individuals alongside errors. RCAs are about systems, not people.
- "The cause was X." There are always multiple contributing factors.
- Actions without owners or dates. They will not happen.
- Actions without verification criteria. We cannot tell whether they worked.
- Hiding politically uncomfortable contributing factors. Trust collapses faster than systems.
- Treating an RCA as a punishment artifact. It is a learning artifact.
- Skipping the timeline because it is laborious. The timeline is the evidence base.

## Success Criteria

- [ ] Customer-impact statement in plain language.
- [ ] The timeline includes at least detection, mitigation, and resolution timestamps with sources.
- [ ] At least three contributing factors across at least two categories.
- [ ] Every action has an owner, type, due date, and verification criteria.
- [ ] At least one "what almost worked" item.
- [ ] At least one accepted risk is named honestly.
- [ ] No individual is blamed by name.
- [ ] SLO/REQ-ID references are included for violated requirements.
