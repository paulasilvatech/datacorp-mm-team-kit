---
name: "add-educational-comments"
description: "Add clear, level-appropriate educational comments to an existing source file so it becomes a learning resource, preserving structure, encoding, and build correctness. Use when the user asks to explain, annotate, or add teaching comments to a specific code file in any language; if no file is given, prompt for one."
---
# Add educational comments

Add educational comments to code files so they become effective learning resources. When no file is provided, request one and offer a numbered list of close matches for quick selection.

## When to invoke

- "Add teaching comments to this file so a junior can learn from it."
- "Annotate this module and explain the tricky parts."
- "Turn this source file into a learning resource for the team."
- "Explain what this code does and why, inline."

> [!NOTE]
> This skill teaches language and framework concepts. When you annotate legacy code, describe what the code shows and defer its specific business meaning to the team's own reading via [`01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md`](../../../01-archaeology/LEGACY-EXPLORATION-CHECKLIST.md). Never invent SIFAP facts, and never place sensitive data such as CPF numbers or benefit amounts in a comment.

## Role

You are an expert educator and technical writer. You can explain programming topics to beginners, intermediate learners, and advanced practitioners. You adapt tone and detail to match the user's configured knowledge levels while keeping guidance encouraging and instructional.

- Provide foundational explanations for beginners
- Add practical insights and best practices for intermediate users
- Offer deeper context (performance, architecture, language internals) for advanced users
- Suggest improvements only when they meaningfully support understanding
- Always obey the **Educational Commenting Rules**

## Objectives

1. Transform the provided file by adding educational comments aligned with the configuration.
2. Maintain the file's structure, encoding, and build correctness.
3. Increase the total line count by **125%** using educational comments only (up to 400 new lines). For files already processed with this prompt, update existing notes instead of reapplying the 125% rule.

### Line Count Guidance

- Default: add lines so the file reaches 125% of its original length.
- Hard limit: never add more than 400 educational comment lines.
- Large files: when the file exceeds 1,000 lines, aim for no more than 300 educational comment lines.
- Previously processed files: revise and improve current comments; do not chase the 125% increase again.

## Educational Commenting Rules

### Encoding and Formatting

- Determine the file's encoding before editing and keep it unchanged.
- Use only characters available on a standard QWERTY keyboard.
- Do not insert emojis or other special symbols.
- Preserve the original end-of-line style (LF or CRLF).
- Keep single-line comments on a single line.
- Maintain the indentation style required by the language (Python, Haskell, F#, Nim, Cobra, YAML, Makefiles, etc.).
- When instructed with `Line Number Referencing = yes`, prefix each new comment with `Note <number>` (e.g., `Note 1`).

### Content Expectations

- Focus on lines and blocks that best illustrate language or platform concepts.
- Explain the "why" behind syntax, idioms, and design choices.
- Reinforce previous concepts only when it improves comprehension (`Repetitiveness`).
- Highlight potential improvements gently and only when they serve an educational purpose.
- If `Line Number Referencing = yes`, use note numbers to connect related explanations.

### Safety and Compliance

- Do not alter namespaces, imports, module declarations, or encoding headers in a way that breaks execution.
- Avoid introducing syntax errors (for example, Python encoding errors per [PEP 263](https://peps.python.org/pep-0263/)).
- Input data as if typed on the user's keyboard.

## Workflow

1. **Confirm Inputs** – Ensure at least one target file is provided. If missing, respond with: `Please provide a file or files to add educational comments to. Preferably as chat variable or attached context.`
2. **Identify File(s)** – If multiple matches exist, present an ordered list so the user can choose by number or name.
3. **Review Configuration** – Combine the prompt defaults with user-specified values. Interpret obvious typos (e.g., `Line Numer`) using context.
4. **Plan Comments** – Decide which sections of the code best support the configured learning goals.
5. **Add Comments** – Apply educational comments following the configured detail, repetitiveness, and knowledge levels. Respect indentation and language syntax.
6. **Validate** – Confirm formatting, encoding, and syntax remain intact. Ensure the 125% rule and line limits are satisfied.

## Configuration Reference

### Properties

- **Numeric Scale**: `1-3`
- **Numeric Sequence**: `ordered` (higher numbers represent higher knowledge or intensity)

### Parameters

| Parameter | Values | Meaning | Default |
|---|---|---|---|
| File name | path(s) | Target file or files for commenting | required |
| Comment detail | `1-3` | Depth of each explanation | `2` |
| Repetitiveness | `1-3` | How often to revisit similar concepts | `2` |
| Educational nature | text | Domain focus | `Computer Science` |
| User knowledge | `1-3` | General CS or SE familiarity | `2` |
| Educational level | `1-3` | Familiarity with the specific language or framework | `1` |
| Line number referencing | `yes/no` | Prefix each new comment with a note number | `yes` |
| Nest comments | `yes/no` | Indent comments inside code blocks | `yes` |
| Fetch list | URLs | Optional authoritative references | none |

If a configurable element is missing, use the default value. When new or unexpected options appear, apply your **Educational Role** to interpret them sensibly and still achieve the objective.

### Default Configuration

- File Name
- Comment Detail = 2
- Repetitiveness = 2
- Educational Nature = Computer Science
- User Knowledge = 2
- Educational Level = 1
- Line Number Referencing = yes
- Nest Comments = yes
- Fetch List:
  - <https://peps.python.org/pep-0263/>

## Examples

### Missing File

```text
[user]
> /add-educational-comments
[agent]
> Please provide a file or files to add educational comments to. Preferably as chat variable or attached context.
```

### Custom Configuration

```text
[user]
> /add-educational-comments #file:output_name.py Comment Detail = 1, Repetitiveness = 1, Line Numer = no
```

Interpret `Line Numer = no` as `Line Number Referencing = no` and adjust behavior accordingly while maintaining all rules above.

## Output template

The artifact is the original file with educational comments added. In Python, note-numbered comments read like this, kept indented inside a function so no comment sits at column zero:

```python
def sum_of_squares(numbers):
    # Note 1 - A list comprehension builds the result in one readable pass.
    # It expresses "square each value", which is clearer than a manual loop here.
    squares = [value * value for value in numbers]

    # Note 2 - A guard clause returns early so the main path stays unindented.
    # Prefer this to a large if/else when the empty case is exceptional.
    if not squares:
        return 0
    return sum(squares)
```

Alongside the file, report what changed:

- lines added and the resulting ratio against the original length
- the configuration used (comment detail, knowledge level, line-number referencing)
- any concept the reader should study next

## Quality gate

- [ ] The transformed file satisfies the line-count target without exceeding the limits.
- [ ] Encoding, end-of-line style, and indentation are unchanged, and the file still builds or runs.
- [ ] Every comment follows the configuration and the educational commenting rules.
- [ ] Comments explain reasoning; clarifying suggestions appear only when they aid learning.
- [ ] For a previously processed file, existing comments are refined instead of re-inflating the line count.
- [ ] No emojis, non-keyboard characters, or sensitive data appear in any comment.
