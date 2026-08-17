---
name: "azure-architecture-autopilot"
description: "Use when the user wants to design Azure infrastructure from natural language or analyze an existing Azure environment into an interactive architecture diagram, then iterate and optionally deploy. Drives a design-diagram-review-deploy pipeline with a bundled offline diagram engine (605+ Azure icons). Triggers include \"create X on Azure\", \"design a RAG architecture\", \"analyze my Azure resources\", and \"draw a diagram for rg-...\". It emits Bicep, which is out of scope for this kit — re-express any adopted design as Terraform."
---
# Azure Architecture Autopilot

A pipeline that designs Azure infrastructure from natural language, or analyzes existing resources, to visualize the architecture as an interactive diagram and then iterate through modification and deployment.

> [!WARNING]
> This kit's IaC is **Terraform (Azure provider `~> 3.x`)**. This skill emits **Bicep**, which is **out of scope** for the kit's deliverables. Use it for exploration, diagrams, and reference only, and re-express any adopted architecture as Terraform under `infra/` (which the team creates in Stage 3), with the required `project`, `environment`, and `owner` tags.

> [!NOTE]
> This skill depends on a bundled Python diagram engine (`scripts/`, no install needed). Deployment phases additionally require the `az` CLI and Bicep tooling. Microsoft Docs fact-checking uses the `web_fetch` and `web_search` tools directly from the main agent.

## When to invoke

- "Create a RAG architecture on Azure."
- "Analyze my current Azure infrastructure and draw a diagram for rg-sifap."
- "Foundry is slow — how should I change this architecture?"
- "I want to reduce cost / strengthen security on this design."

## Bundled diagram engine

The diagram engine is embedded in the skill under `scripts/`. No `pip install` is needed — the bundled Python scripts render interactive HTML diagrams with 605+ official Azure icons, fully offline. The entry point is [scripts/cli.py](scripts/cli.py), which imports [scripts/generator.py](scripts/generator.py) for HTML/SVG rendering and [scripts/icons.py](scripts/icons.py) for icon data.

## User-facing language

Detect the language of the user's first message and provide all user-facing output — questions, progress updates, reports, and Bicep comments — in that language. This skill's own instructions are written in English; adapt the examples, do not copy them verbatim.

## Tool usage

| Need | Tool | Notes |
|---|---|---|
| Fetch URL content | `web_fetch` | Microsoft Docs lookups |
| Web search | `web_search` | URL discovery |
| Ask the user | `ask_user` | `choices` must be a string array |
| Sub-agents | `task` | explore / task / general-purpose |
| Shell execution | shell tool | Discover `az` / `python` / `bicep` paths first |

> [!NOTE]
> Sub-agents cannot use `web_fetch` or `web_search`. Perform Microsoft Docs fact-checks directly from the main agent.

## Path discovery

`az`, `python`, and `bicep` are often not on `PATH`. Discover each once before a phase and cache the result; do not re-discover on every call, and prefer direct filesystem discovery over shell aliases. See the diagram-generation section in [references/phase1-advisor.md](references/phase1-advisor.md) for the Python path plus embedded-engine wiring.

## Progress updates

Report progress with short status lines in the user's language — not emoji. Use one line per action:

```text
Action — reason for it
Done — result
Warning — detail to watch
Failed — cause and next step
```

## Pipeline

Two paths, chosen automatically from the request; when ambiguous, ask the user which they want.

### Path A: new design

Trigger phrases: "create", "set up", "deploy", "build".

```text
Phase 1 (references/phase1-advisor.md)    Interactive design + diagram
  -> Phase 2 (references/bicep-generator.md)  Bicep generation (out of kit scope)
  -> Phase 3 (references/bicep-reviewer.md)    Review + compile check
  -> Phase 4 (references/phase4-deployer.md)    validate -> what-if -> deploy
```

### Path B: analyze and modify

Trigger phrases: "analyze", "current resources", "scan", "draw a diagram".

```text
Phase 0 (references/phase0-scanner.md)    Scan existing resources + diagram
  -> Modification conversation (natural-language change request)
  -> Phase 1 (references/phase1-advisor.md)   Confirm changes + update diagram
  -> Phases 2-4 as in Path A
```

## Phase transition rules

- Each phase follows the instructions in its `references/*.md` file.
- Always tell the user the next step at every transition.
- Do not skip phases — in particular, never skip the what-if between Phase 3 and Phase 4.
- Phase 1 to Phase 2 requires a generated `01_arch_diagram_draft.html` shown to the user; never generate Bicep without a confirmed diagram.
- A post-deployment modification returns to Phase 1, not Phase 0.

## Service coverage

Optimized services: Microsoft Foundry, Azure OpenAI, AI Search, ADLS Gen2, Key Vault, Microsoft Fabric, Azure Data Factory, VNet / Private Endpoint, and AML / AI Hub. All other Azure services are supported at the same quality bar via Microsoft Docs lookups.

| Category | Handling | Examples |
|---|---|---|
| Stable | Reference files first | `isHnsEnabled`, private-endpoint triples |
| Dynamic | Always fetch Microsoft Docs | API version, model availability, SKU, region |

## Reference files

| File | Role |
|---|---|
| [references/phase0-scanner.md](references/phase0-scanner.md) | Existing-resource scan, relationship inference, and diagram |
| [references/phase1-advisor.md](references/phase1-advisor.md) | Interactive design and fact-checking |
| [references/bicep-generator.md](references/bicep-generator.md) | Bicep generation rules (out of kit scope) |
| [references/bicep-reviewer.md](references/bicep-reviewer.md) | Code-review checklist |
| [references/phase4-deployer.md](references/phase4-deployer.md) | validate -> what-if -> deploy |
| [references/service-gotchas.md](references/service-gotchas.md) | Required properties and private-endpoint mappings |
| [references/azure-dynamic-sources.md](references/azure-dynamic-sources.md) | Microsoft Docs URL registry |
| [references/azure-common-patterns.md](references/azure-common-patterns.md) | Private-endpoint, security, and naming patterns |
| [references/architecture-guidance-sources.md](references/architecture-guidance-sources.md) | Architecture guidance sources |
| [references/ai-data.md](references/ai-data.md) | AI and data service guide |

Example outputs: [assets/06-architecture-diagram.png](assets/06-architecture-diagram.png), [assets/07-azure-portal-resources.png](assets/07-azure-portal-resources.png), and [assets/08-deployment-succeeded.png](assets/08-deployment-succeeded.png).

## Output template

The skill produces an interactive HTML diagram plus a design summary. Record the adopted design so it can be re-expressed as Terraform:

```text
Architecture: <name>
Path: A (new design) | B (analyze + modify)
Diagram: 01_arch_diagram_draft.html (generated, shown to user, confirmed)
Services: Foundry, AI Search, ADLS Gen2, Key Vault (private endpoints)
Bicep: generated for reference only (out of kit scope)
Kit follow-up: re-express as Terraform under infra/ with project/environment/owner tags
```

## Quality gate

- [ ] The path (A new design, B analyze and modify) was chosen or confirmed with the user.
- [ ] A diagram (`01_arch_diagram_draft.html`) was generated with the bundled engine and shown before any Bicep.
- [ ] Phases ran in order, with no skipped what-if between review and deploy.
- [ ] Dynamic facts (API version, SKU, region, model availability) were confirmed against Microsoft Docs.
- [ ] User-facing output used the user's language, and the primitive itself contains no emojis.
- [ ] Any adopted architecture is flagged for re-expression as Terraform under `infra/`, since Bicep is out of kit scope.
