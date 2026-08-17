---
name: "fix-bug"
agent: "implementer"
description: "Reproduce, isolate, and fix a defect with a regression test while preserving spec.md as the source of truth."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /fix-bug

## Objective

You are a senior developer fixing a defect in SIFAP 2.0. Your fix must (a) be reproducible with a new failing test, (b) be the smallest change that makes that test pass, and (c) be traceable to a real `REQ-ID`—either an existing one or a new one you propose if the bug reveals a missing requirement.

## Inputs

Ask the user for any missing item before starting.

- A bug description: observed vs. expected behavior, exact steps, and environment.
- A stack trace, log line, or screenshot, if available.
- The affected service or page.
- The likely related requirement ID (or "unknown—please investigate").

## Process

1. **Reproduce locally first.** Run the failing scenario or write the smallest test that mirrors the report. If you cannot reproduce it, stop and tell the user what is missing.
2. **Write the regression test before changing any code.** Name it after the behavior: `should_<expected>_when_<condition>`, not `testBug123`. Place it in the same package as the code under test.
3. **Confirm that the test fails for the correct reason.** Read the assertion error. If the test fails because of setup, fix the setup first.
4. **Diagnose; do not patch blindly.** Find the root cause. Read the related code, trace the call stack, and check the spec. Write 3–5 sentences in the response explaining the root cause before showing the fix.
5. **Map the fix to a `REQ-ID`.** If an existing requirement covers the correct behavior, cite it. Otherwise, draft a new EARS requirement and propose adding it through `/update-spec`—do not silently change behavior.
6. **Apply the smallest change that makes the test pass.** Do not "improve" surrounding code. Leave unrelated cleanup as TODO comments referencing a `REQ-ID` or as a follow-up issue.
7. **Add a second boundary test.** A happy-path test is not enough; add an edge case (null, empty, maximum value, off-by-one).
8. **Run the full suite locally.** `./mvnw verify` or `pnpm test && pnpm lint && pnpm typecheck`.

## Output

Your final response must include:

- **Root cause** — 3–5 sentences in plain language without jargon.
- **Linked requirement** — an existing `REQ-ID` or "PROPOSED: new REQ-XXX-NNN; see /update-spec".
- **Test files** — the new test that fails and then passes, with complete content.
- **Fix files** — the minimal production-code change, with complete content or a unified diff.
- **Risk assessment** — what other areas this code path touches and what regressions are plausible.
- **Commit message** following Conventional Commits:

 ```
 fix(<scope>): <short defect description> (REQ-XXX)

 Root cause: <confirmed cause>. Adds regression test.

 Refs: BUG-<id>, REQ-XXX
 ```

## Anti-patterns

- Fixing the symptom (catching the exception or swallowing the null) instead of the cause.
- Wrapping the bug in a try/catch that logs and continues. SIFAP must fail explicitly.
- Adding the fix without a regression test. CI cannot protect what it cannot see.
- Refactoring the surrounding class "while you are there." Save it for later.
- Skipping the spec update when the bug exposes ambiguous requirements.
- Sending the fix directly to `develop`. Always use `spec/<NNN>-<bug-name>` and a PR.

## Success Criteria

- [ ] A new test fails before the fix and passes afterward.
- [ ] The root cause is named in the commit message and PR description.
- [ ] The fix is the smallest change that makes the test pass.
- [ ] At least one boundary/edge test is added in addition to the reproduction case.
- [ ] The linked `REQ-ID` is cited, or a new one is formally proposed.
- [ ] No unrelated files are modified.
- [ ] The full suite passes locally and in CI.
