---
name: "azure-devops-cli"
description: "Use when managing Azure DevOps resources from the CLI — projects, repos, pipelines, builds, pull requests, work items, artifacts, and service endpoints. Applies only when a team integrates with an existing Azure DevOps organization. Triggers include \"az devops\", \"az pipelines\", \"az boards\", \"az repos\", and \"Azure DevOps automation\"."
---
# Azure DevOps CLI

Manage Azure DevOps resources with the Azure CLI plus the `azure-devops` extension.

> [!NOTE]
> This kit's source of truth for work, code, and CI is **GitHub** (Issues, Pull Requests, Actions, Projects). Use this skill only when a team must also drive an existing Azure DevOps organization. Do not migrate the kit's workflow to Azure DevOps.

## When to invoke

- "Create a pull request in our Azure DevOps repo from the CLI."
- "Queue a pipeline run and watch its status without opening the portal."
- "Bulk-update work items from a script."
- "List the branch policies on our Azure DevOps repository."

## Prerequisites

Install the Azure CLI and the Azure DevOps extension:

```bash
brew install azure-cli                                     # macOS
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash     # Linux
az extension add --name azure-devops
```

## Authentication

Authenticate with a Personal Access Token (PAT), then set defaults so you do not repeat `--org`/`--project`:

```bash
export AZURE_DEVOPS_EXT_PAT="<your-pat>"
az devops login --organization https://dev.azure.com/{org}
az devops configure --defaults organization=https://dev.azure.com/{org} project={project}
az devops configure --list
```

> [!WARNING]
> Never hardcode a PAT in a script, commit, or command that will be logged. Pass it through the `AZURE_DEVOPS_EXT_PAT` environment variable (or a secret store) and scope it to the minimum required permissions.

> [!NOTE]
> The legacy URL `https://{org}.visualstudio.com` should be replaced with `https://dev.azure.com/{org}`.

## CLI structure

```text
az devops          Main DevOps commands
├── admin          Administration (banner)
├── extension      Extension management
├── project        Team projects
├── security       Security operations (group, permission)
├── service-endpoint   Service connections
├── team           Teams
├── user           Users
├── wiki           Wikis
├── configure      Set defaults
├── invoke         Invoke REST API
├── login / logout Authenticate / clear credentials

az pipelines       Azure Pipelines
├── agent / pool / queue   Agents, pools, queues
├── build          Builds
├── folder         Pipeline folders
├── release        Releases
├── runs           Pipeline runs
└── variable / variable-group   Variables and groups

az boards          Azure Boards
├── area           Area paths
├── iteration      Iterations
└── work-item      Work items

az repos           Azure Repos
├── import         Git imports
├── policy         Branch policies
├── pr             Pull requests
└── ref            Git references

az artifacts       Azure Artifacts
└── universal      Universal Packages
```

## Reference files

Read the relevant reference file based on the task. Each contains complete command syntax and examples for its domain.

| File | When to read | Covers |
|---|---|---|
| [references/repos-and-prs.md](references/repos-and-prs.md) | Repos, branches, pull requests, branch policies | Repositories, import, PRs (create/list/vote/reviewers/policies), Git refs, branch policies |
| [references/pipelines-and-builds.md](references/pipelines-and-builds.md) | Pipelines, builds, releases, artifacts | Pipelines CRUD, runs, builds, releases, artifacts download/upload |
| [references/boards-and-iterations.md](references/boards-and-iterations.md) | Work items, sprints, area paths | Work items (WIQL/create/update/relations), area paths, iterations, team iterations |
| [references/variables-and-agents.md](references/variables-and-agents.md) | Pipeline variables, agent pools | Pipeline variables, variable groups, pipeline folders, agent pools/queues |
| [references/org-and-security.md](references/org-and-security.md) | Projects, teams, users, permissions, wikis | Projects, extensions, teams, users, security groups/permissions, service endpoints, wikis, admin |
| [references/advanced-usage.md](references/advanced-usage.md) | Output formatting, JMESPath queries | Output formats, JMESPath queries, global args, common params, Git aliases |
| [references/workflows-and-patterns.md](references/workflows-and-patterns.md) | Automation scripts, best practices, error handling | Common workflows, best practices, error handling, scripting patterns, real-world examples |
| [references/long-comments-on-windows.md](references/long-comments-on-windows.md) | Long `--discussion`, `--description`, or `--content` values failing on Windows | The `cmd.exe` 8191-char cap on `az.cmd`, shell detection, and three verified workarounds (`azps.ps1`, native `--file-path`, `az devops invoke --in-file`) |

## Output template

Deliver a runnable command sequence plus the identifiers it returns:

```bash
az repos pr create \
  --repository sifap \
  --source-branch feature/import-report \
  --target-branch main \
  --title "Add import report" \
  --description "Implements REQ-042" \
  --output table
az pipelines run --name sifap-ci --branch feature/import-report --output table
```

Summarize the result:

```text
PR: !128 sifap feature/import-report -> main (active)
Pipeline: sifap-ci run #345 queued on feature/import-report
```

## Quality gate

- [ ] `az devops configure --list` shows the intended default organization and project.
- [ ] The PAT is supplied via `AZURE_DEVOPS_EXT_PAT` or a secret store, never hardcoded or logged.
- [ ] Commands specify `--output table`/`--output json` explicitly so results are parseable.
- [ ] Long `--description`/`--discussion` values on Windows use one of the documented workarounds.
- [ ] The action was verified (PR, run, or work item ID returned) rather than assumed successful.
