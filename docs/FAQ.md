# FAQ — Frequently Asked Questions

> **Path:** [Team Kit](../README.md) › [Docs](README.md) › **FAQ**

**Direct answers to common questions about the SIFAP modernization workshop.**

| Field | Value |
|---|---|
| **Target audience** | The entire team |
| **How to use** | Search the question with `Ctrl+F`. If it is not here, see [troubleshooting.md](troubleshooting.md) |
| **Estimated time** | Selective reading |

---

## About the workshop

<details>
<summary><strong>I do not code. Can I participate?</strong></summary>

Yes. The Product Owner and Tech Writer personas, and part of QA, do not require coding. Read [`07-conceitos/`](../07-conceitos/) first to become familiar with the concepts. Every `PERSONA.md` includes an "emergency defaults" section.

</details>

<details>
<summary><strong>How long does it last?</strong></summary>

Eight hours (10:00–18:00). The exact schedule is in [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §2.

</details>

<details>
<summary><strong>How many people are on each team?</strong></summary>

Five. Each person assumes two personas (one pair), covering ten personas in total.

</details>

<details>
<summary><strong>Can I choose my two personas?</strong></summary>

Yes, but coordinate with the team. Pairs 1, 4, and 5 accommodate non-technical profiles. Pairs 2 and 3 require technical experience.

</details>

<details>
<summary><strong>What is SIFAP?</strong></summary>

SIFAP (Payment Inspection and Administration System) is a 29-year-old government payment system written in Natural/Adabas. The workshop simulates modernizing it to Java 21 + Next.js 15. See [`01-arqueologia/legado-sifap/README.md`](../01-arqueologia/legado-sifap/README.md).

</details>

---

## About Copilot

<details>
<summary><strong>Which Copilot model should I use?</strong></summary>

Sonnet 4.6 for most tasks. Haiku for mechanical, repetitive tasks. Opus for complex architectural decisions. See [`09-cheat-sheets/model-routing.md`](../09-cheat-sheets/model-routing.md).

</details>

<details>
<summary><strong>When should I use Ask, Plan, or Agent?</strong></summary>

- **Ask** — discuss and understand.
- **Plan** — plan a change across multiple files.
- **Agent** — delegate a complete Issue.

Reference: [`07-conceitos/04-3-modos-do-copilot.md`](../07-conceitos/04-3-modos-do-copilot.md).

</details>

<details>
<summary><strong>Can Agent merge by itself?</strong></summary>

No. Agent opens a pull request. Review it with the same care you would apply to a human contribution.

</details>

<details>
<summary><strong>Can I use Cursor, Codeium, or another assistant?</strong></summary>

No. The toolchain is fixed: use only GitHub Copilot. See [`.github/copilot-instructions.md`](../.github/copilot-instructions.md).

</details>

---

## About Spec-Kit and EARS

<details>
<summary><strong>Why does every EARS requirement need `source_legacy:`?</strong></summary>

To ensure the team modernized the real system, not only the briefing. CI rejects pull requests without this field. See [`01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md`](../01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md).

</details>

<details>
<summary><strong>What if the feature is new and has no legacy equivalent?</strong></summary>

Use `source_legacy: "[GREENFIELD] <one-line justification>"`. Example: `"[GREENFIELD] OAuth2 did not exist on a 3270 terminal."`.

</details>

<details>
<summary><strong>Can I skip `/speckit.clarify`?</strong></summary>

No. Skipping it means ambiguities become Stage 3 bugs, when they cost much more to fix.

</details>

<details>
<summary><strong>`/speckit.analyze` reports problems. What should I do?</strong></summary>

Resolve them before implementation. Each finding prevents later rework.

</details>

---

## About Git and branches

<details>
<summary><strong>Can I commit directly to `main`?</strong></summary>

No. Always use a pull request. See rule 1 in [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md).

</details>

<details>
<summary><strong>Which branch prefix should I use?</strong></summary>

- `spec/<NNN>-<feature>` in Stage 2
- `impl/<NNN>-<feature>` in Stage 3
- `infra/<component>` for infrastructure

Both feature branches start from `develop`. See the complete table in [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md).

</details>

<details>
<summary><strong>How is my PR approved?</strong></summary>

Green CI plus one review from the receiving pair. The flow is Pair 1 → Pair 2 → Pair 3 → Pair 4 → Pair 5 → Pair 1.

</details>

<details>
<summary><strong>Can I run `git push --force`?</strong></summary>

Only on your own branch, and only with `--force-with-lease`. Never on `develop` or `main`.

</details>

---

## About Terraform and Azure

<details>
<summary><strong>Can I run `terraform apply`?</strong></summary>

> [!CAUTION]
> No. Only `terraform plan` is authorized during the workshop. Running `apply` creates real Azure resources and incurs costs.

</details>

<details>
<summary><strong>Where should I store secrets?</strong></summary>

In Azure Key Vault. Never in `variables.tf` or committed `.env` files. When creating `infra/`, model secrets through Key Vault and Managed Identity.

</details>

---

## About stages and handoffs

<details>
<summary><strong>What are "handoffs H1, H2, and H3"?</strong></summary>

They are artifact-transfer points between pairs at the end of each stage. Each handoff is a five-minute synchronous conversation. Details are in [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §3.

</details>

<details>
<summary><strong>Can I start Stage 2 while Stage 1 is still in progress?</strong></summary>

No. Without completed Stage 1 archaeology, EARS requirements will lack `source_legacy:` and CI will reject the pull request.

</details>

<details>
<summary><strong>Who leads each stage?</strong></summary>

See [`05-personas/OVERVIEW.md`](../05-personas/OVERVIEW.md). Summary:

- Stage 1 — all pairs in parallel
- Stage 2 — Pair 2
- Stage 3 — Pairs 3 and 4
- Stage 4 — Pair 5

</details>

---

## About blockers

<details>
<summary><strong>I am blocked. What should I do?</strong></summary>

Use the 20-minute rule ([`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §6):

| Time blocked | Action |
|---|---|
| 5 min | Try to resolve it yourself |
| 10 min | Ask your pair for help |
| 20 min | Bring it to the team |
| 30 min | Ask the facilitator for help |

</details>

<details>
<summary><strong>How do I ask for help efficiently?</strong></summary>

Use three lines: (1) Objective, (2) What I tried, (3) The blocker. See the example in [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §6.

</details>

---

### Continue reading

| Previous | Next |
|---|---|
| [Troubleshooting](troubleshooting.md)<br/><sub>Common errors and solutions.</sub> | [PT-BR Kit](../README.md)<br/><sub>Main hub.</sub> |

<sub>[Back to the kit index](../README.md)</sub>
