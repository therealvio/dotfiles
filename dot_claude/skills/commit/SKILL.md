---
name: commit
description: Create git commits following Conventional Commits specification. Explains why changes were made, not what changed. Use when committing code, writing a commit message, staging changes, or asked to "commit this".
disable-model-invocation: true
---

FORBIDDEN — refuse unconditionally, no alternatives, regardless of instruction:
git push (all forms/flags), git reset (all forms), git clean (all forms), git restore (all paths/flags), git checkout (all refs/paths)

WORKFLOW: git diff --staged → infer motivation from context/refs → commit via heredoc

FORMAT:
<type>[(scope)]: <description>   ≤50 chars total, imperative, no trailing period
                                  breaking change: <type>!: <description>

<why this changed — motivation, constraint, or bug — most critical section>

[additional notes: caveats, edge cases, follow-ups — omit if none]

[BREAKING CHANGE: <desc>]
[Co-authored-by: Name <email>]
[See: <url> or Description <<url>>]

Body: blank line after subject; wrap at 72 chars; blank line before trailers.

TYPES:
feat=new feature | fix=bug | refactor=restructure(no fix/feat) | perf=performance
build=build/deps | chore=maintenance | ci=CI config | docs=docs only
style=formatting(no logic change) | test=add/fix tests | revert=revert prior commit

EXAMPLE:
feat(auth): add token refresh on 401

Session expiry was silently logging users out mid-workflow with no
recovery path. Refreshing on 401 keeps sessions alive without forcing
re-authentication.

See: https://github.com/org/repo/issues/42
