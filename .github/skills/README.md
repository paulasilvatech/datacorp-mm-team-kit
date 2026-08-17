# Skills Index

This directory contains the GitHub Copilot Agent Skills for the workshop — **43** in total, each in its own `<name>/SKILL.md`.

> [!NOTE]
> Copilot discovers `SKILL.md` files under `.github/skills/<name>/` and auto-loads a skill by semantically matching your request against its `description`. That matching is invisible to people, which is what this index is for. The descriptions below are load-bearing: each states *when to use* the skill, so keep them accurate.

## Skills by area

All 43 skills, grouped by what they do. Every skill appears in exactly one group.

### Workshop, SDD & requirements (6 skills)

| Skill | Description |
| --- | --- |
| [`ears-validate`](ears-validate/) | Use when validating requirements against EARS notation patterns. Triggers include "EARS", "requirement review", "requirement quality", "shall statement", and "REQ-ID". |
| [`user-story-refine`](user-story-refine/) | Use when refining backlog items, splitting epics, or validating INVEST criteria. Triggers include "refine story", "split epic", "acceptance criteria", "user story", and "INVEST". |
| [`adr-draft`](adr-draft/) | Use when drafting Architecture Decision Records, evaluating alternatives, or documenting technical trade-offs. Triggers include "ADR", "architecture decision", "trade-off", "pick between", and "why did we choose". |
| [`capability-map`](capability-map/) | Use when mapping business capabilities, identifying overlaps or gaps across the enterprise, or aligning IT investments with business outcomes. Triggers include "capability map", "business capability", "domain map", and "enterprise architecture". |
| [`code-modernization`](code-modernization/) | Use when modernizing a legacy system with a disciplined, behavior-preserving workflow. Triggers include "modernize", "legacy code", "COBOL", "business-rule extraction", and "behavior-preserving rewrite". |
| [`refactor-safely`](refactor-safely/) | Use when refactoring legacy code, extracting a service, or making behavior-preserving changes. Triggers include "refactor", "legacy code", "strangler fig", "characterization test", and "mikado method". |

### Java & Spring Boot backend (6 skills)

| Skill | Description |
| --- | --- |
| [`create-spring-boot-java-project`](create-spring-boot-java-project/) | Scaffold a Spring Boot (Java 21) project skeleton via start.spring.io with Maven, springdoc-openapi, and ArchUnit, ready to run with Docker Compose. Use when the user wants to bootstrap a new Spring Boot backend or generate a starter project. Aligns to the kit's Java 21 + Spring Boot 3.3 stack. |
| [`java-springboot`](java-springboot/) | Spring Boot application best practices — package-by-feature structure, constructor injection, DTOs and validation, service-layer transactions, Spring Data JPA, and configuration/secrets handling. Use when building or reviewing Spring Boot backend code and you want idiomatic structure and conventions. Complements the kit's Java 21 + Spring Boot 3.3 stack. |
| [`java-docs`](java-docs/) | Apply Javadoc best practices so Java types and members are documented correctly — summary sentences, @param/@return/@throws, {@code} blocks, @since, and inherited docs. Use when the user asks to write, review, or improve Javadoc or API documentation for Java code. |
| [`java-junit`](java-junit/) | JUnit 5 unit-testing best practices — test structure (Arrange-Act-Assert), lifecycle, parameterized/data-driven tests, assertions, Mockito isolation, and test organization. Use when writing or reviewing plain JUnit 5 unit tests for Java business logic. For Spring Boot slice/integration tests (@WebMvcTest, @DataJpaTest, Testcontainers), use spring-boot-testing. |
| [`spring-boot-testing`](spring-boot-testing/) | Select the right Spring Boot test technique for a scenario — test slices (@WebMvcTest, @DataJpaTest, @RestClientTest, @JsonTest, @SpringBootTest), Testcontainers, Mockito, and AssertJ. Use when writing or reviewing Spring Boot integration or slice tests. Targets the kit's Spring Boot 3.3 + JUnit 5; newer 3.4+/4.0 APIs (MockMvcTester, @MockitoBean, RestTestClient) are noted as out of scope for the kit. |
| [`java-mcp-server-generator`](java-mcp-server-generator/) | Generate a complete Model Context Protocol (MCP) server project in Java using the official MCP Java SDK, with Maven or Gradle and optional Spring Boot integration. Use when the user wants to create, scaffold, or bootstrap a Java-based MCP server that exposes tools, resources, or prompts. |

