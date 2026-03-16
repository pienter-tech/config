#!/usr/bin/env bash
set -euo pipefail

# Start working on a Shortcut story: fetch details, move to "In Development",
# and checkout the git branch.
#
# Usage:
#   bash scripts/start.sh <STORY_ID>
#   bash scripts/start.sh --from-git
#
# Options:
#   <STORY_ID>    Numeric story ID
#   --from-git    Detect story ID from current git branch
#   --no-branch   Skip git branch checkout
#   --state ID    Override start state (default: $SHORTCUT_DEFAULT_STATE_START)
#   --help        Show this help

usage() {
  awk '/^# Usage:/,/^[^#]/{if(/^#/)print substr($0,3)}' "$0"
  exit "${1:-0}"
}

state_start="${SHORTCUT_DEFAULT_STATE_START:-}"
story_id="" from_git=false no_branch=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --from-git)   from_git=true; shift ;;
    --no-branch)  no_branch=true; shift ;;
    --state)      state_start="$2"; shift 2 ;;
    --help|-h)    usage 0 ;;
    -*)           echo "Error: unknown option '$1'"; usage 1 ;;
    *)            story_id="$1"; shift ;;
  esac
done

# Resolve story ID
if $from_git; then
  branch=$(git branch --show-current 2>/dev/null || true)
  story_id=$(echo "$branch" | grep -oE '(ch|sc-)[0-9]+' | grep -oE '[0-9]+' || true)
  if [[ -z "$story_id" ]]; then
    echo "Error: could not parse story ID from branch '$branch'."
    echo "Expected branch format: <type>/sc-<id>--<slug>"
    exit 1
  fi
fi

if [[ -z "$story_id" ]]; then
  echo "Error: story ID is required."
  echo "Usage: bash scripts/start.sh <STORY_ID>"
  echo "       bash scripts/start.sh --from-git"
  exit 1
fi

# Fetch and display story
echo "--- Fetching story #$story_id ---"
story_output=$(short story "$story_id" -f "%t|%y")
echo "$story_output"
short story "$story_id"

# Move to start state
if [[ -n "$state_start" ]]; then
  echo ""
  echo "--- Moving to state $state_start ---"
  short story "$story_id" -s "$state_start" -q
fi

# Checkout branch
if ! $no_branch; then
  # Extract title and type from story output
  story_title=$(echo "$story_output" | cut -d'|' -f1)
  story_type=$(echo "$story_output" | cut -d'|' -f2 | tr '[:upper:]' '[:lower:]')
  story_type="${story_type:-feature}"

  # Build branch: <type>/sc-<id>--<slug>
  slug=$(echo "$story_title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
  branch_name="${story_type}/sc-${story_id}--${slug}"

  echo ""
  echo "--- Checking out branch: $branch_name ---"
  git checkout -b "$branch_name"
fi
