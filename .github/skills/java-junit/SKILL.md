---
name: "java-junit"
description: "JUnit 5 unit-testing best practices — test structure (Arrange-Act-Assert), lifecycle, parameterized/data-driven tests, assertions, Mockito isolation, and test organization. Use when writing or reviewing plain JUnit 5 unit tests for Java business logic. For Spring Boot slice/integration tests (@WebMvcTest, @DataJpaTest, Testcontainers), use spring-boot-testing."
---
# JUnit 5 best practices

Write focused JUnit 5 unit tests for the SIFAP 2.0 backend's business logic (Java 21 + Spring Boot 3.3), covering both standard and data-driven approaches with Mockito isolation and AssertJ assertions. For Spring Boot slice or integration tests (`@WebMvcTest`, `@DataJpaTest`, Testcontainers) use the [`spring-boot-testing`](../spring-boot-testing/SKILL.md) skill; for the red-green-refactor rhythm see [`tdd-workflow`](../tdd-workflow/SKILL.md).

## When to invoke

- "Write JUnit 5 tests for this service."
- "Add a parameterized test covering these boundary values."
- "Review these unit tests for isolation and naming."
- "Cover the error paths of this business method."

## Project setup

- Use the standard Maven or Gradle layout and place tests in `src/test/java`.
- `spring-boot-starter-test` already bundles JUnit 5 (including `junit-jupiter-params`), Mockito, and AssertJ on the kit stack — no extra test dependency is required.
- Run tests with `./mvnw test` (or `./gradlew test`).

## Test structure

- Test classes should have a `Test` suffix, e.g., `CalculatorTest` for a `Calculator` class.
- Use `@Test` for test methods.
- Follow the Arrange-Act-Assert (AAA) pattern.
- Name tests using a descriptive convention, like `methodName_should_expectedBehavior_when_scenario`.
- Use `@BeforeEach` and `@AfterEach` for per-test setup and teardown.
- Use `@BeforeAll` and `@AfterAll` for per-class setup and teardown (must be static methods).
- Use `@DisplayName` to provide a human-readable name for test classes and methods.
- Reference the requirement under test with a `// REQ-NNN` comment — the kit traces tests to REQ-IDs.

## Standard tests

- Keep tests focused on a single behavior.
- Avoid testing multiple conditions in one test method.
- Make tests independent and idempotent (can run in any order).
- Avoid test interdependencies.

## Data-driven (parameterized) tests

Mark the method with `@ParameterizedTest` instead of `@Test`, then supply arguments with one source annotation:

| Source | Use for |
|---|---|
| `@ValueSource` | One parameter of simple literals (strings, ints, longs) |
| `@CsvSource` | Inline rows of comma-separated values (multiple parameters) |
| `@CsvFileSource` | Rows loaded from a CSV file on the classpath |
| `@MethodSource` | Arguments built by a factory method returning a `Stream` or `Collection` |
| `@EnumSource` | Every constant (or a named subset) of an enum |

## Assertions

- Prefer AssertJ's fluent `assertThat(...)` for readable failures; it is already on the kit classpath.
- The JUnit `org.junit.jupiter.api.Assertions` methods (`assertEquals`, `assertTrue`, `assertNotNull`) remain available.
- Use `assertThrows` (or AssertJ `assertThatThrownBy`) to assert on exceptions.
- Group related assertions with `assertAll` to ensure all assertions are checked before the test fails.
- Use descriptive messages in assertions to provide clarity on failure.

## Mocking and isolation

- Use a mocking framework like Mockito to create mock objects for dependencies.
- Use `@Mock` and `@InjectMocks` annotations from Mockito to simplify mock creation and injection.
- Use interfaces to facilitate mocking.

## Test organization

- Group tests by feature or component using packages.
- Use `@Tag` to categorize tests (e.g., `@Tag("fast")`, `@Tag("integration")`).
- Use `@TestMethodOrder(MethodOrderer.OrderAnnotation.class)` and `@Order` to control execution order only when strictly necessary.
- Use `@Disabled` to temporarily skip a test method or class, always providing a reason.
- Use `@Nested` to group related tests in a nested inner class.

## Output template

```java
// REQ-042: tax is zero for a tax-exempt customer
@ExtendWith(MockitoExtension.class)
class TaxCalculatorTest {

    @Mock TaxRateProvider rateProvider;
    @InjectMocks TaxCalculator calculator;

    @Test
    @DisplayName("returns zero tax for a tax-exempt customer")
    void returnsZeroForTaxExemptCustomer() {
        // Arrange
        var customer = new Customer(Status.TAX_EXEMPT);
        // Act
        var tax = calculator.taxFor(customer);
        // Assert
        assertThat(tax).isEqualTo(Money.ZERO);
    }

    @ParameterizedTest(name = "income {0} -> tax {1}")
    @CsvSource({ "1000, 100", "2000, 200" })
    void appliesFlatRate(BigDecimal income, BigDecimal expected) {
        when(rateProvider.ratePercent()).thenReturn(new BigDecimal("10"));
        assertThat(calculator.taxFor(income)).isEqualByComparingTo(expected);
    }
}
```

## Quality gate

- [ ] Each test asserts one behaviour and runs independently of the others (any order).
- [ ] Test names describe behaviour and the class carries a `// REQ-NNN` traceability comment.
- [ ] Boundary and error paths are covered, not only the happy path.
- [ ] Collaborators are isolated with Mockito; no real database, clock, or network in a unit test.
- [ ] Assertions are meaningful (AssertJ `assertThat`), not merely "does not throw".
- [ ] `./mvnw test` passes locally before the PR is opened.