### Data & database (4 skills)

| Skill | Description |
| --- | --- |
| [`postgresql-optimization`](postgresql-optimization/) | Author and optimize PostgreSQL using its advanced features — JSONB, array/range/geometric types, custom types, full-text search, window functions, indexing, and the extensions ecosystem. Use when the user wants to write, tune, or speed up PostgreSQL queries, schema, or performance. To review existing PostgreSQL code, use postgresql-code-review. |
| [`postgresql-code-review`](postgresql-code-review/) | Review existing PostgreSQL SQL, schema, and functions for PostgreSQL-specific anti-patterns, quality, and security — JSONB operations, array usage, custom types, schema design, function optimization, and Row Level Security (RLS). Use when the user asks to review, audit, or critique existing PostgreSQL code or a migration. To author or optimize new PostgreSQL features, use postgresql-optimization. |
| [`query-optimization`](query-optimization/) | Use when investigating slow queries, designing indexes, or reviewing execution plans. Triggers include "slow query", "explain plan", "index", "query tuning", "N+1", and "table scan". |
| [`safe-migration`](safe-migration/) | Use when planning an online schema change, a zero-downtime migration, or a rollback for a deployment that changed a table. Triggers include "migration", "ALTER TABLE", "zero-downtime", "expand-contract", and "backfill". |

### Frontend & testing (4 skills)

| Skill | Description |
| --- | --- |
| [`playwright-generate-test`](playwright-generate-test/) | Generate a Playwright end-to-end test in TypeScript from a described scenario by driving the Playwright MCP step by step, then run it until it passes. Use when the user asks to create or record a browser or E2E test with Playwright for a web flow. |
| [`tdd-workflow`](tdd-workflow/) | Use when practicing test-driven development, writing a failing test first, or guiding red-green-refactor. Triggers include "TDD", "red-green-refactor", "test first", "failing test", and "write a test". |
| [`test-strategy`](test-strategy/) | Use when designing a test strategy, choosing the test-pyramid shape, defining coverage targets, or evaluating testing investments across unit, integration, and E2E layers. Triggers include "test strategy", "test pyramid", "coverage target", "E2E vs integration", and "testing investment". |
| [`flaky-test-triage`](flaky-test-triage/) | Use when a test is intermittent, CI is unstable, or you need to quarantine a flaky test. Triggers include "flaky test", "quarantine", "intermittent failure", "CI instability", and "flaky dashboard". |

### Azure, IaC & CI/CD (14 skills)

