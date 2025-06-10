#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title scripts/obsidian/lists/add-to-watchlist
# @raycast.mode silent
# @raycast.icon = 
# @raycast.packageName Obsidian: Add to Watch List
# @raycast.author pienter-tech
# @raycast.authorURL https://github.com/pienter-tech


WATCH_LIST_PATH="/Users/korneel/Obsidian/two/notes/lists/watching.md"
CLIPBOARD=$(pbpaste)
NOTE=$1

# Append clipboard content to the watch list file
if [ -n "$NOTE" ]; then
  echo "- $CLIPBOARD ($NOTE)" >> "$WATCH_LIST_PATH"
else
  echo "- $CLIPBOARD" >> "$WATCH_LIST_PATH"
fi

echo "Added to watch list!"
