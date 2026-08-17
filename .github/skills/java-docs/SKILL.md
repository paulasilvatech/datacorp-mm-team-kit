---
name: "java-docs"
description: "Apply Javadoc best practices so Java types and members are documented correctly — summary sentences, @param/@return/@throws, {@code} blocks, @since, and inherited docs. Use when the user asks to write, review, or improve Javadoc or API documentation for Java code."
---
# Java documentation (Javadoc)

Write and review Javadoc for the SIFAP 2.0 backend (Java 21 + Spring Boot 3.3) so every public and protected member carries a correct, consistent contract. This skill owns the Javadoc convention set: it teaches how to document behavior — it does not decide the code's design, and it never puts real regulated values (CPF, benefit amounts) into examples.

## When to invoke

- "Write Javadoc for this service class."
- "Review the Javadoc on this package and fix what is missing."
- "Document the public API of this module before we publish it."
- "Add `@param`/`@return`/`@throws` to these methods."

## What to document

| Visibility | Rule |
|---|---|
| `public`, `protected` | Javadoc is mandatory — these form the API contract |
| package-private | Document when the intent is not obvious from the name |
| `private` | Document only genuinely complex logic; prefer clear code over comments |

> [!NOTE]
> Document the contract (what the caller can rely on), not the implementation. Never embed a real CPF, benefit amount, token, or other sensitive value in a Javadoc example — use obviously fake placeholders.

## Summary sentence

- The first sentence is the summary; it ends with a period and reads as a short verb phrase ("Returns…", "Registers…").
- Start method summaries with a third-person verb ("Calculates the tax…"), not "This method…".
- Keep the summary on the contract; move detail into the paragraphs that follow.

## Block tags

| Tag | When | Format rule |
|---|---|---|
| `@param name` | Every method/constructor parameter | Description starts lowercase, no trailing period |
| `@param <T>` | Every type parameter on a generic type or method | Same lowercase, no-period rule |
| `@return` | Every method that returns a value (omit for `void`) | Describe the value, including `Optional` semantics |
| `@throws` / `@exception` | Every checked exception and every documented unchecked one | State the condition that triggers it |
| `@see` | Cross-references to related types or members | Link, do not restate |
| `@since` | When the member was introduced | Use the project or module version |
| `@deprecated` | A member scheduled for removal | Name the replacement and add `@Deprecated` on the code |

Optional: `@author` and `@version` — include them only if your team's convention requires it; many style guides omit `@author` in favour of version-control history.

> [!WARNING]
> Order the tags: `@param` (in declaration order), then `@return`, then `@throws`. A misordered or missing `@param` is the most common Javadoc review defect.

## Inline tags and code

- `{@code ...}` for inline identifiers, keywords, and literals (`{@code null}`, `{@code Optional.empty()}`).
- `{@link Type#member}` to link to another element; `{@linkplain ...}` when you want plain link text.
- `<pre>{@code ... }</pre>` for multi-line samples so generics and angle brackets render literally.
- `{@inheritDoc}` to inherit a supertype's contract — but re-document any behaviour that genuinely differs.

## Documenting Java 21 records

A record's Javadoc lives on the type; document each component with `@param`. Do not add accessor methods just to hang Javadoc on them.

## Output template

```java
/**
 * Registers a payment resource and returns its stored representation.
 *
 * <p>The label must be unique; a duplicate is rejected rather than merged.
 *
 * @param request the validated creation request; must not be {@code null}
 * @return the persisted resource as a response DTO
 * @throws ResourceConflictException if a resource with the same label already exists
 * @since 1.0.0
 * @see ResourceService#getById(java.util.UUID)
 */
ResourceResponse create(CreateResourceRequest request);

/**
 * Immutable creation request for a payment resource.
 *
 * @param label  a unique, human-readable label (max 120 characters)
 * @param amount the positive monetary amount to register
 */
public record CreateResourceRequest(String label, BigDecimal amount) {}
```

## Quality gate

- [ ] Every public and protected member has a Javadoc summary sentence ending with a period.
- [ ] Every parameter (including `<T>` type parameters) has a `@param`; every non-`void` method has a `@return`.
- [ ] Every documented exception has a `@throws` describing the triggering condition.
- [ ] `{@code}` / `{@link}` wrap identifiers instead of bare text, and block tags are correctly ordered.
- [ ] No example embeds a real CPF, benefit amount, or other sensitive value.
- [ ] `mvn javadoc:javadoc` (or the Gradle `javadoc` task) generates without warnings.
