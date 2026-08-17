---
name: "create-spring-boot-java-project"
description: "Scaffold the SIFAP 2.0 Spring Boot backend skeleton (Java 21 + PostgreSQL 16), deferring the mechanics to the create-spring-boot-java-project skill."
argument-hint: "projectName=<artifactId>"
agent: "agent"
tools: ["read", "edit", "search", "execute"]
---
# /create-spring-boot-java-project

## What This Does

Generates a fresh Spring Boot backend skeleton from start.spring.io and wires up the baseline configuration. The step-by-step mechanics live in the [`create-spring-boot-java-project`](../skills/create-spring-boot-java-project/SKILL.md) skill; this prompt is a thin wrapper that defers to it and pins every choice to this kit's fixed stack, so the two never drift.

## When to Use

At the start of Stage 3, when the team creates the `backend/` module from scratch. `backend/` does not exist yet — this command bootstraps it.

## Steps

1. Provide the artifact/project name.
2. Follow the [`create-spring-boot-java-project`](../skills/create-spring-boot-java-project/SKILL.md) skill.
3. Apply the kit overrides below in place of the skill's generic defaults.
4. Run `./mvnw clean test` (Testcontainers) to confirm the skeleton builds.

## Kit Constraints (override the generic skill)

- **Target stack:** Java 21 + Spring Boot **3.3.x** (not 3.4.x) + JPA/Hibernate + **PostgreSQL 16**. Use the starters `web, data-jpa, postgresql, validation, testcontainers` (add `configuration-processor`, `lombok`, and `actuator` as needed).
- **No Redis and no MongoDB** — they are not part of the fixed backend stack. Drop `data-redis` and `data-mongodb` and their configuration blocks.
- **Scaffold into `backend/`**, not the repository root, under a package the team agrees on (for example, `com.sifap.<context>`).
- **Docker Compose is optional** — create it only if the team needs local parity in Stage 3/4, and include **only PostgreSQL 16** (no Redis or Mongo services).
- Add `springdoc-openapi-starter-webmvc-ui` so every endpoint can carry OpenAPI annotations.
- Never commit secrets — keep credentials in environment variables (Azure Key Vault with Managed Identity in deployed environments).
