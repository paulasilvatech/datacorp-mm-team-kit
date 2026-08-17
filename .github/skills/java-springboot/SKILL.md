---
name: "java-springboot"
description: "Spring Boot application best practices — package-by-feature structure, constructor injection, DTOs and validation, service-layer transactions, Spring Data JPA, and configuration/secrets handling. Use when building or reviewing Spring Boot backend code and you want idiomatic structure and conventions. Complements the kit's Java 21 + Spring Boot 3.3 stack."
---
# Spring Boot best practices

Build and review idiomatic Spring Boot 3.3 slices for the SIFAP 2.0 backend (Java 21, PostgreSQL 16): package-by-feature structure, constructor injection, record DTOs, service-layer transactions, and Spring Data JPA. This skill is the quick best-practice checklist; the authoritative, CI-enforced conventions live in the instruction files — follow them where they overlap:

- [`backend.instructions.md`](../../instructions/backend.instructions.md) — controllers, DTOs, validation, error handling.
- [`modular-monolith.instructions.md`](../../instructions/modular-monolith.instructions.md) — module boundaries and Adabas FDT to JPA mapping.

## When to invoke

- "Scaffold a new feature slice (controller, service, repository) for this module."
- "Review this Spring Boot code for structure and conventions."
- "Wire configuration and secrets for this service."
- "Turn this JPA entity into a proper DTO-based endpoint."

## Project setup and structure

- **Build Tool:** Use Maven (`pom.xml`) or Gradle (`build.gradle`) for dependency management.
- **Starters:** Use Spring Boot starters (e.g., `spring-boot-starter-web`, `spring-boot-starter-data-jpa`) to simplify dependency management.
- **Package Structure:** Organize code by feature/domain (e.g., `com.example.app.order`, `com.example.app.user`) rather than by layer (e.g., `com.example.app.controller`, `com.example.app.service`).

## Dependency injection and components

- **Constructor Injection:** Always use constructor-based injection for required dependencies. This makes components easier to test and dependencies explicit.
- **Immutability:** Declare dependency fields as `private final`.
- **Component Stereotypes:** Use `@Component`, `@Service`, `@Repository`, and `@Controller`/`@RestController` annotations appropriately to define beans.

## Configuration

- **Externalized Configuration:** Use `application.yml` (or `application.properties`) for configuration. YAML is often preferred for its readability and hierarchical structure.
- **Type-Safe Properties:** Use `@ConfigurationProperties` to bind configuration to strongly-typed Java objects.
- **Profiles:** Use Spring Profiles (`application-dev.yml`, `application-prod.yml`) to manage environment-specific configurations.
- **Secrets management:** Never hardcode secrets. Use environment variables locally and Azure Key Vault via Managed Identity in Azure — never `application.yml`, `locals`, or source. See [`security.instructions.md`](../../instructions/security.instructions.md).

## Web layer (controllers)

- **RESTful APIs:** Use `/api/v1/{resource}` paths, correct verbs and status codes (`201`/`204`/`409`), and OpenAPI annotations on every endpoint.
- **Record DTOs:** Expose Java 21 `record` DTOs at the boundary; never return JPA entities to the client.
- **Validation:** Apply Bean Validation (`@Valid`, `@NotBlank`, `@Positive`, `@Size`) on the request record at the controller boundary.
- **Error handling:** Centralize errors in a `@RestControllerAdvice` that returns RFC 7807 `ProblemDetail`. See [`backend.instructions.md`](../../instructions/backend.instructions.md) for the full controller and error shape.

## Service layer

- **Business logic:** Encapsulate all business logic within `@Service` classes.
- **Statelessness:** Services should be stateless.
- **Transaction management:** Use `@Transactional` only in the service layer — never in controllers or repositories; reads use `@Transactional(readOnly = true)`.
- **No null returns:** Model absence with `Optional`; never return `null` from a public method.
- **Type unions:** Use a `sealed interface` with records for discriminated domain states (Java 21).

## Data layer (repositories)

- **Spring Data JPA:** Use Spring Data JPA repositories by extending `JpaRepository` or `CrudRepository` for standard database operations.
- **Custom Queries:** For complex queries, use `@Query` or the JPA Criteria API.
- **Projections:** Use DTO projections to fetch only the necessary data from the database.

## Logging

- **SLF4J:** Use the SLF4J API for logging.
- **Logger Declaration:** `private static final Logger logger = LoggerFactory.getLogger(MyClass.class);`
- **Parameterized Logging:** Use parameterized messages (`logger.info("Processing user {}...", userId);`) instead of string concatenation to improve performance.

## Testing

- **Unit tests:** Test services and components with JUnit 5 + Mockito — see [`java-junit`](../java-junit/SKILL.md).
- **Slice and integration tests:** Use `@WebMvcTest`, `@DataJpaTest`, and `@SpringBootTest` with Testcontainers against a real PostgreSQL 16 — see [`spring-boot-testing`](../spring-boot-testing/SKILL.md).

## Security

- **Spring Security:** Use Spring Security for authentication and authorization (OAuth2/JWT).
- **Password encoding:** Always hash passwords with a strong algorithm such as BCrypt.
- **Input handling:** Use Spring Data JPA / JPQL (never string-concatenated SQL) and encode output to prevent XSS. See [`security.instructions.md`](../../instructions/security.instructions.md).

## Output template

```java
// com.sifap.payment — one bounded context per package
@RestController
@RequestMapping("/api/v1/payments")
@RequiredArgsConstructor
class PaymentController {
    private final PaymentService service;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(summary = "Register a payment")
    PaymentResponse create(@Valid @RequestBody CreatePaymentRequest request) {
        return service.create(request);
    }
}

public record CreatePaymentRequest(@NotBlank String reference, @NotNull @Positive BigDecimal amount) {}

@Service
@RequiredArgsConstructor
class PaymentService {
    private final PaymentRepository repository;

    @Transactional
    PaymentResponse create(CreatePaymentRequest request) {
        return PaymentResponse.from(repository.save(Payment.from(request)));
    }
}

interface PaymentRepository extends JpaRepository<Payment, UUID> {}
```

## Quality gate

- [ ] Code is organized by feature/bounded context; no module imports another module's internals.
- [ ] Dependencies use constructor injection (`private final`); no field `@Autowired`.
- [ ] Endpoints use `/api/v1/{resource}`, correct status codes, OpenAPI annotations, and `record` DTOs.
- [ ] `@Transactional` appears only in services; no public method returns `null`.
- [ ] Errors flow through one `@RestControllerAdvice` as `ProblemDetail`; no secret or sensitive value is logged.
- [ ] Unit tests (Mockito) and the relevant slice tests pass — see `java-junit` and `spring-boot-testing`.
