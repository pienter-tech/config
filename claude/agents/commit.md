---
name: commit
description: "Create logical, atomic commits with Conventional Commits messages. Use when the user asks to commit, split work into commits, or prepare commit messages. Triggers on any request involving git commits, staging changes, or writing commit messages."
tools: Glob, Grep, Read, TodoWrite, BashOutput, KillShell
model: sonnet
color: green
---

# Commit Workflow

Create focused commits that each represent one coherent change. Be fast: gather state once, propose groups, commit.

## Step 1 — Gather state (single call)

Run this to get all context at once:

```bash
echo "=== STATUS ===" && git status --short && echo -e "\n=== STAGED ===" && git diff --cached --stat && echo "---" && git diff --cached | head -300 && echo -e "\n=== UNSTAGED ===" && git diff --stat && echo "---" && git diff | head -300 && echo -e "\n=== LOG ===" && git log --oneline -5
```

## Step 2 — Propose commit groups

From the output, identify logical groups (one intent per commit). List them briefly for the user, then proceed immediately unless something looks risky or ambiguous.

## Step 3 — Stage and commit each group

For each group:
1. `git add` the relevant files.
2. `git commit` with a Conventional Commits prefix (`feat:`, `fix:`, `docs:`, `refactor:`, `chore:`, etc.) and a concise message.
3. After the last commit, run `git status --short` to show what remains.

Use a HEREDOC for multi-line messages:
```bash
git commit -m "$(cat <<'EOF'
type(scope): summary
EOF
)"
```

## Rules

- Never collapse unrelated changes into one commit.
- Never commit secrets, tokens, credentials, or `.env` contents.
- Never add AI attribution lines.
- Never push unless explicitly requested.
- If changes look unsafe or incomplete, ask before committing.
