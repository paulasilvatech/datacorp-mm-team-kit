---
description: "Use when implementing or reviewing authentication, authorization, crypto, secure configuration, secrets handling, and security-sensitive code."
applyTo: "backend/src/main/java/**/auth/**,backend/src/main/java/**/security/**,backend/src/main/java/**/config/**,backend/src/main/resources/**,frontend/**/auth/**,frontend/**/middleware.ts"
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Security Conventions

## Auth: bcrypt/argon2, rate limiting, MFA for administrators

## Authz: every request, least privilege, resource level

## Input: parameterized queries, sanitize HTML, validate uploads

## Agent: no self-granted permissions, no production database access without approval
