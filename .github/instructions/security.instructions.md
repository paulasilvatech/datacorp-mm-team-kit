---
description: "Use when implementing or reviewing authentication, authorization, crypto, secure configuration, secrets handling, and security-sensitive code."
applyTo: "backend/src/main/java/**/auth/**,backend/src/main/java/**/security/**,backend/src/main/java/**/config/**,backend/src/main/resources/**,frontend/**/auth/**,frontend/**/middleware.ts"
---

<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Convenções de Segurança

## Auth: bcrypt/argon2, rate limiting, MFA para admin

## Authz: toda requisição, menor privilégio, nível de recurso

## Entrada: consultas parametrizadas, sanitizar HTML, validar uploads

## Agent: sem permissões autoconcedidas, sem banco de produção sem aprovação
