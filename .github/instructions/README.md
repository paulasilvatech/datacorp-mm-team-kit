# Instructions Index

This directory contains the GitHub Copilot file-specific instructions for the workshop.

> Important: Copilot discovers `*.instructions.md` files in `.github/instructions/` and its subdirectories. This workshop keeps them directly in this directory so the index and scopes are easy to review.

## Architecture and Legacy

| File | When it applies |
| --- | --- |
| `modular-monolith.instructions.md` | Java/Spring code, Maven/Gradle, and Modular Monolith architecture. |
| `natural-adabas.instructions.md` | Reading Natural/Adabas legacy code, DDMs, copycodes, and artifacts in `01-arqueologia/legado-sifap/`. |

## Implementation

| File | When it applies |
| --- | --- |
| `backend.instructions.md` | APIs, services, controllers, validation, and backend boundaries. |
| `frontend.instructions.md` | Generic frontend components and pages. |
| `frontend-spec.instructions.md` | Next.js 15 App Router, strict TypeScript, Tailwind CSS, and shadcn/ui. |
| `database.instructions.md` | Repositories, migrations, schema, SQL, indexes, and data changes. |

## Delivery and Operations

| File | When it applies |
| --- | --- |
| `cicd.instructions.md` | GitHub Actions, YAML workflows, CI/CD gates, and build/deployment automation. |
| `infrastructure.instructions.md` | Terraform, Bicep, Azure IaC, and environment configuration. |

## Quality, Security, and Requirements

| File | When it applies |
| --- | --- |
| `requirements.instructions.md` | Requirements, EARS, acceptance criteria, traceability, and requirements documentation. |
| `security.instructions.md` | Authentication, authorization, cryptography, secrets, secure configuration, and sensitive code. |
| `tests.instructions.md` | Automated tests, test strategy, coverage gaps, regression, and quality gates. |

## Maintenance Rule

- Every file MUST maintain valid YAML frontmatter with `description` and `applyTo`.
- Avoid `applyTo: "**"`; prefer specific globs.
- When creating a new area, add a new flat `*.instructions.md` file in this directory and update this index.
