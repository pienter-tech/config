---
name: shortcut-project-management
description: Create and start Shortcut stories with required project defaults using the shortcut CLI. Use when prompts ask to create a ticket, create a ticket from local changes, check out the matching branch for a ticket, or start working on a specific ticket ID.
---

# Shortcut Project Management

Use the `short` CLI to create, assign, and start stories while enforcing workspace conventions.

## Prerequisite

This skill depends on the [shortcut-cli](https://github.com/shortcut-cli/shortcut-cli). Install with:

```bash
npm install @shortcut-cli/shortcut-cli -g
short install
```

The CLI reads `SHORTCUT_API_TOKEN`, `SHORTCUT_URL_SLUG`, and `SHORTCUT_MENTION_NAME` from the environment.

## Defaults and overrides

Global defaults are set in `.env.public` at the dotfiles root:

| Variable | Default | Purpose |
|---|---|---|
| `SHORTCUT_MENTION_NAME` | `korneeleeckhout` | Default story owner |
| `SHORTCUT_DEFAULT_STATE_START` | `500000006` | State ID for "In Development" |
| `SHORTCUT_DEFAULT_STATE_DONE` | `500000011` | State ID for "Completed" |
| `SHORTCUT_DEFAULT_STORY_TYPE` | `feature` | Default story type |
| `SHORTCUT_DEFAULT_TEAM` | `5f05c15d-7e01-4911-80dc-2f6094ee7f1f` | Default team (webdev) |

**Project-level overrides:** Check the project's `CLAUDE.md` (or `AGENTS.md`) for overrides. A project may specify a different project ID, epic, iteration, or state IDs. Project-level values always take precedence over the global defaults above.

## CLI quick reference

**IMPORTANT: Only use the exact flags listed below. Do not invent flags — there is no `-w` flag.**

### create

`short create` requires either `-p <project>` or `-s <state>` (one must be provided).

```
short create -t "title" -d "desc" -p <project-id|name> -o <owner> -y <type>
```

| Flag | Long | Purpose |
|---|---|---|
| `-t` | `--title` | Story title (required) |
| `-d` | `--description` | Story description |
| `-p` | `--project` | Project ID or name (required if no `-s`) |
| `-s` | `--state` | Workflow state ID or name (required if no `-p`) |
| `-o` | `--owners` | Owner(s), comma-separated |
| `-y` | `--type` | Story type: `feature`, `bug`, `chore` (default: `feature`) |
| `-e` | `--estimate` | Estimate points |
| `-l` | `--label` | Label ID or name |
| `-i` | `--iteration` | Iteration ID or name |
| | `--epic` | Epic ID or name |
| `-T` | `--team` | Team/group ID or name |
| `-I` | `--idonly` | Print only story ID |
| `-O` | `--open` | Open in browser |
| | `--git-branch` | Checkout branch: `<mention>/sc-<id>/<type>-<slug>` |
| | `--git-branch-short` | Checkout branch: `<mention>/sc-<id>/<slug>` |

### story

```
short story <id> [options]
```

| Flag | Long | Purpose |
|---|---|---|
| `-s` | `--state` | Update workflow state |
| `-o` | `--owners` | Update owner(s), comma-separated |
| `-c` | `--comment` | Add comment |
| `-t` | `--title` | Update title |
| `-d` | `--description` | Update description |
| `-y` | `--type` | Update type |
| `-e` | `--estimate` | Update estimate |
| `-l` | `--label` | Update label |
| `-i` | `--iteration` | Set iteration |
| | `--epic` | Set epic |
| `-T` | `--team` | Update team/group |
| `-f` | `--format` | Format output by template |
| | `--from-git` | Fetch story ID from current git branch |
| | `--git-branch` | Checkout branch: `<mention>/sc-<id>/<type>-<slug>` |
| | `--git-branch-short` | Checkout branch: `<mention>/sc-<id>/<slug>` |
| | `--task` | Create new task on story |
| `-I` | `--idonly` | Print only story ID |
| `-O` | `--open` | Open in browser |
| `-q` | `--quiet` | No loading dialog |

### search

```
short search [options] [SEARCH OPERATORS]
```

| Flag | Long | Purpose |
|---|---|---|
| `-o` | `--owner` | Filter by owner (singular, not `--owners`) |
| `-s` | `--state` | Filter by workflow state |
| `-l` | `--label` | Filter by label |
| `-t` | `--text` | Full-text search |
| `-y` | `--type` | Filter by type |
| `-i` | `--iteration` | Filter by iteration |
| | `--epic` | Filter by epic |
| `-p` | `--project` | Filter by project |
| `-f` | `--format` | Format output by template |
| `-q` | `--quiet` | No loading dialog |

### Other commands

| Command | Purpose |
|---|---|
| `short workflows` | List workflow states |
| `short members` | List team members |
| `short epics` | List epics |
| `short projects` | List projects |
| `short iterations -C` | Show current iteration |

### Output formatting

Use `-f` to format story output: `%id` (ID), `%t` (title), `%o` (owners), `%s` (state), `%u` (URL), `%y` (type).

Example: `short search -o me -f "%id %t (%s)"`

### Branch format

**Do not use the CLI's `--git-branch` or `--git-branch-short` flags.** They produce the wrong format.

The correct branch format is: `<type>/sc-<id>--<slug>`

Example: `feature/sc-9504--center-add-ignore-list-for-discord`

The `scripts/create.sh --branch` flag handles this automatically by creating the story first (with `--idonly`), then constructing and checking out the branch in the correct format.

## Required fields

Every `short create` call needs these fields. Resolve each one using this priority order:

1. **Project CLAUDE.md / AGENTS.md** (highest priority — project-level overrides)
2. **Environment defaults** from `.env.public`
3. **Ask the user** if neither source provides a value

| Field | Flag | Fallback env var | Ask if missing? |
|---|---|---|---|
| Project name prefix | used in `-t` | — | **YES** — always ask |
| Shortcut project ID | `-p` | — | No — omit if not specified |
| Owner | `-o` | `SHORTCUT_MENTION_NAME` | Only if env unset |
| Story type | `-y` | `SHORTCUT_DEFAULT_STORY_TYPE` | Only if env unset |
| Workflow state IDs | `-s` | `SHORTCUT_DEFAULT_STATE_START` / `_DONE` | Only if env unset |
| Epic | `--epic` | — | No — omit if not specified |
| Team | `-T` | `SHORTCUT_DEFAULT_TEAM` | Only if env unset |
| Iteration | `-i` | — | No — omit if not specified |

**CRITICAL:** `project name prefix` has no environment default. It MUST come from the project's CLAUDE.md/AGENTS.md. If not found there, STOP and ask the user before creating anything. Never guess this value.

**NOTE:** `short create` requires either `-p` (project) or `-s` (state). If no project ID is specified in CLAUDE.md, you must pass `-s` with the default start state instead.

Keep the post-prefix title concise (it is reused for branch naming).

## Available scripts

**Always prefer these scripts over calling `short` directly.** They handle defaults, flag mapping, and the `-p`/`-s` requirement automatically.

- **`scripts/create.sh`** — Create a story with environment defaults baked in
- **`scripts/start.sh`** — Fetch story, move to In Development, checkout branch
- **`scripts/search.sh`** — Search stories with convenient presets

Run `bash scripts/<name>.sh --help` to see all options.

## Workflows

### 1) Create a ticket

1. **Resolve required fields** using the table above. If `project name prefix` is unknown, ask the user and wait for a response.
2. Derive a concise title with `project_name: ` prefix.
3. Build description with acceptance criteria.
4. Run:
   ```bash
   bash scripts/create.sh --title "project_name: title" --description "description" --branch
   ```
5. Add `--project <id>` if specified in CLAUDE.md. Otherwise the script falls back to `--state` automatically.
6. If not starting immediately, omit `--branch`.

### 2) Create a ticket from local changes

1. Inspect changes: `git status --short`, `git diff --stat`, `git diff`.
2. Summarize intent in a prefixed title.
3. Build description with problem statement, proposed changes, affected files, and acceptance criteria.
4. Create story using workflow (1).
5. Return story details and suggest branch checkout.

### 3) Checkout the matching branch

1. Resolve story ID from context or ask.
2. If the branch already exists locally, use `git checkout "<branch>"`.
3. Otherwise, use `bash scripts/start.sh <id> --no-branch` is not appropriate here — instead fetch the story details and construct the branch manually:
   ```bash
   short story <id> -f "%t|%y"
   ```
   Then build `<type>/sc-<id>--<slug>` and run `git checkout -b "<branch>"`.

### 4) Start working on a ticket

1. Parse ticket ID.
2. Run:
   ```bash
   bash scripts/start.sh <STORY_ID>
   ```
   This fetches the story, moves it to "In Development", and checks out the branch.
3. Respond with story summary and next implementation steps.

### 5) Search and list tickets

```bash
# My in-progress stories
bash scripts/search.sh --mine --in-progress

# Search by text
bash scripts/search.sh --mine --text "search term"

# By type
bash scripts/search.sh --mine --type bug

# By state ID
bash scripts/search.sh --mine --state 500000007
```

## Guardrails

- **Never create a story without resolving the project name prefix first.** If it's not in CLAUDE.md/AGENTS.md, ask the user.
- Never guess the project name prefix — the wrong prefix cannot be easily undone.
- Never invent CLI flags — only use the flags documented above.
- Never push unless explicitly requested.
