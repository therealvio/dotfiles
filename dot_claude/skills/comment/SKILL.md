---
name: comment
description: Add or improve code comments and docstrings using intent-first, language-native conventions. Use when asked to add comments, document code, comment a selection, review existing comments, or adding non-trivial functions/classes/modules.
disable-model-invocation: false
user-invocable: false
---

WORKFLOW: explore codebase for conventions/patterns → identify targets → apply language-native docstring format → write

TARGETS: public functions, classes, modules, non-obvious logic, unidiomatic code, complex algorithms

RULES:
- Explain why and expected behaviour — not mechanics
- Docstrings on all public symbols using language-native format (JSDoc, Go doc, Python docstrings, etc.)
- State assumptions and preconditions the caller must satisfy
- Explain unidiomatic code; link external references (specs, RFCs, issues) where useful
- Bug fixes: add commentary to the regression test case, not the source fix
- Brief, focused — one clear sentence beats a vague paragraph

FORBIDDEN:
- Restate names ("i is the index", "getName returns the name")
- Comment trivial code ("increment counter", "assign default value")
- Vague filler ("handles edge case", "important!", "note:")
