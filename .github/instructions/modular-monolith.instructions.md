---
description: "Architecture guide for Modular Monolith — package-by-feature, bounded contexts, JPA mapping, Strangler Fig"
applyTo: "backend/src/main/java/**,backend/pom.xml,backend/build.gradle*"
---

# Modular Monolith Architecture Guide

This file is activated when you work on Java source files or build configurations. It enforces the target architecture: a **Modular Monolith** — not microservices.

## Core Principle: One Deployable, Many Modules

The target system is a single Spring Boot application with clear internal module boundaries. Each bounded context is a Maven module (or top-level package) that owns its domain, repository, and service layers.

Why a Modular Monolith rather than microservices:

- **Hackathon constraint**: 8 hours is not enough time to manage distributed systems, service discovery, and inter-service communication.
- **Complexity budget**: A monolith with strong module boundaries provides 80% of the benefits of microservices (team autonomy, clear ownership) at 20% of the operational cost.
- **Migration path**: A well-structured Modular Monolith can be decomposed into microservices later if necessary. The reverse is much harder.

## Package-by-Feature Structure

Organize code by business capability, not by technical layer:

```
src/main/java/com/example/app/
├── <feature>/                  # Bounded context defined by the team
│   ├── <Feature>Controller.java
│   ├── <Feature>Service.java
│   ├── <Feature>Repository.java
│   ├── <Feature>.java
│   └── <Feature>Dto.java
├── shared/                     # Shared kernel
│   ├── audit/                  # Cross-cutting: audit trail
│   └── exception/              # Cross-cutting: error handling
└── Application.java            # Spring Boot entry point
```

Rules:

- A module MUST **NEVER** directly import internal classes from another module. Use interfaces or events.
- The `shared/` package contains only cross-cutting concerns (audit, exceptions, base entities).
- Each module has its own `*Repository`, `*Service`, and `*Controller`.

## Bounded Context Boundaries

When deciding where to draw module boundaries, ask:

1. **Who owns this data?** If two features share the same table, they may belong to the same context.
2. **What changes together?** Features modified in the same sprint belong together.
3. **What can fail independently?** If Feature A failing MUST NOT break Feature B, they belong to separate contexts.

A common pattern in Natural/Adabas legacy modernization is that each Adabas file (FNR) often maps to a bounded context, although some files contain shared reference data that belongs in a shared kernel.

## JPA Mapping from Adabas FDT

### Simple Fields

| Adabas Format | Java Type | JPA Annotation |
|---|---|---|
| `A` (alphanumeric) | `String` | `@Column(length = N)` |
| `N` (numeric, no decimal) | `Long` or `Integer` | `@Column` |
| `N` (numeric, with decimal) | `BigDecimal` | `@Column(precision = P, scale = S)` |
| `P` (packed decimal) | `BigDecimal` | `@Column(precision = P, scale = S)` |
| `D` (date) | `LocalDate` | `@Column` |
| `T` (time/datetime) | `LocalDateTime` | `@Column` |
| `B` (binary) | `byte[]` | `@Column` / `@Lob` |

### MU (Multiple-Value) Fields → JSONB

```java
@Column(columnDefinition = "jsonb")
@JdbcTypeCode(SqlTypes.JSON)
private List<String> alternateNames;  // Was MU field in Adabas
```

Or use `@ElementCollection` if query capability is required:

```java
@ElementCollection
@CollectionTable(name = "person_alternate_names")
private List<String> alternateNames;
```

### PE (Periodic Groups) → @OneToMany

```java
@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
@JoinColumn(name = "person_id")
private List<AddressHistory> addressHistory;  // Was PE group
```

Where `AddressHistory` is an `@Entity` with its own table.

## Spring Boot 3.3 Conventions

- **Constructor injection**: No field-level `@Autowired`. Use `@RequiredArgsConstructor` (Lombok) or explicit constructors.
- **Records for DTOs**: `public record ResourceDto(Long id, String label) {}`
- **Validation in the controller layer**: `@Valid @RequestBody ResourceDto dto` with Bean Validation annotations on the DTO.
- **@Transactional only in the service layer**: NEVER in repositories, NEVER in controllers.
- **Optional for nullable returns**: `Optional<Resource> findById(Long id)` — NEVER return `null` from public methods.
- **Sealed interfaces for type unions**: `sealed interface ResourceState permits StateA, StateB {}`

## Error Handling Pattern

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ProblemDetail> handleNotFound(EntityNotFoundException ex) {
        ProblemDetail detail = ProblemDetail.forStatusAndDetail(
            HttpStatus.NOT_FOUND, ex.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(detail);
    }
}
```

Use `ProblemDetail` (RFC 7807) for all error responses.

## Strangler Fig Pattern

When the modern system must coexist with the legacy system:

1. **Facade**: All requests pass through a routing layer
2. **New path**: New or migrated features are handled by the Spring Boot modules
3. **Legacy path**: Unmigrated features are proxied to the legacy system
4. **Gradual migration**: As each feature is migrated, its route switches from legacy to modern

This pattern applies even within the hackathon scope: teams may not migrate everything, and that is acceptable. The architecture MUST support partial migration gracefully.

## What NOT to Do

- **No microservices**: DO NOT create separate Spring Boot applications for each context
- **No stored procedures**: All business logic MUST live in Java, not in PostgreSQL functions
- **No string concatenation for SQL**: Use JPA/JPQL or Spring Data derived queries
- **No field injection with `@Autowired`**: Use constructor injection
- **No `null` returns**: Use `Optional` for methods that may not find a result
