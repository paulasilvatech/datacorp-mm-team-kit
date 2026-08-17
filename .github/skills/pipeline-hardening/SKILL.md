---
name: "pipeline-hardening"
description: "Use when hardening a CI/CD pipeline, migrating to OIDC, signing artifacts, or meeting SLSA requirements. Triggers include 'SLSA', 'supply chain', 'OIDC', 'sigstore', 'cosign', 'pipeline security', and 'GHA hardening'."
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Pipeline hardening

## When to invoke

- "Harden our GitHub Actions / Azure DevOps / GitLab pipeline."
- "Migrate from long-lived secrets to OIDC."
- "Achieve SLSA Level 2/3."
- "Sign our container images."

## Threat model (short list)

1. **Stolen secrets** from pipeline logs or a compromised runner.
2. **Malicious dependency** published upstream or through typosquatting.
3. **Compromised third-party GitHub Action or shared step**.
4. **Tampered artifact** between build and deployment.
5. **Privilege escalation** caused by overly broad pipeline permissions.

## Controls (ordered by ROI)

### Tier 1 — do first

- [ ] **OIDC for the cloud**: do not store long-lived cloud credentials as secrets. Use federated identity with short-lived tokens.
- [ ] **Pin third-party actions by SHA**, not by tag (`actions/checkout@<sha>` with a comment showing the version).
- [ ] A **`permissions:` block** in every workflow, defaulting to `contents: read` and elevated only where needed.
- [ ] **Branch protection**: required reviews, required status checks, no force pushes, and signed commits on main.
- [ ] **Secret scanning + push protection** enabled across the organization.
- [ ] **Dependabot / Renovate** for dependencies and actions.

### Tier 2 — supply chain integrity

- [ ] **SBOM** generated for every build (Syft / CycloneDX).
- [ ] **Artifact signing** with Cosign (keyless via OIDC preferred).
- [ ] **Provenance** (SLSA v1.0 attestation) published with the artifact.
- [ ] **Verify signatures during deployment**: the deployment job rejects unsigned artifacts.
- [ ] **Vulnerability scanning** (Trivy / Grype) on the image; fail on Critical/High findings unless exceptions are justified.

### Tier 3 — mature

- [ ] **Hermetic / reproducible builds** where feasible.
- [ ] **Two-person review** for release pipelines.
- [ ] **Runner hardening**: ephemeral, restricted network egress, and no shared mutable state.

## Anti-patterns

- Storing `AWS_ACCESS_KEY_ID` / `AZURE_CLIENT_SECRET` as repository secrets when OIDC is available.
- `permissions: write-all`.
- Floating `@main` or `@v3` tags in third-party actions.
- Deploying an artifact built in another pipeline without verifying its signature.
- Secrets printed in logs through unquoted shell expansion.

## References

- [SLSA v1.0](https://slsa.dev/spec/v1.0/)
- [GitHub - Security hardening for GHA](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [Sigstore / Cosign](https://docs.sigstore.dev/)
- [OpenSSF Scorecard](https://scorecard.dev/)
