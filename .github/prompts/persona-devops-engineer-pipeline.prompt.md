---
name: "pipeline"
agent: "devops-engineer"
description: "Create a GitHub Actions CI/CD pipeline for SIFAP 2.0 with builds, tests, security gates, and environment promotion."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /pipeline

## Objective

You are the DevOps engineer creating (or refactoring) a **GitHub Actions** workflow for SIFAP 2.0. The pipeline must build, test, scan, and promote artifacts through `develop` → `main` (= production) with explicit gates. The deliverable belongs in `.github/workflows/` and references reusable workflows in `.github/workflows/_reusable/` when shared.

## Inputs

Ask the user for anything that is missing.

- Pipeline target—Java backend service, Next.js frontend app, IaC module, or end-to-end orchestration.
- Branch model—`spec/*` → `develop` → `main` (default).
- GitHub environments (`dev`, `prod`) configured with required reviewers.
- Container registry—Azure Container Registry (`acr.azurecr.io`).
- Compliance requirements—SBOM, signed images, and attestation (`sigstore`).

## Process

1. **Choose the trigger surface.** Use `pull_request` for build + test, `push` to protected branches for deployment, and `workflow_dispatch` for manual rollback. Avoid `pull_request_target` unless secrets are required for forks (rare in this project).
2. **Use OIDC for Azure authentication.** Never store service principal secrets. Use `azure/login@v2` with federated credentials.
3. **Pin actions by SHA**, not by tag. (Renovate or Dependabot can update them.)
4. **Organize jobs by stage.**

- `build` — compile and run unit tests (Java: `./mvnw -B verify`; Node: `pnpm install --frozen-lockfile && pnpm build && pnpm test`).
- `quality` — lint, type-check, license scan, and code-coverage upload.
- `security` — Trivy on the container image, OWASP Dependency Check, and Gitleaks on the diff.
- `package` — build the container, push to ACR with `:sha-<short>` and `:latest` tags, generate an SBOM (`syft`), and sign with `cosign`.
- `deploy-dev` — automatic on push to `develop`; uses the GitHub `dev` environment.
- `deploy-prod` — automatic on push to `main`; requires two approvals and a valid change-ticket reference.

5. **Use caching responsibly.** Maven: `actions/cache@<sha>` with a key based on the `pom.xml` hash. Node: `pnpm/action-setup@<sha>` with built-in store caching. Use Buildx layer caching for container builds.
6. **Set timeouts and concurrency.** Use `timeout-minutes: 30` per job and `concurrency: { group: ${{ github.workflow }}-${{ github.ref }}, cancel-in-progress: true }`.
7. **Enforce gates through branch-protection rules.** Required checks: `build`, `quality`, `security`. Production requires deployment review.
8. **Emit traceability.** Tag the deployed image with the merge commit SHA and related `REQ-ID`s from the PR description; expose them in the GitHub deployment description.

## Output

Your final response must include:

- **Workflow file path and name** — derived from the target component.
- **Complete YAML** — ready to paste, with comments explaining non-obvious choices.
- **Required GitHub secrets and variables** — listed with their purpose.
- **Branch-protection settings** — required checks and reviewer rules.
- **Promotion diagram** — short text or a Mermaid sequence from PR to production.

### Skeleton (Java Backend)

```yaml
name: <component>-ci
on:
 pull_request:
 paths: ['backend/**']
 push:
 branches: [develop, main]
 paths: ['backend/**']

permissions:
 id-token: write
 contents: read
 packages: write

concurrency:
 group: ${{ github.workflow }}-${{ github.ref }}
 cancel-in-progress: true

jobs:
 build:
 runs-on: ubuntu-latest
 timeout-minutes: 20
 steps:
 - uses: actions/checkout@<sha>
 - uses: actions/setup-java@<sha>
 with: { java-version: '21', distribution: 'temurin', cache: 'maven' }
 - run: ./mvnw -B verify
 # ... coverage, license, and test-report uploads
 # ... quality, security, package, deploy-* jobs
```

## Anti-patterns

- Storing Azure secrets directly in GitHub Secrets when OIDC works. OIDC is the standard.
- Pinning to `@v3` instead of a SHA. Tags can be moved.
- One mega-job that builds, tests, and deploys. It is hard to debug and hard to retry.
- Using `pull_request_target` without restricting paths. This creates a security risk in forks.
- Sharing cache across branches without invalidation. This causes stale builds.
- Deploying directly to production without an approval gate. Sooner or later, a bad PR reaches production.
- Skipping image signing or the SBOM. Both are required for regulated workloads.
- Hard-coding the registry name in YAML. Use a repository or environment variable.

## Success Criteria

- [ ] OIDC authentication; no Azure secret is stored in GitHub.
- [ ] Every action is pinned to a commit SHA with a comment naming the version.
- [ ] `build`, `quality`, and `security` are required PR checks.
- [ ] The image receives a `sha-<short>` tag and is signed with cosign.
- [ ] Production deployments require approvals as described.
- [ ] The concurrency group prevents two deployments to the same environment at the same time.
- [ ] `timeout-minutes` is defined for every job.
- [ ] The PR-description requirement is enforced for production deployments (linked `REQ-ID`s and change ticket).
