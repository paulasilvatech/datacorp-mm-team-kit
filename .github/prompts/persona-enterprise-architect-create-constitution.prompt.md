---
name: "create-constitution"
agent: "enterprise-architect"
description: "Write the Spec-Kit constitution—the non-negotiable rules and principles of SIFAP 2.0."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /create-constitution

## Objective

You are the enterprise architect writing `.specify/memory/constitution.md`—the document that lists the **non-negotiable rules** every contributor agrees to before reading the spec. The constitution is short, explicit, and stable. ADRs make decisions; the constitution defines the boundaries those decisions cannot cross.

## Inputs

Ask the user for any missing information.

- The feature folder (`specs/<NNN>-<feature>/`).
- Existing organizational constraints (security baseline, Azure only, OWASP Top 10, LGPD).
- Any previous constitutions to inherit from (the CONSTITUTION of a parent feature).
- The team and persona owners assigned to this feature.

## Process

1. **Inherit and adapt.** Start from the project-level constitution and tighten or relax it only for this feature, with explicit justification.
2. **Group rules by category.**

- **Stack** — language, framework, runtime versions.
- **Security** — identity, secrets, network, encryption, OWASP baseline.
- **Data** — PII handling, retention, residency, encryption at rest.
- **Operations** — observability, deployment, environments, SLOs.
- **Process** — branching, code review, testing thresholds, ADR cadence.
- **Compliance** — LGPD, regulatory, audit logging.

3. **Make every rule testable.** "Use Java 21" is testable (`mvnw --version`); "use modern Java" is not.
4. **Number the rules.** Use `C1`, `C2`, and so on, so reviewers can cite them.
5. **State the consequence of breaking a rule.** "Build fails," "PR rejected," or "InfoSec exception required"—not silence.
6. **Mark rules as mutable or immutable.** Some rules may be relaxed through an ADR with InfoSec sign-off; others require a new constitution.
7. **Date and sign it.** Include the architecture forum date, named approvers, and version `1.0.0`. Bump the version only when the constitution itself changes.
8. **Keep it short.** Target ≤ 80 lines. If the team cannot remember the constitution, it does not work.

## Output

The deliverable is `.specify/memory/constitution.md`:

```markdown
# CONSTITUTION — <feature> (<feature-folder>)

- **Version**: 1.0.0
- **Date**: 2026-04-29
- **Approvers**: @paula (enterprise architect), @morgan (technical lead), @infosec-lead
- **Scope**: project rules applicable to all features

## 1. Stack
| ID | Rule | Consequence of violation |
|----|------|----------------------|
| C1 | Backend services run only on Java 21 (Temurin) and Spring Boot 3.3. | Build fails. |
| C2 | The frontend runs on Next.js 15 with TypeScript `strict: true`. No `any`. | Lint blocks merge. |
| C3 | PostgreSQL 16 is the only system of record for SIFAP data. | Requires an InfoSec exception. |
| C4 | All cloud infrastructure is on Azure. No multi-cloud for this feature. | New ADR and architecture forum review required. |

## 2. Security
| ID | Rule | Consequence |
|----|------|-------------|
| C5 | Service-to-service authentication uses Azure Managed Identity. No client secrets in code or configuration. | PR blocked. |
| C6 | All secrets are read from Key Vault at runtime. No committed `.env` files. | Gitleaks blocks merge. |
| C7 | The OWASP Top 10 baseline applies—input validation, parameterized SQL, and no string-built queries. | PR rejected. |
| C8 | The CORS allowlist is explicit. No `*` in production configuration. | Stage promotion blocked. |

## 3. Data
| ID | Rule | Consequence |
|----|------|-------------|
| C9 | PII columns carry a `COMMENT` flagging them as PII. | DBA review blocks. |
| C10 | No production PII in `dev` or `stage`. Synthetic data only. | InfoSec finding, immediate revert. |
| C11 | Money is `NUMERIC(15,2)`; never `FLOAT`. | DBA review blocks. |
| C12 | Audit log entries are append-only; no `DELETE` or `UPDATE` on `audit_log`. | Migration rejected. |

## 4. Operations
| ID | Rule | Consequence |
|----|------|-------------|
| C13 | Every public endpoint emits a structured log line with `requestId`, `userId`, `latencyMs`. | Code review blocks. |
| C14 | SLO defined for every user-facing endpoint, in REQ-OPS-*. | Spec review blocks. |
| C15 | Deployments to prod require two reviewers and a linked change ticket. | Pipeline blocks. |

## 5. Process
| ID | Rule | Consequence |
|----|------|-------------|
| C16 | One branch per spec — `spec/<NNN>-<name>` from `develop`. No direct commits to `develop` or `main`. | PR rejected. |
| C17 | Every requirement uses EARS notation; every test cites a `REQ-ID`. | Spec review blocks. |
| C18 | Every architectural decision is captured as an ADR before code lands. | Code review blocks. |

## 6. Compliance
| ID | Rule | Consequence |
|----|------|-------------|
| C19 | LGPD subject-rights endpoints (read, delete, export) covered by REQ-COMP-*. | Compliance review blocks release. |
| C20 | TCU/SISP audit trail completeness verified before each release. | Release manager blocks. |

## 7. Mutable vs immutable
- Mutable (relaxable via ADR + InfoSec sign-off): C13–C18.
- Immutable (constitutional change required): C1, C3, C4, C5, C6, C7, C9, C10, C19, C20.

## 8. Amendment process
Open a PR for this file. The architecture forum reviews it, and the version is updated (`1.0.0` → `1.1.0` minor, → `2.0.0` major). New approvers must sign off.
```

## Anti-patterns

- Long constitutions that nobody reads. Cut them to ≤ 80 lines.
- Rules without consequences. Soft rules become optional.
- Rules without IDs. Reviewers cannot cite them.
- Mixing principles ("we value quality") with rules ("Java 21 only"). Principles belong elsewhere; the constitution consists of rules.
- "Best practices" wording. State the rule.
- No mutable/immutable distinction. Every rule appears equally rigid, so teams overcomply or rebel.
- No amendment process. Outdated constitutions are ignored.

## Success Criteria

- [ ] File length ≤ 80 lines (excluding signatures).
- [ ] Every rule has an ID and a consequence for violation.
- [ ] At least one rule per category (Stack, Security, Data, Operations, Process, Compliance).
- [ ] Mutable vs. immutable distinction is stated.
- [ ] Amendment process is documented.
- [ ] Inherits from a parent constitution when one exists.
- [ ] Approvers and date are recorded.
- [ ] Version follows semver.
