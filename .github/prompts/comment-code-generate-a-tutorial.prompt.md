---
name: "comment-code-generate-a-tutorial"
description: "Refactor a source file, add beginner-friendly instructional comments, and generate a README tutorial, deferring the workflow to the comment-code-generate-a-tutorial skill."
argument-hint: "file=<path-to-source>"
agent: "agent"
tools: ["read", "edit", "search"]
---
# /comment-code-generate-a-tutorial

## What This Does

Turns a single source file into a polished, teaching-oriented example: it refactors for clarity, adds instructional comments that explain the reasoning, and produces a `README.md` tutorial. The full workflow lives in the [`comment-code-generate-a-tutorial`](../skills/comment-code-generate-a-tutorial/SKILL.md) skill; this prompt is a thin wrapper that defers to it.

## When to Use

When preparing a walkthrough or teaching artifact for the workshop — for example, explaining a translated module to the rest of the team.

## Steps

1. Provide the path to the source file to document.
2. Follow the [`comment-code-generate-a-tutorial`](../skills/comment-code-generate-a-tutorial/SKILL.md) skill end to end.
3. Honor the kit constraints below.

## Kit Constraints

- The skill uses Python for its example; in this kit apply the same approach to the target stack — **Java 21** (backend) or **TypeScript** on **Next.js 15** (frontend) — and follow the matching style guide (PEP 8 only when the file really is Python).
- Write all comments and tutorial prose in **English**.
- Never expose sensitive data (CPF, benefit amounts) in examples or sample output — mask it.
