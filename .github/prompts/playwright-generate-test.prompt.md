---
name: "playwright-generate-test"
description: "Generate a Playwright end-to-end test from a scenario using Playwright MCP, deferring the procedure to the playwright-generate-test skill."
argument-hint: "scenario=\"<user flow to test>\""
agent: "agent"
tools: ["read", "search", "edit", "execute"]
---
# /playwright-generate-test

## What This Does

Explores a described user flow step by step with Playwright MCP, then emits a passing `@playwright/test` TypeScript test. The full procedure lives in the [`playwright-generate-test`](../skills/playwright-generate-test/SKILL.md) skill; this prompt is a thin wrapper that defers to it.

## When to Use

During Stage 3/4, when the team wants an end-to-end regression test for a user-facing flow in the Next.js 15 frontend.

## Steps

1. Provide the scenario to test (ask for one if it is missing).
2. Follow the [`playwright-generate-test`](../skills/playwright-generate-test/SKILL.md) skill: run the steps one by one with Playwright MCP before writing any code.
3. Honor the kit constraints below.

## Kit Constraints

- Target the **Next.js 15 (App Router)** frontend written in **TypeScript 5 (strict)**.
- Save the generated spec in the frontend's `tests/` directory and run it until it passes.
- Component and unit tests still use **Vitest + Testing Library**; reserve Playwright for end-to-end coverage.
