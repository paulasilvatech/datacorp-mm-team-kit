---
name: spring-boot-testing
description: "Select the right Spring Boot test technique for a scenario — test slices (@WebMvcTest, @DataJpaTest, @RestClientTest, @JsonTest, @SpringBootTest), Testcontainers, Mockito, and AssertJ. Use when writing or reviewing Spring Boot integration or slice tests. Targets the kit's Spring Boot 3.3 + JUnit 5; newer 3.4+/4.0 APIs (MockMvcTester, @MockitoBean, RestTestClient) are noted as out of scope for the kit."
---

# Spring Boot Testing

This skill helps you choose the right Spring Boot testing technique for a scenario. It targets the kit's **Spring Boot 3.3 + JUnit 5 + Testcontainers** stack; a few newer APIs from Spring Boot 3.4+/4.0 are shown for reference only and clearly marked as **out of scope for the kit**.

## Core Principles

1. **Test Pyramid**: Unit (fast) > Slice (focused) > Integration (complete)
2. **Right Tool**: Use the narrowest slice that gives you confidence
3. **AssertJ Style**: Fluent, readable assertions over verbose matchers
4. **Kit stack**: On Spring Boot 3.3 use classic MockMvc and `@MockBean`; the newer MockMvcTester / `@MockitoBean` / RestTestClient APIs (3.4+/4.0) are out of scope

## Which Test Slice?

| Scenario | Annotation | Reference |
|----------|------------|-----------|
| Controller + HTTP semantics | `@WebMvcTest` | [references/webmvctest.md](references/webmvctest.md) |
| Repository + JPA queries | `@DataJpaTest` | [references/datajpatest.md](references/datajpatest.md) |
| REST client + external APIs | `@RestClientTest` | [references/restclienttest.md](references/restclienttest.md) |
| JSON (de)serialization | `@JsonTest` | [references/test-slices-overview.md](references/test-slices-overview.md) |
| Full application | `@SpringBootTest` | [references/test-slices-overview.md](references/test-slices-overview.md) |

## Test Slices Reference

- [references/test-slices-overview.md](references/test-slices-overview.md) - Decision matrix and comparison
- [references/webmvctest.md](references/webmvctest.md) - Web layer with MockMvc
- [references/datajpatest.md](references/datajpatest.md) - Data layer with Testcontainers
- [references/restclienttest.md](references/restclienttest.md) - REST client testing

## Testing Tools Reference

- [references/mockmvc-tester.md](references/mockmvc-tester.md) - AssertJ-style MockMvc (3.2+)
- [references/mockmvc-classic.md](references/mockmvc-classic.md) - Traditional MockMvc (pre-3.2)
- [references/resttestclient.md](references/resttestclient.md) - Spring Boot 4+ REST client
- [references/mockitobean.md](references/mockitobean.md) - Mocking dependencies

## Assertion Libraries

- [references/assertj-basics.md](references/assertj-basics.md) - Scalars, strings, booleans, dates
- [references/assertj-collections.md](references/assertj-collections.md) - Lists, Sets, Maps, arrays

## Testcontainers

- [references/testcontainers-jdbc.md](references/testcontainers-jdbc.md) - PostgreSQL, MySQL, etc.

## Test Data Generation

- [references/instancio.md](references/instancio.md) - Generate complex test objects (3+ properties)

## Performance & Migration

- [references/context-caching.md](references/context-caching.md) - Speed up test suites
- [references/sb4-migration.md](references/sb4-migration.md) - Spring Boot 4.0 changes

## Quick Decision Tree

```
Testing a controller endpoint?
  Yes → @WebMvcTest with classic MockMvc (MockMvcTester requires Spring Boot 3.4+)

Testing repository queries?
  Yes → @DataJpaTest with Testcontainers (real DB)

Testing business logic in service?
  Yes → Plain JUnit + Mockito (no Spring context)

Testing external API client?
  Yes → @RestClientTest with MockRestServiceServer

Testing JSON mapping?
  Yes → @JsonTest

Need full integration test?
  Yes → @SpringBootTest with minimal context config
```

