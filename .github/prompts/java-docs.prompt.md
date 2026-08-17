---
name: "java-docs"
description: "Apply Javadoc best practices to Java types and members, deferring the full checklist to the java-docs skill."
argument-hint: "target=<file-or-package>"
agent: "agent"
tools: ["read", "edit", "search"]
---
# /java-docs

## What This Does

Documents Java types and members with correct, useful Javadoc — summary sentences, `@param`, `@return`, `@throws`, generics, `{@code}`, and `{@inheritDoc}`. The full checklist lives in the [`java-docs`](../skills/java-docs/SKILL.md) skill; this prompt is a thin wrapper that defers to it so the guidance is not duplicated and cannot drift.

## When to Use

During Stage 3/4, while implementing or reviewing backend Java, to bring public and protected members up to the documentation standard.

## Steps

1. Point at the file or package to document.
2. Apply the Javadoc conventions in the [`java-docs`](../skills/java-docs/SKILL.md) skill.
3. Honor the kit constraints below.

## Kit Constraints

- Target **Java 21**; write all Javadoc in **English**.
- Never place sensitive data (CPF, benefit amounts) in examples or `{@code}` snippets — mask it.