| Skill | Description |
| --- | --- |
| [`azure-architecture-autopilot`](azure-architecture-autopilot/) | Use when the user wants to design Azure infrastructure from natural language or analyze an existing Azure environment into an interactive architecture diagram, then iterate and optionally deploy. Drives a design-diagram-review-deploy pipeline with a bundled offline diagram engine (605+ Azure icons). Triggers include "create X on Azure", "design a RAG architecture", "analyze my Azure resources", and "draw a diagram for rg-...". It emits Bicep, which is out of scope for this kit — re-express any adopted design as Terraform. |
| [`azure-resource-visualizer`](azure-resource-visualizer/) | Use when the user wants a read-only Mermaid diagram of an existing Azure resource group or help understanding how deployed resources relate to each other. Examines resource groups, maps relationships, and generates a documented Mermaid architecture diagram. Triggers include "diagram my resource group", "visualize Azure resources", "how do these resources connect", and "draw my architecture". For a full design-and-deploy pipeline, use azure-architecture-autopilot. |
| [`azure-resource-health-diagnose`](azure-resource-health-diagnose/) | Use when the user reports that a deployed Azure resource is failing, degraded, throttling, or unhealthy, or asks to troubleshoot or investigate one. Diagnoses a specific resource from its logs, metrics, and telemetry, then produces a prioritized remediation plan. Requires the resource to be deployed and emitting telemetry. Triggers include "resource is unhealthy", "troubleshoot Azure", "why is this failing", "diagnose throttling", and "investigate degraded resource". |
| [`azure-well-architected-review`](azure-well-architected-review/) | Use when the user asks for an Azure Well-Architected Framework review, an architecture assessment, or a reliability, security, cost, performance, or operational-excellence audit of an Azure workload. Reviews the five WAF pillars against the workload's IaC (Terraform for this kit; Bicep/ARM also readable) and deployed resources, then opens GitHub issues for the findings. Triggers include "WAF review", "well-architected", "architecture assessment", "reliability audit", and "security review of Azure". |
| [`azure-deployment-preflight`](azure-deployment-preflight/) | Use before deploying Bicep/ARM to Azure to run template syntax validation, what-if analysis, and permission checks. Activate when users mention deploying to Azure, validating Bicep files, checking deployment permissions, previewing infrastructure changes, running what-if, or preparing for azd provision. Triggers include "preflight", "what-if", "validate deployment", "azd provision --preview", and "deployment permissions". |
| [`azure-developer-cli`](azure-developer-cli/) | Use when designing, creating, reviewing, migrating, or troubleshooting Azure Developer CLI (azd) projects with current Microsoft guidance. Covers azd, azure.yaml, AZD templates, Terraform (or Bicep) under infra, AZD environments and secrets, hooks, deployment workflows, and azd-managed CI/CD. Triggers include "azd", "azure.yaml", "azd environment", "azd pipeline", and "azd up". |
| [`azure-devops-cli`](azure-devops-cli/) | Use when managing Azure DevOps resources from the CLI — projects, repos, pipelines, builds, pull requests, work items, artifacts, and service endpoints. Applies only when a team integrates with an existing Azure DevOps organization. Triggers include "az devops", "az pipelines", "az boards", "az repos", and "Azure DevOps automation". |
| [`azure-container-registry-cli`](azure-container-registry-cli/) | Use when working with Azure Container Registry, running az acr commands, or pushing, importing, building, or purging container images in Azure. Covers registries, cloud builds, ACR Tasks, authentication, tokens, geo-replication, and networking. Triggers include "az acr", "push image to ACR", "build image in Azure", "ACR authentication", and "container registry". |
| [`azure-role-selector`](azure-role-selector/) | Use when the user asks which Azure RBAC role to assign to an identity, how to grant least-privilege permissions, or how to author a custom role when no built-in role fits. Recommends the narrowest built-in role, then emits the assignment as Terraform (azurerm_role_assignment), this kit's IaC. Triggers include "which Azure role", "least privilege", "role assignment", "custom role definition", and "grant permissions". |
| [`azure-pricing`](azure-pricing/) | Use when the user asks about the cost of an Azure service, wants to compare SKU or region prices, needs pricing data for an estimate, or asks about Copilot Studio pricing and agent credit consumption. Fetches real-time retail pricing from the public Azure Retail Prices API (no auth) and estimates Copilot Studio credits. Triggers include "Azure pricing", "how much does", "compare SKU price", "cost estimate", and "Copilot Studio credits". For turning an existing workload into cost-optimization issues, use az-cost-optimize. |
| [`az-cost-optimize`](az-cost-optimize/) | Use when the user wants to reduce or optimize Azure spend for an existing workload, right-size resources, or track cost savings as GitHub issues. Analyzes Terraform/Bicep IaC and deployed Azure resources for cost-optimization opportunities, then opens one GitHub issue per opportunity plus a coordinating EPIC. Triggers include "reduce Azure cost", "optimize Azure spend", "right-size resources", and "cost savings issues". For raw price lookups or estimates, use azure-pricing instead. |
| [`iac-review`](iac-review/) | Use when reviewing Terraform, Bicep, or CloudFormation, checking drift, or hardening infrastructure code. Triggers include "review terraform", "review bicep", "IaC review", "drift detection", and "state file". |
| [`terraform-azurerm-set-diff-analyzer`](terraform-azurerm-set-diff-analyzer/) | Use when a Terraform plan for AzureRM resources shows many changes but you only added or removed one element, to separate false-positive Set-ordering diffs from real changes. Covers Application Gateway, Load Balancer, Firewall, Front Door, and NSG. Triggers include "terraform plan noise", "Set-type diff", "all elements changed", "spurious diff", and "filter false positives in CI". |
| [`pipeline-hardening`](pipeline-hardening/) | Use when hardening a CI/CD pipeline, migrating to OIDC, signing artifacts, or meeting SLSA requirements. Triggers include "SLSA", "supply chain", "OIDC", "sigstore", "cosign", "pipeline security", and "GHA hardening". |

