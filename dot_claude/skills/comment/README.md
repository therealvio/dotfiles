# Comment Skill

A Claude Code skill for adding and improving code comments following intent-first, language-native conventions.

## Usage

The skill auto-triggers when you ask to add comments, document code, or add non-trivial functions/classes/modules. It is not manually invocable (`user-invocable: false`).

## What it does

1. Explores the codebase to understand conventions, patterns, and existing docstring style
2. Identifies comment targets: public symbols, non-obvious logic, unidiomatic code, complex algorithms
3. Applies the language-native docstring format (JSDoc, Go doc, Python docstrings, etc.)
4. Writes comments that explain intent and expected behaviour

## Comment guidelines

| Principle | What it means |
|-----------|--------------|
| Intent over mechanics | Explain *why* the code exists and what it's expected to do, not *what* it does line-by-line |
| Docstrings on public symbols | Every public function, class, and module gets a docstring in the language-native format |
| Assumptions and preconditions | Clearly state what the caller must guarantee for the code to work correctly |
| Unidiomatic code | If the code would surprise a reader, explain why it's written that way |
| External references | Link to specs, RFCs, or relevant issues where they add real context |
| Brevity | One clear sentence beats a vague paragraph |

## Bug fix commentary

Bug fix context belongs in the **regression test**, not in the source code fix. When a bug is fixed and a test is added to prevent recurrence, the test case gets a comment explaining what bug it guards against and why.

## Anti-patterns

- **Restating names** — `// i is the index`, `// getName returns the name`
- **Over-commenting trivial code** — `// increment counter`, `// assign default value`
- **Vague filler** — `// handles edge case`, `// important!`, `// note:`

## Files

- `SKILL.md` — machine-readable instructions loaded into Claude's context
- `README.md` — this file
