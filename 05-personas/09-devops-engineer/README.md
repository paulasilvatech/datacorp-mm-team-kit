# DevOps Engineer — Copilot Kit

> **Track:** [Team Kit](../../README.md) › [Personas](../OVERVIEW.md) › **DevOps Engineer**

**Reference kit for the DevOps Engineer persona in the SIFAP modernization workshop.**

![Persona](https://img.shields.io/badge/Persona-DevOps%20Engineer-171717?style=flat-square) ![Pair 5](https://img.shields.io/badge/Par-5%20%C2%B7%20Opera%C3%A7%C3%B5es-404040?style=flat-square) ![Stage 4](https://img.shields.io/badge/Est%C3%A1gio-4%20%C2%B7%20Evolu%C3%A7%C3%A3o-737373?style=flat-square)

| Field | Value |
|---|---|
| **Target audience** | Person taking the DevOps Engineer persona in the workshop |
| **Focus** | GitHub Actions CI/CD, Terraform infrastructure as code for Azure, observability, and incident response |
| **SDLC phase** | Cross-cutting—Stages 1 through 4; leads Stage 4 — Evolution |
| **Expected outcome** | Green pipeline, reproducible build, valid `terraform plan`, and documented local execution |

Read first: [PERSONA.md](PERSONA.md).

---

## Concept

The DevOps Engineer owns the path from a code commit to something that runs reliably. In the SIFAP (Payment Inspection and Administration System) modernization workshop, this persona ensures that any team machine can start the local environment, GitHub Actions validates every PR, and Terraform describes the target Azure topology even when it is not applied during the workshop.

Why it matters: without a reliable pipeline, the Developer lacks fast feedback, the QA Engineer lacks a stable test environment, and the final demonstration risks failing because of the environment rather than the code.

## Persona kit

All active artifacts live in the repository root `.github/` directory. This folder is a reference; edit the files under `.github/` when maintenance is needed.

| File | Type | Purpose |
|---|---|---|
| `PERSONA.md` | Profile | DevOps Engineer responsibilities, stages, prompts, and rubrics |
| `.github/agents/devops-engineer.agent.md` | Agent | CI/CD, infrastructure as code, monitoring, and incidents |
| `.github/prompts/persona-devops-engineer-pipeline.prompt.md` | Prompt | `/pipeline` |
| `.github/prompts/persona-devops-engineer-iac-module.prompt.md` | Prompt | `/iac-module` |
| `.github/prompts/persona-devops-engineer-incident-rca.prompt.md` | Prompt | `/incident-rca` |
| `.github/instructions/cicd.instructions.md` | Instructions | CI/CD conventions |
| `.github/instructions/infrastructure.instructions.md` | Instructions | Infrastructure conventions |

> [!TIP]
> If the facilitator requests a local MCP configuration and this kit has `mcp.json`, copy only that file to `.vscode/mcp.json`.

## Where active artifacts live

- Agents: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Best practices

- [ ] **Treat everything as code.** Infrastructure, configuration, policies, and runbooks must be versioned.
- [ ] **Keep pipelines under 10 minutes.** Longer pipelines become bottlenecks; parallelize or remove redundant steps.
- [ ] **Store secrets exclusively in a vault.** Never use a versioned `.env`, loose CI variables, or source code.
- [ ] **Choose a deployment strategy based on rollback cost.** Blue/green and canary solve different problems.

## SIFAP example

In Stage 3, the DevOps Engineer creates `.github/workflows/ci.yml`, which runs on every push, configures Java 21 with Maven caching, runs `mvn test`, builds the backend Docker image, and publishes it to the registry. In parallel, they write `infra/networking/` and `infra/database/` Terraform modules describing Azure Database for PostgreSQL and the target VNet. `terraform plan` succeeds even if `apply` is not run that day.

## References

- [Terraform Best Practices](https://developer.hashicorp.com/terraform/language/style)
- [GitHub Actions Hardening](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [The DevOps Handbook — Gene Kim et al.](https://itrevolution.com/product/the-devops-handbook-second-edition/)

---

### Continue reading

| Previous | Next |
|---|---|
| [Persona overview](../OVERVIEW.md)<br/><sub>Table of the 10 personas and their pairs.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Complete DevOps Engineer persona profile.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