### Documentation & diagrams (4 skills)

| Skill | Description |
| --- | --- |
| [`doc-style-lint`](doc-style-lint/) | Use when reviewing documentation for style, clarity, inclusive language, or compliance with Microsoft or Google style guides. Triggers include "doc review", "style guide", "plain language", "inclusive language", and "readability". |
| [`draw-io-diagram-generator`](draw-io-diagram-generator/) | Use when creating, editing, or generating draw.io diagram files (.drawio, .drawio.svg, .drawio.png). Covers mxGraph XML authoring, shape libraries, style strings, flowcharts, system architecture, sequence diagrams, ER diagrams, UML class diagrams, network topology, layout strategy, the hediet.vscode-drawio VS Code extension, and the full agent workflow from request to a ready-to-open file. |
| [`add-educational-comments`](add-educational-comments/) | Add clear, level-appropriate educational comments to an existing source file so it becomes a learning resource, preserving structure, encoding, and build correctness. Use when the user asks to explain, annotate, or add teaching comments to a specific code file in any language; if no file is given, prompt for one. |
| [`comment-code-generate-a-tutorial`](comment-code-generate-a-tutorial/) | Refactor a Python script to PEP 8, add beginner-friendly instructional comments, and generate a complete README.md tutorial (overview, setup, how it works, example usage). Use when the user wants to turn a Python script into a polished, teachable project or produce a step-by-step walkthrough for it. |

### Codebase context & Copilot tooling (5 skills)

| Skill | Description |
| --- | --- |
| [`acquire-codebase-knowledge`](acquire-codebase-knowledge/) | Use this skill when the user explicitly asks to map, document, or onboard into an existing codebase. Trigger for prompts like "map this codebase", "document this architecture", "onboard me to this repo", or "create codebase docs". Do not trigger for routine feature implementation, bug fixes, or narrow code edits unless the user asks for repository-level discovery. |
| [`context-map`](context-map/) | Produce a map of the files relevant to a task — files to modify, dependencies, related tests, reference patterns, and risks — before any code is written. Use when the user wants to scope impact, plan changes, or understand which files a task touches before implementing. |
| [`context-audit`](context-audit/) | Use when a new engineer joins the team, during onboarding to an unfamiliar codebase, or when auditing whether the team shares a common understanding. Triggers include "onboard", "context", "knowledge gap", "bus factor", and "team understanding". |
| [`harness-engineering`](harness-engineering/) | Adopt repository-level harness engineering for coding agents. Use when a user wants to prevent repeated AI coding-agent mistakes by turning failures into durable instructions, drift checks, regression tests, failure memory, and adoption reports tailored to the target repository. |
| [`copilot-sdk`](copilot-sdk/) | Build agentic applications with GitHub Copilot SDK. Use when embedding AI agents in apps, creating custom tools, implementing streaming responses, managing sessions, connecting to MCP servers, or creating custom agents. Triggers on Copilot SDK, GitHub SDK, agentic app, embed Copilot, programmable agent, MCP server, custom agent. |

## Maintenance Rule

- The `name:` in a `SKILL.md` **must exactly equal its parent directory name** (lowercase letters, digits, and hyphens; 64 characters max) or Copilot silently fails to load the skill.
- Only `name` and `description` are valid frontmatter keys; any other key (for example `license`, `allowed-tools`, `compatibility`, or `metadata`) fails the `copilot-primitives` gate.
- `description` is capped at **1024 characters** and must state *when to use* the skill, because it is the only signal Copilot uses to auto-load it.
- Every skill body needs, in order: `## When to invoke`, a substantive procedure section, `## Output template`, and `## Quality gate`.
- The full schema and section contract live in [`../PRIMITIVE-STANDARD.md`](../PRIMITIVE-STANDARD.md) and are enforced by [`../scripts/validate-copilot-primitives.py`](../scripts/validate-copilot-primitives.py). When you add a skill, add its row to the matching group above and keep the total count current.
