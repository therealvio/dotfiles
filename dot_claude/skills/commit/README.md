# Commit Skill

A Claude Code skill for creating well-structured git commits. Enforces Conventional Commits and a why-first body style.

## Usage

```
/commit
```

Claude will inspect staged changes, infer motivation from conversation context, and produce a commit. The skill is **manual-only** (`disable-model-invocation: true`) — it never auto-triggers mid-workflow.

## What it does

1. Runs `git diff --staged` to understand the change
2. Uses conversation context, issue references, and surrounding code to determine *why* the change was made
3. Produces a commit following Conventional Commits format with a body that leads with motivation, not description

## Commit format

```
<type>[(scope)]: <description>   # ≤50 chars, imperative mood

Why this changed — the motivation, constraint, or bug.

Additional notes if relevant (caveats, edge cases, follow-ups).

BREAKING CHANGE: <desc>          # if applicable
Co-authored-by: Name <email>
See: https://...
```

### Types

| Type | Use for |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Restructure without changing behaviour |
| `perf` | Performance improvement |
| `build` | Build system or dependency changes |
| `chore` | Maintenance (no src/test changes) |
| `ci` | CI configuration |
| `docs` | Documentation only |
| `style` | Formatting, whitespace — no logic change |
| `test` | Add or fix tests |
| `revert` | Revert a prior commit |

## Hard limits

The skill will **never** run these commands, regardless of what you ask:

- `git push` — any form or flag
- `git reset` — any form
- `git clean` — any form
- `git restore` — any path or flag
- `git checkout` — any ref or path

## Why why-first?

Describing *what* changed is redundant — the diff already shows that. A commit body that explains *why* the change was necessary is what gives future readers (and tools) the context to make good decisions.

## Files

- `SKILL.md` — machine-readable instructions loaded into Claude's context
- `README.md` — this file
