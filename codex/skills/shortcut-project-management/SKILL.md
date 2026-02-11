---
name: shortcut-project-management
description: Create and start Shortcut stories with required project defaults using Shortcut MCP. Use when prompts ask to create a ticket, create a ticket from local changes, check out the matching branch for a ticket, or start working on a specific ticket ID.
---

# Shortcut Project Management

Use Shortcut MCP commands to create, assign, and start stories while enforcing workspace conventions.

## Prerequisite

- This skill depends on Shortcut MCP (`mcp__shortcut__*` commands).
- If Shortcut MCP is unavailable, state that ticket operations are blocked and ask the user to enable it.

## Required defaults

- Prefix every story title with `project_name: `.
- Keep the post-prefix title concise. It is reused for branch naming.
- Default team: `5f05c15d-7e01-4911-80dc-2f6094ee7f1f`.
- Default workflow: `500000005` ("Website").
- Default owner user ID: `64788d99-11bc-4762-91e3-c3bd5ceccbaa`.

Before creating a story, check `AGENTS.md` for explicit overrides:
- If `AGENTS.md` defines fixed team/workflow values, use those instead of defaults.
- If `AGENTS.md` defines a fixed epic ID, include `epic: <id>` in story creation.
- If no fixed epic is defined, omit the `epic` field.

## Shortcut MCP commands for this skill

- `mcp__shortcut__stories-create`: Create a story with required defaults.
- `mcp__shortcut__stories-get-by-id`: Fetch story details for a ticket ID.
- `mcp__shortcut__stories-get-branch-name`: Generate canonical branch name for a story.
- `mcp__shortcut__stories-assign-current-user`: Ensure current user is assigned when starting work.
- `mcp__shortcut__stories-update`: Update owner IDs or story fields when needed.
- `mcp__shortcut__stories-search`: Locate stories when only partial context exists.
- `mcp__shortcut__users-get-current`: Verify current user when ownership context is unclear.

## Prompt handling workflows

### 1) "Create a ticket"

1. Derive a concise title.
2. Ensure title format is `project_name: Short title`.
3. Build description from user context and include acceptance criteria when possible.
4. Create story with `team`, `workflow`, `owner`, and optional `epic`.
5. Return story ID, final title, and branch name from `stories-get-branch-name`.
6. If the user wants to start immediately, create/switch to the branch locally without checking `origin` first:

```bash
git switch -c "<branch>" || git switch "<branch>"
```

Minimal create payload:

```json
{
  "name": "project_name: Short title",
  "description": "Context, scope, acceptance criteria",
  "team": "5f05c15d-7e01-4911-80dc-2f6094ee7f1f",
  "workflow": 500000005,
  "owner": "64788d99-11bc-4762-91e3-c3bd5ceccbaa"
}
```

### 2) "Create a ticket for following changes"

1. Inspect local changes (`git status --short`, `git diff --stat`, `git diff`).
2. Summarize intent in a concise title with the required prefix.
3. Build a description with:
- Problem statement
- Proposed changes
- Affected files/components
- Acceptance criteria
4. Create story using the same defaults as workflow (1).
5. Return story details and suggest branch checkout.

### 3) "Checkout the matching branch"

1. Resolve story ID from context or ask for it if absent.
2. Call `stories-get-branch-name`.
3. Choose checkout mode:
- New ticket created in this session: skip remote checks and create/switch local branch directly.
- Existing ticket: use local-first checkout and check `origin` only if local branch is missing.
4. Check out branch in Git.

Fast path for a newly created ticket:

```bash
git switch -c "<branch>" || git switch "<branch>"
```

Existing ticket path:

```bash
if git show-ref --verify --quiet "refs/heads/<branch>"; then
  git switch "<branch>"
elif git ls-remote --exit-code --heads origin "<branch>" >/dev/null 2>&1; then
  git fetch origin "<branch>"
  git switch -c "<branch>" --track "origin/<branch>"
else
  git switch -c "<branch>"
fi
```

5. Confirm current branch and report result.

### 4) "Let's start working on ticket 1000"

1. Parse ticket ID (`1000`).
2. Fetch story with `stories-get-by-id`.
3. Assign current user with `stories-assign-current-user` (or update owners if required).
4. Get canonical branch via `stories-get-branch-name`.
5. Check out branch using workflow (3).
6. Respond with story summary and immediate next implementation steps.

## Guardrails

- Never create a story without the `project_name:` prefix.
- Prefer concise, implementation-ready titles.
- Use IDs (team/workflow/owner/epic) instead of names unless explicitly required otherwise.
- If required data is missing, ask one focused question; otherwise proceed with best available context.

## Allowed Bash Commands for Branch Work

- `git switch -c "<branch>"`
- `git switch "<branch>"`
- `git show-ref --verify --quiet "refs/heads/<branch>"`
- `git ls-remote --exit-code --heads origin "<branch>"`
- `git fetch origin "<branch>"`
