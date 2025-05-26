#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title script/notes/add-to-watchlist
# @raycast.mode silent

# Optional parameters:
# @raycast.icon = 
# @raycast.packageName Add to Watch List

# Documentation:
# @raycast.description Add clipboard content to watching list
# @raycast.author pienter-tech
# @raycast.authorURL https://raycast.com/pienter-tech


WATCH_LIST_PATH="/Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two/notes/lists/watching.md"
CLIPBOARD=$(pbpaste)
NOTE=$1

# Append clipboard content to the watch list file
if [ -n "$NOTE" ]; then
  echo "- $CLIPBOARD ($NOTE)" >> "$WATCH_LIST_PATH"
else
  echo "- $CLIPBOARD" >> "$WATCH_LIST_PATH"
fi

echo "Added to watch list!"
