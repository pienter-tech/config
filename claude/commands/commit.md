---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*)
description: Commit changes with conventional commits
model: claude-haiku-4-5-20251001
---

Create logical, atomic commits with clear conventional commit messages.

## Current repository status:
!`git status`

## Changes to be committed:
!`git diff --cached`

## Unstaged changes:
!`git diff`

## Recent commit history for context:
!`git log --oneline -5`

## Workflow (follow these steps in order):

### Step 1: Analyze all changes
Review ALL changes (both staged and unstaged) shown above. Identify distinct logical units of work.

### Step 2: Group changes
List the logical groups you identified. Each group should represent ONE coherent change (e.g., "refactor X", "add feature Y", "fix bug Z"). Present this grouping to confirm before proceeding.

### Step 3: Create separate commits
For EACH logical group, create a separate commit:
- Stage only the files belonging to that group: `git add <specific-files>`
- Commit with a descriptive message: `git commit -m '...' && git status`
- Repeat for each group

## Commit message rules:
- Use conventional commit format (feat:, fix:, docs:, refactor:, chore:, etc.)
- Write clear, concise messages that explain the "why"
- Follow the existing commit message style in this repository
- Do not mention AI tools or generators
- Do not include any "Co-Authored-By" lines

## Important:
- NEVER commit all changes in a single commit unless they truly represent one logical change
- When in doubt, prefer smaller, more focused commits over larger ones
- Flag any potential issues before committing

**Important**: This command only grants permission to commit the changes shown in the current repository status above. It does NOT grant permission to commit any future changes made during this session. Each commit request is isolated to the changes present at the time of the request.
