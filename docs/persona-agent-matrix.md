# Persona-Agent Matrix

![Reference Type](https://img.shields.io/badge/Type-Reference-171717?style=flat-square)
![Use Who does what](https://img.shields.io/badge/Use-Who%20does%20what-737373?style=flat-square)

> **Path:** [Team Kit](../README.md) › [Docs](README.md) › **Persona-Agent Matrix**

**Maps each persona to every stage agent** — shows who leads, supports, or observes at each point in the day.

| Field | Value |
|---|---|
| **Target audience** | The entire team |
| **When to consult** | At the start of each stage and when forming pairs |
| **Expected outcome** | Clarity about the expected engagement level for each persona |

---

## How to read this matrix

1. Find the row for your persona.
2. Read across to see your intensity level at each stage.
3. For stages where you are the **Lead** or **Support**, read the detailed guidance below.
4. Open the README for the current stage's agent kit to see the complete flow.

---

## The matrix

| # | Persona | @archaeologist | @architect | @builder | @evolution |
|---|---|---|---|---|---|
| 01 | Product Owner | Observer | Support | Observer | Support |
| 02 | Requirements Engineer | **Lead** | Support | Observer | Observer |
| 03 | Enterprise Architect | Support | Support | Observer | Observer |
| 04 | Software Architect | Observer | **Lead** | Support | Observer |
| 05 | Technical Lead | Observer | Support | Support | **Lead** |
| 06 | Developer | Observer | Observer | **Lead** | Support |
| 07 | DBA | Support | Observer | Support | Observer |
| 08 | QA Engineer | Observer | Observer | Support | Support |
| 09 | DevOps Engineer | Observer | Observer | Support | Support |
| 10 | Tech Writer | Support | Observer | Observer | Support |

**Lead** — directs use of the agent and is responsible for stage deliverables.
**Support** — contributes actively and works with the lead.
**Observer** — follows the chat and is ready to help when their specialty is needed.

---

## Guidance by cell

### Stage 1 — @archaeologist

| Persona | What you do |
|---|---|
| **Requirements Engineer (Lead)** | Leads exploration. Opens each Natural program, asks the agent to help decode it, and captures business rules as draft requirements. Owns the rule drafts. |
| Tech Writer (Support) | Builds the domain glossary in real time. Every new term — variable name, field label, or subroutine purpose — enters the glossary with a definition. |
| Enterprise Architect (Support) | Focuses on the big picture: which external systems does the legacy code call? Where do batch inputs originate? Starts drafting the system context. |
| DBA (Support) | Focuses on Adabas DDMs (Data Definition Modules). Documents field types, descriptors, MU/PE structures, and file relationships for the data map. |
| Product Owner (Observer) | Listens and validates. When the team proposes an interpretation of a business rule, confirms or challenges it based on domain knowledge. |
| Other personas (Observers) | Follow the chat. Contribute when someone asks about a pattern in your area, such as a Developer recognizing a calculation. |

### Stage 2 — @architect

| Persona | What you do |
|---|---|
| **Software Architect (Lead)** | Leads bounded-context definition. Uses the Stage 1 data map and call graph to identify natural boundaries. Draws C4 diagrams. Writes the first ADRs. |
| Requirements Engineer (Support) | Converts Stage 1 business rules into formal EARS requirements with `REQ-NNN` IDs. Every requirement needs acceptance criteria. Works with the Software Architect to map requirements to bounded contexts. |
| Enterprise Architect (Support) | Validates the system-context diagram. Ensures integration points — batch feeds, external APIs, and authentication — are captured. Reviews ADRs for architectural consistency. |
| Product Owner (Support) | Prioritizes requirements. With limited time, helps decide what is mandatory versus desirable. |
| Technical Lead (Observer) | Starts considering implementation order. Which bounded context should be built first? What are the dependencies? |
| Other personas (Observers) | Review the emerging specification and flag inconsistencies from their specialties. |

### Stage 3 — @builder

| Persona | What you do |
|---|---|
| **Developer (Lead)** | Writes code. Uses the builder agent to generate JPA entities, Spring services, REST controllers, and Next.js pages. Every code segment traces to a `REQ-NNN`. |
| DBA (Support) | Owns the database layer. Reviews entity mappings, writes Flyway migrations, and validates that the PostgreSQL schema correctly represents the Stage 2 data model. |
| QA Engineer (Support) | Writes tests with the Developer. For each service, produces at least one happy-path test and one error-path test. Monitors coverage and flags gaps. |
| Technical Lead (Support) | Reviews code as it is produced. Checks for standard violations: no field `@Autowired`, no `null` returns, and no TypeScript `any`. Merges pull requests. |
| Software Architect (Support) | Validates that implementation matches design. Flags early deviations from bounded-context boundaries. |
| Other personas (Observers) | Remain available for questions. The Developer may need domain clarification that only the Product Owner or Requirements Engineer can provide. |

### Stage 4 — @evolution

| Persona | What you do |
|---|---|
| **Technical Lead (Lead)** | Writes GitHub Issues for Copilot Agent. Reviews AI-generated pull requests. Decides what to merge and reject. Owns integration and demo readiness. |
| DevOps Engineer (Support) | Writes the GitHub Actions workflow and Terraform modules. Ensures correct tags, secret management, and resource configuration. |
| QA Engineer (Support) | Validates that CI includes every quality gate: lint, build, and test. Reviews test results for AI-generated pull requests. |
| Developer (Support) | Reviews AI-generated code for correctness. Knows the codebase and detects logical errors that automated checks may miss. |
| Tech Writer (Support) | Refines the README, documents the demo script, and ensures retrospective notes capture team learning. |
| Product Owner (Support) | Helps prioritize what must work for the demo versus what can be deferred. Prepares the presentation narrative. |
| Other personas (Observers) | Contribute retrospective observations: what surprised them and what they would do differently. |

---

## Suggested reading order

- [ ] Read the `PERSONA.md` for your role in [`05-personas/`](../05-personas/) — understand your responsibilities.
- [ ] Read your row in this matrix — understand your intensity at each stage.
- [ ] At the start of each stage, open the agent-kit README in [`06-stage-agents/`](../06-stage-agents/).
- [ ] Activate the current stage agent in Copilot Chat and begin working.

## References

- [Agent kits](../06-stage-agents/README.md)
- [Agent architecture](4-agents-explained.md)
- [Consolidated persona kits](../05-personas/)

---

### Continue reading

| Previous | Next |
|---|---|
| [Four Agents Explained](4-agents-explained.md)<br/><sub>Why there are four agents.</sub> | [SDLC Flow](sdlc-flow-guide.md)<br/><sub>Contracts between pairs.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
