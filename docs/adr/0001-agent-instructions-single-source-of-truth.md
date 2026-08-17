# ADR-0001: Single source of truth for agent instructions (no root AGENTS.md)

> **Path:** [Team Kit](../../README.md) › [Docs](../README.md) › [ADRs](README.md) › **ADR-0001**

| Field | Value |
|---|---|
| **Status** | accepted |
| **Date** | 2026-08-17 |
| **Authors** | Harness audit |
| **Supersedes** | N/A |

---

## Context

GitHub Copilot reads several kinds of custom-instruction files. This repository already ships `.github/copilot-instructions.md` (repository-wide) and the path-scoped `.github/instructions/*.instructions.md` files. It has **no** root `AGENTS.md`, and the question arose whether it should add one, because the open [agents.md](https://agents.md/) convention and the Copilot CLI both read `AGENTS.md`.

The risk to weigh is drift. A second repository-wide instruction file can silently diverge from the first, so agents receive contradictory guidance depending on which file a surface loads. The harness-engineering skill (`.github/skills/harness-engineering/SKILL.md`) is explicit: "Add the smallest useful harness. Prefer updating existing files over adding duplicate guidance."

Two facts settle the decision.

**1. Surface coverage — `AGENTS.md` adds no reach here.** Every Copilot surface that reads `AGENTS.md` also reads `.github/copilot-instructions.md`:

| Surface | Reads `.github/copilot-instructions.md` | Reads `AGENTS.md` |
|---|---|---|
| Copilot CLI (this repo's optional terminal tool) | Yes | Yes |
| VS Code — Copilot Chat | Yes | Yes |
| VS Code — cloud agent / code review | Yes | Yes |
| GitHub.com — cloud agent | Yes | Yes |
| GitHub.com — code review | Yes | Yes |
| GitHub.com — Copilot Chat | Yes | No |

The Copilot CLI's own `/help` output lists both `AGENTS.md` and `.github/copilot-instructions.md` as respected locations. GitHub.com Copilot Chat reads `.github/copilot-instructions.md` but **not** `AGENTS.md`, so the repository-wide file is the only one honoured by every surface.

**2. Precedence — the repo-wide file already outranks `AGENTS.md`.** When more than one file applies, all are provided to Copilot, but on conflict the order is (highest first): personal → path-specific `.github/instructions/**` → **repository-wide `.github/copilot-instructions.md`** → **agent `AGENTS.md`** → organization. A new `AGENTS.md` could therefore never win a disagreement with the existing file; it could only diverge from it. Nested `AGENTS.md` files are supported (the nearest one in the tree wins), which would multiply the drift surface rather than reduce it.

## Decision

We will **not** add a root `AGENTS.md` (nor `CLAUDE.md` / `GEMINI.md`). `.github/copilot-instructions.md` remains the single source of truth for repository-wide agent instructions, complemented by path-scoped `.github/instructions/*.instructions.md`. The "Strict Rules" section of `.github/copilot-instructions.md` now forbids adding a competing root instruction file, so the rule is enforced at the point a contributor would otherwise violate it.

## Alternatives considered

| Alternative | Why it was rejected |
|---|---|
| Add a full `AGENTS.md` mirroring the instructions | Pure duplication of an already-universally-read file; two repository-wide sources of truth drift apart — the exact regression this audit exists to prevent. |
| Add a thin `AGENTS.md` that only points at `.github/copilot-instructions.md` | Adds a maintained file for near-zero benefit: every surface that reads it already reads the target, and the repository bans non-Copilot assistants, removing the cross-tool value that is `AGENTS.md`'s main selling point. It is still a link that can rot. |

## Consequences

- **Easier:** one place to edit; no reconciliation between two repository-wide files; no surface receives conflicting guidance.
- **Harder:** a contributor who expects an `AGENTS.md` must learn the convention. Mitigated by the explicit Strict Rule and this ADR.
- **Risks:** if GitHub later makes `AGENTS.md` the only file a mandated surface reads, this decision must be revisited.
- **Mitigations:** the Strict Rule links here; the Copilot-primitives drift check (`.github/scripts/validate-copilot-primitives.py`, tracked separately) is the natural place to assert "no stray root `AGENTS.md`" if active enforcement is later wanted.

## Related

- REQ-IDs: N/A
- ADRs: N/A
- Instruction files: `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`
- Failure register: [`docs/failures/README.md`](../failures/README.md)

## References

- GitHub Docs — About customizing GitHub Copilot responses (precedence of custom instructions): <https://docs.github.com/en/copilot/concepts/response-customization>
- GitHub Docs — Support for different types of custom instructions (which surface reads which file): <https://docs.github.com/en/copilot/reference/custom-instructions-support>
- GitHub Docs — Adding repository custom instructions (nested `AGENTS.md`, nearest wins): <https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions>
- agents.md open convention: <https://agents.md/>

---

### Continue reading

| Previous | Next |
|---|---|
| [ADRs — Index](README.md)<br/><sub>Index of recorded decisions.</sub> | [Failure register](../failures/README.md)<br/><sub>Known agent failures and the guardrail for each.</sub> |

<sub>[Back to the kit index](../../README.md)</sub>
