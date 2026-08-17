---
name: "acceptance-check"
agent: "product-owner"
description: "Check whether the code meets the acceptance criteria in spec.md. Use during UAT or sprint review."
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /acceptance-check

## Steps

1. Read the relevant section of `specs/<NNN>-<feature>/spec.md`
2. Extract all Given/When/Then criteria
3. Search the codebase for corresponding implementations
4. Search test files for coverage
5. Produce a compliance report

## Output

| Criterion | Implemented | Tested | Status |
|-----------|-------------|--------|--------|
| [text] | Yes/No | Yes/No | Pass/Fail/Gap |
