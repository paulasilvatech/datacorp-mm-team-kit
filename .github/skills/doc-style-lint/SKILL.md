---
name: "doc-style-lint"
description: "Use when reviewing documentation for style, clarity, inclusive language, or compliance with Microsoft or Google style guides. Triggers include \"doc review\", \"style guide\", \"plain language\", \"inclusive language\", and \"readability\"."
---
# Documentation style lint

## When to invoke

- "Lint this README against our style guide."
- "Rewrite this API documentation in plain language."
- "Check for exclusionary terms and jargon."

## Rules

### Voice and tone

- **Active voice**. "The system stores the file," not "The file is stored by the system."
- **Present tense**. "Returns a JSON response," not "Will return a JSON response."
- **Second person** ("you") for practical guides; **third person** for reference documentation.
- **Sentence case headings**, not Title Case.

### Clarity

- One idea per sentence.
- Use 25 words per sentence as a practical maximum.
- Use no more than five sentences per paragraph.
- Avoid minimizing words ("just", "simply", "easily"). They mislead readers.
- Do not use em dashes. Use commas, parentheses, or colons.

### Inclusive language

Replace:

- "master/slave" -> "primary/replica" or "leader/follower"
- "whitelist/blacklist" -> "allowlist/blocklist"
- "guys" -> "folks", "everyone", "team"
- "crazy/insane" (as intensifiers) -> "significant", "unusual"
- "dummy" (in variable names) -> "example", "sample"
- "sanity check" -> "quick check", "verification"

### Structure

- **Start with the outcome**, not the context. Readers should know why to continue.
- **State what readers will learn** at the top.
- **Summarize at the end** of long documents.
- **Use descriptive headings** to support scanning.

### Links

- Link text describes the destination. Never use "click here" or "this link."
- Use absolute URLs for external sources and relative URLs for internal content.
- Check links in CI.

### Code examples

- Test every executable snippet.
- Use realistic examples, not `foo/bar/baz`.
- Clearly identify placeholders: `<YOUR-API-KEY>`.

### Numbers and units

- Use numerals for 10 and above and words for zero through nine (Microsoft style).
- Use metric units and include conversions for mixed audiences.
- Always specify the unit: "100 MB," not "100."

## Review steps

1. **Read once as the intended audience**. Is the length appropriate? Is the level of detail appropriate?
2. **Run the automated checks configured in the repository**, such as Vale, Alex.js, or markdownlint. Report missing tools without installing them.
3. **Apply the style rules** section by section.
4. **Test every code example**.
5. **Ask**: would a new hire understand this on day 1?

## Antipatterns

- Reviewing without running automated linters first.
- Prioritizing style over substance.
- Rewriting the author's voice instead of refining it.
- Ignoring accessibility (alternative text, heading levels, link text).

## Output template

```markdown
## Style review - <Doc>

### Summary
- Readability (Flesch-Kincaid grade): 11 (target: <=12)
- Passive voice: 8% (target: <10%)
- Inclusive language issues: 2
- Broken links: 0
- Untested code examples: 3

### Recommendations (top 10)
| ID | Location | Issue | Fix |
|----|----------|-------|-----|
| 01 | Installation section | Passive voice | Rewrite in active voice |
| 02 | Troubleshooting | "guys" | Replace with "team" |
| 03 | API reference | "simply call" | Remove "simply" |
```

## Quality gate

- [ ] The document passes the repository's configured linters (for example Vale, Alex.js, markdownlint) before human review.
- [ ] Voice is active and present tense, with sentence-case headings.
- [ ] No exclusionary terms remain; flagged terms are replaced with inclusive alternatives.
- [ ] Every code example is tested and every link resolves.
