---
name: "setup-project"
agent: "tech-lead"
description: "Initialize a new Copilot-enabled project"
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /setup-project

## Task

Initialize a project with the Copilot context engineering scaffold: AGENTS.md, CODEMAP.md, `.github/instructions/`, `.github/prompts/`, `.github/agents/`, and `.github/copilot-instructions.md`.

## Steps

1. Detect the technical stack from existing files (package.json, pom.xml, requirements.txt, *.csproj).
2. Create AGENTS.md with a stack summary, code conventions, test command, lint command, and build command.
3. Create a CODEMAP.md skeleton with `## Modules`, `## Data Flow`, and `## External Integrations` sections.
4. Create `.github/copilot-instructions.md` with the team's standard language, tone, and security rules.
5. Add baseline instructions files scoped with `applyTo:` (for example, `**/*.java`, `**/*.ts`).
6. Stage the changes, but do not commit. Print the list of created files.

## Output

- List of created files (absolute paths)
- Suggested message for the first commit
- Three follow-up actions the user must perform manually

## Quality gate

- [ ] AGENTS.md is specific to the detected stack, not generic
- [ ] Every instructions file has an `applyTo:` scope
- [ ] No secrets, credentials, or placeholders such as TODO
- [ ] `.gitignore` is updated if new folders need to be tracked
