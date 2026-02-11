---
name: commit-workflow
description: Create logical, atomic git commits with Conventional Commits and clear commit messages. Use when the user asks to commit changes, split work into multiple commits, or prepare commit messages from staged and unstaged diffs.
---

# Commit Workflow

Create focused commits that each represent one coherent change.

## Workflow

1. Inspect the full repo state:
- `git status --short`
- `git diff --cached`
- `git diff`
- `git log --oneline -5`

2. Identify logical groups:
- Group files by one intent per commit.
- Prefer small commits over mixed commits.
- Call out risky or unclear hunks before committing.

3. Stage and commit each group separately:
- Stage only files for that group.
- Use Conventional Commit format (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`, etc.).
- Keep messages concise and explain intent.
- Run a secret scan on staged changes before each commit.

## Rules

- Never create one large commit when multiple logical groups exist.
- Never commit secrets, tokens, credentials, private keys, `.env` contents, or similar sensitive values.
- If a potential secret is detected, stop and remove it from the commit before proceeding.
- Never add AI attribution lines.
- Never push unless explicitly requested.
- If changes look unsafe or incomplete, ask before committing.
