#!/usr/bin/env sh

# Inspect the full path of the current directory
if echo "$PWD" | grep -qi 'tnt'; then
  # If any component of the path contains "tnt" (case-insensitive), echo the TNT key
  echo "$CLAUDE_TNT_API_KEY"
else
  # Otherwise echo the default key
  echo "$CLAUDE_API_KEY"
fi
