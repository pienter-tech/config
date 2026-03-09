---
name: add-docs
description: Add or improve inline code documentation for a target file using the language-appropriate doc format. Use when the user asks to document functions, classes, modules, APIs, or improve maintainability docs.
argument-hint: "[file-path]"
---

# Add Docs

Document code clearly without over-documenting trivial logic.

## Process

1. Read the target file and identify public or non-obvious units.
2. Choose the appropriate format:
   - PHP: phpDoc
   - JS/TS: JSDoc
   - Python: docstrings (Google or NumPy style)
   - Java/Kotlin: Javadoc/KDoc
   - C#: XML docs
   - Go: Go doc comments
   - Rust: `///` with markdown
   - C/C++: Doxygen
   - Swift: `///` with `- Parameter` and `- Returns`
   - Ruby: YARD
   - Shell: structured usage comments

3. For each meaningful function/class/module, document:
   - Purpose
   - Parameters with types
   - Return values with types
   - Errors/exceptions
   - Usage examples only when complexity justifies it

## Rules

- Keep docs concise and accurate to current behavior.
- Prefer practical details over generic prose.
- Avoid documenting obvious one-liners.
- Update docs if implementation and existing comments disagree.