## Newer APIs — Out of Scope for the Kit (Spring Boot 3.4+/4.0)

The kit is fixed at **Spring Boot 3.3 + JUnit 5**. The following newer APIs are listed for
awareness only — do not adopt them in the kit's code:

- **MockMvcTester**: AssertJ-style MockMvc assertions (Spring Boot 3.4+). On 3.3, use classic MockMvc.
- **@MockitoBean**: replaces `@MockBean` (Spring Boot 3.4+). On 3.3, use `@MockBean`.
- **RestTestClient**: alternative to `TestRestTemplate` (Spring Boot 4.0). On 3.3, use `TestRestTemplate` or `RestClient`.
- **Modular test starters** and **context pausing** (Spring Boot 4.0 / Spring Framework 7).

Consult [references/sb4-migration.md](references/sb4-migration.md) only if the project actually upgrades beyond 3.3.

## Testing Best Practices

### Code Complexity Assessment

When a method or class is too complex to test effectively:

1. **Analyze complexity** - If you need more than 5-7 test cases to cover a single method, it's likely too complex
2. **Recommend refactoring** - Suggest breaking the code into smaller, focused functions
3. **User decision** - If the user agrees to refactor, help identify extraction points
4. **Proceed if needed** - If the user decides to continue with the complex code, implement tests despite the difficulty

**Example of refactoring recommendation:**

```java
// Before: Complex method hard to test
public Order processOrder(OrderRequest request) {
  // Validation, discount calculation, payment, inventory, notification...
  // 50+ lines of mixed concerns
}

// After: Refactored into testable units
public Order processOrder(OrderRequest request) {
  validateOrder(request);
  var order = createOrder(request);
  applyDiscount(order);
  processPayment(order);
  updateInventory(order);
  sendNotification(order);
  return order;
}
```

### Avoid Code Redundancy

Create helper methods for commonly used objects and mock setup to enhance readability and maintainability.

### Test Organization with @DisplayName

Use descriptive display names to clarify test intent:

```java
@Test
@DisplayName("Should calculate discount for VIP customer")
void shouldCalculateDiscountForVip() { }

@Test
@DisplayName("Should reject order when customer has insufficient credit")
void shouldRejectOrderForInsufficientCredit() { }
```

### Test Coverage Order

Always structure tests in this order:

1. **Main scenario** - The happy path, most common use case
2. **Other paths** - Alternative valid scenarios, edge cases
3. **Exceptions/Errors** - Invalid inputs, error conditions, failure modes

### Test Production Scenarios

Write tests with real production scenarios in mind. This makes tests more relatable and helps understand code behavior in actual production cases.

### Test Coverage Goals

Aim for 80% code coverage as a practical balance between quality and effort. Higher coverage is beneficial but not the only goal.

Use Jacoco maven plugin for coverage reporting and tracking.

**Coverage Rules:**

- 80+% coverage minimum
- Focus on meaningful assertions, not just execution

**What to Prioritize:**

1. Business-critical paths (payment processing, order validation)
2. Complex algorithms (pricing, discount calculations)
3. Error handling (exceptions, edge cases)
4. Integration points (external APIs, databases)

## Dependencies (Spring Boot 3.3)

`spring-boot-starter-test` already bundles JUnit 5, Mockito, AssertJ, and MockMvc. Add the
Testcontainers support module to run `@DataJpaTest` / `@SpringBootTest` against a real PostgreSQL 16.

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-test</artifactId>
  <scope>test</scope>
</dependency>

<!-- Testcontainers support (real PostgreSQL for @DataJpaTest / @SpringBootTest) -->
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-testcontainers</artifactId>
  <scope>test</scope>
</dependency>
<dependency>
  <groupId>org.testcontainers</groupId>
  <artifactId>postgresql</artifactId>
  <scope>test</scope>
</dependency>
```
