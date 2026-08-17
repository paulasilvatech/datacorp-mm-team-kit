---
name: "api-validate"
agent: "software-architect"
description: "Validate an API implementation against its OpenAPI contract"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /api-validate

## Task

Validate whether an API implementation matches its OpenAPI/AsyncAPI contract and expose all drift.

## Steps

1. Load the contract (openapi.yaml / asyncapi.yaml) and the implementation (controllers, handlers).
2. For each operation in the contract, check the path, method, request schema, response schema, error codes, and authentication scheme.
3. For each endpoint in the implementation, check whether it exists in the contract (detect undocumented endpoints).
4. Validate request and response schemas with real examples, if available.
5. Classify drift as breaking (removes/changes a field), additive (new optional field), or metadata (description only).

## Output

Markdown table: `Endpoint | Drift Type | Severity | Fix Location (contract or code)`.

## Quality gate

- [ ] Every contract operation has been checked (100% coverage)
- [ ] Every implementation endpoint has been checked against the contract
- [ ] Breaking drift is highlighted separately from additive drift
- [ ] The fix location (contract vs. code) is explicit for each item
