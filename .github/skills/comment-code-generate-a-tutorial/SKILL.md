---
name: "comment-code-generate-a-tutorial"
description: "Refactor a Python script to PEP 8, add beginner-friendly instructional comments, and generate a complete README.md tutorial (overview, setup, how it works, example usage). Use when the user wants to turn a Python script into a polished, teachable project or produce a step-by-step walkthrough for it."
---
# Comment code and generate a tutorial

Use this skill to turn a working script into a teaching artifact. You refactor the code for clarity, add instructional comments that explain the reasoning behind each decision, and write a `README.md` tutorial that lets a newcomer run the script and understand how it works. The worked example is Python, and the same three-step procedure applies to any language.

> [!NOTE]
> In this workshop, the [`/comment-code-generate-a-tutorial`](../../prompts/comment-code-generate-a-tutorial.prompt.md) prompt applies this procedure to the kit's Java 21 and TypeScript stack. Keep this skill as the procedural source of truth the prompt defers to.

## When to invoke

- "Refactor this Python script and write a README tutorial for it."
- "Add beginner-friendly comments to this script and explain how it works."
- "Turn this utility into a teachable project with setup and usage docs."
- "Generate a step-by-step walkthrough for this script."

## Workflow

### 1. Refactor for clarity

- Apply the language style guide (PEP 8 for Python).
- Rename unclear variables and functions so the names reveal intent.
- Extract long blocks into small, named functions.
- Keep the public interface and observable output identical. This is a readability pass, not a rewrite.

### 2. Add instructional comments

Explain the reasoning, not the syntax. A useful comment answers "why"; a poor comment restates "what".

| Write comments that | Avoid comments that |
|---|---|
| Explain why a design choice was made | Restate a line, such as `i += 1  # add one` |
| Introduce an idiom the first time it appears | Repeat the function name in prose |
| Warn about an edge case or an invariant | Narrate obvious control flow |
| Name the concept a beginner should look up | Add noise that ages badly |

### 3. Generate the tutorial

Write a `README.md` next to the script with these sections: project overview, setup instructions, how it works, example usage, and an optional sample output.

## Rules

- Preserve behavior, file encoding, and end-of-line style. A tutorial pass must never break the build.
- Use only standard keyboard characters in code and comments. No emojis.
- Write every comment and every tutorial section in English.
- Never place sensitive data (for example CPF numbers or benefit amounts) in examples or sample output.
- Run the setup command and the example before publishing the tutorial.

## Output template

The generated `README.md` opens with an H1 that names the project, followed by these sections:

```markdown
## Project overview
`wordcount.py` counts how often each word appears in a text file and prints the
most frequent entries. It demonstrates file input, dictionary aggregation, and
sorting in Python.

## Setup
- Requires Python 3.8 or newer
- No third-party dependencies

Run it from the project root:

    python3 wordcount.py sample.txt --top 10

## How it works
1. Read the file and lowercase each line so counts are case-insensitive.
2. Split each line on whitespace and tally words in a dictionary.
3. Sort the dictionary by count and print the top N entries.

## Example usage
    python3 wordcount.py article.txt --top 5

## Sample output
    the      42
    and      31
    data     27
```

## Quality gate

- [ ] The script still runs and produces identical output after the refactor.
- [ ] Names reveal intent and no behavior changed during the readability pass.
- [ ] Comments explain reasoning and idioms, not obvious syntax.
- [ ] `README.md` includes overview, setup, how-it-works, and example usage.
- [ ] The setup command and the example are tested and correct.
- [ ] Everything is written in English with no emojis and no sensitive data.
