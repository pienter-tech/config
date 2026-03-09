---
name: shortcut-project-management
description: Create and start Shortcut stories with required project defaults using Shortcut MCP. Use when prompts ask to create a ticket, create a ticket from local changes, check out the matching branch for a ticket, or start working on a specific ticket ID.
disable-model-invocation: true
argument-hint: "[action or ticket-id]"
---

# Shortcut Project Management

Use Shortcut MCP commands to create, assign, and start stories while enforcing workspace conventions.

## Prerequisite

This skill depends on Shortcut MCP (`mcp__shortcut__*` commands). If unavailable, state that ticket operations are blocked and ask the user to enable it.

## Required defaults

- Prefix every story title with `project_name: `.
- Keep the post-prefix title concise (reused for branch naming).
- Default team: `5f05c15d-7e01-4911-80dc-2f6094ee7f1f`.
- Default workflow: `500000005` ("Website").
- Default owner: `64788d99-11bc-4762-91e3-c3bd5ceccbaa`.

Before creating a story, check `AGENTS.md` for overrides (team, workflow, epic). If no fixed epic is defined, omit the `epic` field.

## Workflows

### 1) Create a ticket

1. Derive a concise title with `project_name: ` prefix.
2. Build description with acceptance criteria.
3. Create story with `stories-create` using defaults.
4. Return story ID, title, and branch name from `stories-get-branch-name`.
5. If starting immediately: `git switch -c "<branch>" || git switch "<branch>"`.

### 2) Create a ticket from local changes

1. Inspect changes: `git status --short`, `git diff --stat`, `git diff`.
2. Summarize intent in a prefixed title.
3. Build description with problem statement, proposed changes, affected files, and acceptance criteria.
4. Create story using defaults from workflow (1).
5. Return story details and suggest branch checkout.

### 3) Checkout the matching branch

1. Resolve story ID from context or ask.
2. Get branch name via `stories-get-branch-name`.
3. New ticket (this session): `git switch -c "<branch>" || git switch "<branch>"`.
4. Existing ticket: check local refs first, then `origin`, then create.

### 4) Start working on a ticket

1. Parse ticket ID.
2. Fetch story with `stories-get-by-id`.
3. Assign current user with `stories-assign-current-user`.
4. Get branch via `stories-get-branch-name`.
5. Check out branch using workflow (3).
6. Respond with story summary and next implementation steps.

## Guardrails

- Never create a story without the `project_name:` prefix.
- Use IDs (team/workflow/owner/epic) instead of names.
- If required data is missing, ask one focused question; otherwise proceed with best available context.
- Never push unless explicitly requested.
