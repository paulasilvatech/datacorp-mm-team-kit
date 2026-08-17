<!-- markdownlint-disable MD013 MD033 MD041 -->

# QA Engineer — Copilot Kit

> **Track:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **QA Engineer**

**Reference kit for the QA Engineer persona in the SIFAP modernization workshop.**

![Persona](https://img.shields.io/badge/Persona-QA%20Engineer-171717?style=flat-square) ![Pair 4](https://img.shields.io/badge/Par-4%20%C2%B7%20Qualidade-404040?style=flat-square) ![Stages 3 and 4](https://img.shields.io/badge/Est%C3%A1gios-3%20e%204-737373?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Person taking the QA Engineer persona in the workshop |
| **Focus** | Generating tests from EARS specs, covering critical behavior, and keeping the pipeline green |
| **SDLC phase** | Stage 3 — Implementation; Stage 4 — Evolution |
| **Expected outcome** | Passing test suite, green CI pipeline, and guaranteed spec-to-test traceability |

Read first: [PERSONA.md](PERSONA.md).

---

## Concept

The QA Engineer transforms EARS requirements into executable tests. In the SIFAP (Payment Inspection and Administration System) modernization, this persona validates functional equivalence between the Natural legacy behavior and the modern Java 21 code, ensuring that every REQ-ID has at least one verifiable test and that the GitHub Actions CI pipeline remains green.

Why it matters: missing or fragile tests leave the team blind to regressions. In legacy modernization, functional equivalence between old and new behavior can only be proven by tests traceable to requirements.

## Persona kit

All active artifacts live in the repository root `.github/` directory. This folder is a reference; edit the files under `.github/` when maintenance is needed.

| File | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | QA Engineer responsibilities, stages, prompts, and rubrics |
| `.github/agents/qa-engineer.agent.md` | Agent | Test generation, coverage analysis, and quality gates |
| `.github/prompts/persona-qa-engineer-create-tests.prompt.md` | Prompt | `/create-tests` |
| `.github/prompts/persona-qa-engineer-coverage-gaps.prompt.md` | Prompt | `/coverage-gaps` |
| `.github/prompts/persona-qa-engineer-test-strategy.prompt.md` | Prompt | `/test-strategy` |
| `.github/instructions/tests.instructions.md` | Instructions | Testing conventions |

> [!TIP]
> If the facilitator requests a local MCP configuration and this kit has `mcp.json`, copy only that file to `.vscode/mcp.json`.

## Where active artifacts live

- Agents: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Best practices

- [ ] **Follow the test pyramid.** Prioritize more unit tests, a moderate number of integration tests, and fewer end-to-end tests.
- [ ] **Treat a flaky test as a bug.** Isolate, fix, or remove it; never ignore it.
- [ ] **Ensure every assertion proves behavior.** Line coverage without a meaningful assertion does not validate the domain.
- [ ] **Trace tests to requirements.** Every test must reference a REQ-ID in an inline comment.

## SIFAP example

In Stage 2, the QA Engineer validates that every EARS requirement in `spec.md` has testable acceptance criteria. In Stage 3, they write JUnit 5 tests with Testcontainers for `POST /api/v1/beneficios`, verifying scenarios identified in `SIFAP-BEN.NSN`: valid creation, duplicate entry, and missing required fields. They add `// REQ-012` to every test method.

## References

- [Google Testing Blog](https://testing.googleblog.com/)
- [xUnit Test Patterns — Gerard Meszaros](http://xunitpatterns.com/)
- [Software Testing ISTQB](https://www.istqb.org/)
- [Property-Based Testing — jqwik/fast-check](https://jqwik.net/)

---

### Continue reading

| Previous | Next |
|---|---|
| [Persona overview](../OVERVIEW.md)<br/><sub>Table of the 10 personas and their pairs.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Complete QA Engineer persona profile.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
