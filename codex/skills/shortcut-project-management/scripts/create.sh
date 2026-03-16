#!/usr/bin/env bash
set -euo pipefail

# Create a Shortcut story with sane defaults.
# Reads defaults from environment; flags override everything.
#
# Usage:
#   bash scripts/create.sh --title "project: title" [OPTIONS]
#
# Required:
#   --title TEXT           Story title (must include project prefix)
#
# Optional:
#   --description TEXT     Story description
#   --project ID|NAME     Shortcut project (omit to use --state instead)
#   --state ID|NAME       Workflow state (default: $SHORTCUT_DEFAULT_STATE_START)
#   --owner NAME          Owner mention name (default: $SHORTCUT_MENTION_NAME)
#   --type TYPE            feature|bug|chore (default: $SHORTCUT_DEFAULT_STORY_TYPE)
#   --epic ID|NAME        Epic
#   --iteration ID|NAME   Iteration
#   --label ID|NAME       Label
#   --team ID|NAME        Team/group (default: $SHORTCUT_DEFAULT_TEAM)
#   --branch              Checkout git branch after creation (<type>/sc-<id>--<slug>)
#   --idonly               Print only story ID
#   --help                 Show this help

usage() {
  awk '/^# Usage:/,/^[^#]/{if(/^#/)print substr($0,3)}' "$0"
  exit "${1:-0}"
}

# Defaults from environment
owner="${SHORTCUT_MENTION_NAME:-}"
story_type="${SHORTCUT_DEFAULT_STORY_TYPE:-feature}"
state_start="${SHORTCUT_DEFAULT_STATE_START:-}"
team="${SHORTCUT_DEFAULT_TEAM:-}"
title="" description="" project="" state="" epic="" iteration="" label=""
branch=false idonly=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title)       title="$2"; shift 2 ;;
    --description) description="$2"; shift 2 ;;
    --project)     project="$2"; shift 2 ;;
    --state)       state="$2"; shift 2 ;;
    --owner)       owner="$2"; shift 2 ;;
    --type)        story_type="$2"; shift 2 ;;
    --epic)        epic="$2"; shift 2 ;;
    --iteration)   iteration="$2"; shift 2 ;;
    --label)       label="$2"; shift 2 ;;
    --team)        team="$2"; shift 2 ;;
    --branch)      branch=true; shift ;;
    --idonly)      idonly=true; shift ;;
    --help|-h)     usage 0 ;;
    *)             echo "Error: unknown option '$1'"; usage 1 ;;
  esac
done

# Validation
if [[ -z "$title" ]]; then
  echo "Error: --title is required."
  echo "Usage: bash scripts/create.sh --title \"project: title\" [OPTIONS]"
  exit 1
fi

# Build command
cmd=(short create -t "$title" -y "$story_type")

[[ -n "$description" ]] && cmd+=(-d "$description")
[[ -n "$owner" ]]       && cmd+=(-o "$owner")
[[ -n "$epic" ]]        && cmd+=(--epic "$epic")
[[ -n "$iteration" ]]   && cmd+=(-i "$iteration")
[[ -n "$label" ]]       && cmd+=(-l "$label")
[[ -n "$team" ]]        && cmd+=(-T "$team")

# short create requires either -p or -s
if [[ -n "$project" ]]; then
  cmd+=(-p "$project")
elif [[ -n "$state" ]]; then
  cmd+=(-s "$state")
elif [[ -n "$state_start" ]]; then
  cmd+=(-s "$state_start")
else
  echo "Error: no --project, --state, or SHORTCUT_DEFAULT_STATE_START available."
  echo "Provide --project <id|name> or --state <id|name>, or set SHORTCUT_DEFAULT_STATE_START."
  exit 1
fi

# When branching, always get the ID so we can build the branch name ourselves
if $branch; then
  cmd+=(--idonly)
  story_id=$("${cmd[@]}")
  echo "Created story #$story_id"

  # Build branch: <type>/sc-<id>--<slug>
  slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
  branch_name="${story_type}/sc-${story_id}--${slug}"

  echo "Checking out branch: $branch_name"
  git checkout -b "$branch_name"
elif $idonly; then
  cmd+=(--idonly)
  exec "${cmd[@]}"
else
  exec "${cmd[@]}"
fi
