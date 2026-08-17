---
name: "create-spring-boot-java-project"
description: "Scaffold a Spring Boot (Java 21) project skeleton via start.spring.io with Maven, springdoc-openapi, and ArchUnit, ready to run with Docker Compose. Use when the user wants to bootstrap a new Spring Boot backend or generate a starter project. Aligns to the kit's Java 21 + Spring Boot 3.3 stack."
---
# Create Spring Boot Java project

Scaffold a fresh Spring Boot 3.3 backend skeleton on Java 21, pinned to the kit's stack (PostgreSQL 16, Maven, springdoc-openapi, ArchUnit, Testcontainers). Run every command from VS Code's integrated terminal — VS Code is the kit's only approved editor. The kit-specific overrides (target module, dependency set) are applied by the [`/create-spring-boot-java-project`](../../prompts/create-spring-boot-java-project.prompt.md) prompt.

> [!IMPORTANT]
> The kit uses **PostgreSQL 16 only** — no Redis, no MongoDB. Scaffold into a new `backend/` module; it does not exist yet (the team creates it in Stage 3). Never commit credentials — pass them through environment variables.

## When to invoke

- "Bootstrap a new Spring Boot backend for us."
- "Scaffold the `backend/` module skeleton."
- "Generate a Spring Boot 3.3 starter on Java 21 with PostgreSQL."
- "Set up the project structure so we can start Stage 3."

## Prerequisites

Confirm the required tooling is installed:

| Tool | Purpose |
|---|---|
| Java 21 (JDK) | Compile and run the application |
| Docker + Docker Compose | Run PostgreSQL 16 locally |
| VS Code | The kit's approved editor |

To customize the artifact name or base package, change `artifactId` and `packageName` in [Download the Spring Boot project template](#download-the-spring-boot-project-template). To change the Spring Boot version, change `bootVersion` in the same step — keep it on the kit's 3.3.x line.

## Check the Java version

```shell
java -version
```

Confirm the output reports Java 21.

## Download the Spring Boot project template

Download a Maven + Java 21 skeleton from start.spring.io with the kit's dependency set (no Redis, no MongoDB):

```shell
curl https://start.spring.io/starter.zip \
  -d artifactId=${input:projectName:demo-java} \
  -d bootVersion=3.3.5 \
  -d dependencies=lombok,configuration-processor,web,data-jpa,postgresql,validation,testcontainers \
  -d javaVersion=21 \
  -d packageName=com.example \
  -d packaging=jar \
  -d type=maven-project \
  -o starter.zip
```

## Unzip and clean up

```shell
unzip starter.zip -d ./${input:projectName:demo-java}
rm -f starter.zip
cd ${input:projectName:demo-java}
```

## Add springdoc-openapi and ArchUnit

Insert the `springdoc-openapi-starter-webmvc-ui` and `archunit-junit5` dependencies into `pom.xml`:

```xml
<dependency>
  <groupId>org.springdoc</groupId>
  <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
  <version>2.8.6</version>
</dependency>
<dependency>
  <groupId>com.tngtech.archunit</groupId>
  <artifactId>archunit-junit5</artifactId>
  <version>1.2.1</version>
  <scope>test</scope>
</dependency>
```

## Configure SpringDoc and JPA

Add the SpringDoc UI settings to `application.properties`:

```properties
springdoc.swagger-ui.doc-expansion=none
springdoc.swagger-ui.operations-sorter=alpha
springdoc.swagger-ui.tags-sorter=alpha
```

Add the PostgreSQL datasource and JPA settings. Read the password from an environment variable — never hardcode it:

```properties
spring.datasource.driver-class-name=org.postgresql.Driver
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
spring.datasource.username=postgres
spring.datasource.password=${POSTGRES_PASSWORD}
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

> [!NOTE]
> Use `ddl-auto=validate` (not `update`) so versioned Flyway migrations own the schema, per [`database.instructions.md`](../../instructions/database.instructions.md). Set `POSTGRES_PASSWORD` in your shell or a local, git-ignored `.env` file — never in `application.properties`.

## Add Docker Compose (PostgreSQL 16 only)

Create `compose.yaml` at the project root with a single PostgreSQL 16 service:

```yaml
services:
  postgres:
    image: postgres:16
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
```

Add the data directory to `.gitignore`:

```gitignore
postgres_data
```

## Verify the build

Testcontainers supplies a real PostgreSQL 16 for the tests, so the build runs without a manually started database:

```shell
./mvnw clean test
```

To run the application against a local database, start the Compose service first:

```shell
docker compose up -d
./mvnw spring-boot:run
docker compose down
```

## Output template

```markdown
### Created
- `backend/` — Spring Boot 3.3 skeleton (Java 21, Maven)
- Dependencies: web, data-jpa, postgresql, validation, testcontainers, lombok, springdoc, archunit
- `compose.yaml` — PostgreSQL 16 service only

### Build
`./mvnw clean test` -> BUILD SUCCESS
```

## Quality gate

- [ ] The skeleton is Spring Boot 3.3.x on Java 21, generated into a new `backend/` module.
- [ ] The dependency set is the kit's; no Redis, MongoDB, or cache starter is present.
- [ ] Any Docker Compose file defines only a PostgreSQL 16 service.
- [ ] No credential is hardcoded; the datasource password comes from `POSTGRES_PASSWORD`.
- [ ] `./mvnw clean test` passes (BUILD SUCCESS) before the skeleton is handed off.
