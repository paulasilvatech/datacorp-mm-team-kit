---
name: "playwright-generate-test"
description: "Generate a Playwright end-to-end test in TypeScript from a described scenario by driving the Playwright MCP step by step, then run it until it passes. Use when the user asks to create or record a browser or E2E test with Playwright for a web flow."
---
# Playwright end-to-end test generation

Generate a Playwright end-to-end (E2E) test in TypeScript by exploring a described user flow with the Playwright MCP server one step at a time, then emitting a `@playwright/test` spec and running it until it passes. This skill covers browser-level regression tests for the SIFAP 2.0 Next.js 15 frontend; unit and component behavior stays in Vitest + Testing Library (see [`tests.instructions.md`](../../instructions/tests.instructions.md)).

> [!NOTE]
> This skill drives the **Playwright MCP server**, which must be installed and running against a reachable frontend. If the MCP server is unavailable, install and start it before invoking the skill — do not hand-write the test from the scenario alone.

## When to invoke

- "Generate a Playwright test for the payment approval flow."
- "Record an end-to-end test that logs in and opens the dashboard."
- "Create a browser regression test for this scenario."
- "Turn this user journey into a Playwright spec."

## Explore-then-generate workflow

Never write test code from the scenario description alone. Observe the real DOM through the MCP first, then generate.

1. **Get the scenario.** If the user did not describe a flow, ask for one. Confirm the base URL of the running frontend.
2. **Explore step by step.** Drive the flow one action at a time with the Playwright MCP tools (navigate, click, fill, assert). Let each observed page state inform the next step.
3. **Prefer accessible locators.** Select elements by role, label, or text (`getByRole`, `getByLabel`) — not brittle CSS or `data-testid` when a role exists. This mirrors the Testing Library convention used elsewhere in the kit.
4. **Generate the spec.** Only after every step is confirmed, emit a `@playwright/test` TypeScript test built from the recorded interactions. Structure it Arrange-Act-Assert and add an inline `// REQ-NNN` comment when the flow traces to a requirement.
5. **Save it** under the frontend's `tests/` directory as `<feature>.spec.ts`.
6. **Run and iterate.** Execute `npx playwright test <name>` and fix locators or waits until the test passes reliably. Never leave a failing or flaky spec behind.

> [!WARNING]
> Keep secrets and environment-specific data out of the spec. Read base URLs and credentials from environment variables or Playwright config — never hardcode them.

## Scope boundary

| Layer | Tool | Owned by |
|---|---|---|
| End-to-end (browser) | Playwright | this skill |
| Component / interaction | Vitest + Testing Library | [`tests.instructions.md`](../../instructions/tests.instructions.md) |
| Unit / pure logic | Vitest (frontend) or JUnit 5 (backend) | [`test-strategy`](../test-strategy/SKILL.md) |

## Output template

```typescript
import { test, expect } from '@playwright/test';

// REQ-XXX: an analyst approves a pending payment
test('analyst approves a pending payment', async ({ page }) => {
  await page.goto('/payments');                                    // Arrange

  await page
    .getByRole('row', { name: /pending/i })
    .first()
    .getByRole('link', { name: /review/i })
    .click();

  await page.getByRole('button', { name: /approve/i }).click();    // Act

  await expect(page.getByRole('status')).toHaveText(/approved/i);  // Assert
});
```

Run result to report back:

```text
npx playwright test payment-approval
  1 passed (2.1s)
```

## Quality gate

- [ ] The flow was explored step by step through the Playwright MCP before any code was written.
- [ ] The spec uses `@playwright/test` and lives in the frontend `tests/` directory.
- [ ] Elements are selected by accessible role or label, not brittle selectors.
- [ ] Requirement-driven flows carry an inline `// REQ-NNN` comment.
- [ ] The test runs green and is not flaky; no secrets are hardcoded.
- [ ] Unit and component coverage remains in Vitest + Testing Library.
