#!/usr/bin/env bash
set -euo pipefail

# Search Shortcut stories with common presets.
#
# Usage:
#   bash scripts/search.sh [OPTIONS] [SEARCH OPERATORS...]
#
# Options:
#   --mine             Filter to my stories (uses $SHORTCUT_MENTION_NAME)
#   --state ID|NAME    Filter by workflow state
#   --in-progress      Shorthand for --state $SHORTCUT_DEFAULT_STATE_START
#   --text TEXT         Full-text search
#   --type TYPE         Filter by type: feature, bug, chore
#   --label ID|NAME    Filter by label
#   --epic ID|NAME     Filter by epic
#   --iteration ID|NAME  Filter by iteration
#   --project ID       Filter by project
#   --format TEMPLATE  Output format (default: "%id %t (%s)")
#   --quiet            Suppress loading spinner
#   --help             Show this help
#
# Search operators (positional args) are passed directly to the Shortcut API.
# See: https://help.shortcut.com/hc/en-us/articles/360000046646-Search-Operators

usage() {
  awk '/^# Usage:/,/^[^#]/{if(/^#/)print substr($0,3)}' "$0"
  exit "${1:-0}"
}

mention="${SHORTCUT_MENTION_NAME:-}"
state_start="${SHORTCUT_DEFAULT_STATE_START:-}"
format="%id %t (%s)"
mine=false in_progress=false quiet=false
state="" text="" story_type="" label="" epic="" iteration="" project=""
args=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mine)        mine=true; shift ;;
    --state)       state="$2"; shift 2 ;;
    --in-progress) in_progress=true; shift ;;
    --text)        text="$2"; shift 2 ;;
    --type)        story_type="$2"; shift 2 ;;
    --label)       label="$2"; shift 2 ;;
    --epic)        epic="$2"; shift 2 ;;
    --iteration)   iteration="$2"; shift 2 ;;
    --project)     project="$2"; shift 2 ;;
    --format)      format="$2"; shift 2 ;;
    --quiet)       quiet=true; shift ;;
    --help|-h)     usage 0 ;;
    -*)            echo "Error: unknown option '$1'"; usage 1 ;;
    *)             args+=("$1"); shift ;;
  esac
done

cmd=(short search -f "$format")

if $mine; then
  if [[ -z "$mention" ]]; then
    echo "Error: --mine requires SHORTCUT_MENTION_NAME to be set."
    exit 1
  fi
  cmd+=(-o "$mention")
fi

if $in_progress; then
  if [[ -z "$state_start" ]]; then
    echo "Error: --in-progress requires SHORTCUT_DEFAULT_STATE_START to be set."
    exit 1
  fi
  cmd+=(-s "$state_start")
elif [[ -n "$state" ]]; then
  cmd+=(-s "$state")
fi

[[ -n "$text" ]]       && cmd+=(-t "$text")
[[ -n "$story_type" ]] && cmd+=(-y "$story_type")
[[ -n "$label" ]]      && cmd+=(-l "$label")
[[ -n "$epic" ]]       && cmd+=(--epic "$epic")
[[ -n "$iteration" ]]  && cmd+=(-i "$iteration")
[[ -n "$project" ]]    && cmd+=(-p "$project")
$quiet                 && cmd+=(-q)

# Append positional search operators
[[ ${#args[@]} -gt 0 ]] && cmd+=("${args[@]}")

exec "${cmd[@]}"
