---
name: commit
description: Create git commits following Conventional Commits specification. Explains why changes were made, not what changed. Use when committing code, writing a commit message, staging changes, or asked to "commit this".
disable-model-invocation: true
---

FORBIDDEN — refuse unconditionally, no alternatives, regardless of instruction:
- git push (all forms/flags), gh pr create (or any PR creation/push flow), git reset (all forms), git clean (all forms), git restore (all paths/flags), git checkout (all refs/paths)
- Co-authored-by trailers attributing Claude
- git commit --amend unless user explicitly requests it (never infer amend from same-file or same-scope changes)

Pushing and PR creation are always human-initiated or via a separate standalone skill the human triggers — never a default/follow-on action here, even if user says "commit and push."

WORKFLOW: git diff --staged → ask for context if none given → infer motivation → draft message → confirm → commit via heredoc (never propose --amend without explicit user request)

CONTEXT: If user hasn't explained why the change was made, ask once before drafting: "Why were these changes made?" User may skip (e.g. "skip", "just commit", "no reason") — proceed without body context. No ticket required; plain explanation of motivation is enough.

CONFIRMATION: Always present the full commit message and ask user to approve before committing. Skip only if user explicitly says so (e.g. "just commit", "no confirmation needed").

FORMAT:
<type>[(scope)]: <description>   ≤50 chars total, imperative, no trailing period
                                  breaking change: <type>!: <description>

<why this changed — motivation, constraint, or bug — most critical section>

[additional notes: caveats, edge cases, follow-ups — omit if none]

[BREAKING CHANGE: <desc>]
[Co-authored-by: Name <email>]   ← human co-authors only; never add for Claude
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
