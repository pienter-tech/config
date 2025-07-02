#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title scripts/obsidian/lists/add-to-watchlist
# @raycast.mode silent
# @raycast.icon = 
# @raycast.packageName Obsidian: Add to Watch List
# @raycast.author pienter-tech
# @raycast.authorURL https://github.com/pienter-tech

NOTES_DIRECTORY="/Users/korneel/Obsidian/two/notes/lists/watching/"

# --- Script ---
# Get the full content from the clipboard
CLIPBOARD_CONTENT=$(pbpaste)

# Exit if clipboard is empty
if [ -z "$CLIPBOARD_CONTENT" ]; then
  echo "Clipboard is empty. No note created."
  exit 1
fi

# By default, the content to be saved is the entire clipboard
PROCESSED_CONTENT="$CLIPBOARD_CONTENT"


# --- Process Clipboard Content ---
# Check if the content is wrapped in ``` code fences and remove them
FIRST_LINE=$(echo "$CLIPBOARD_CONTENT" | head -n 1)
LAST_LINE=$(echo "$CLIPBOARD_CONTENT" | tail -n 1)
# Get line count and remove any whitespace for accurate comparison
LINE_COUNT=$(echo "$CLIPBOARD_CONTENT" | wc -l | tr -d ' ')

# The first line must start with ```, the last line must be exactly ```,
# AND there must be content between them (more than 2 lines total).
if [[ "$FIRST_LINE" == \`\`\`* && "$LAST_LINE" == \`\`\` && "$LINE_COUNT" -gt 2 ]]; then
  # Use sed to strip the first ('1d') and last ('$d') lines.
  # This is more portable than `head -n -1`, which fails on macOS.
  PROCESSED_CONTENT=$(echo "$CLIPBOARD_CONTENT" | sed '1d;$d')
fi

# After processing, if the result is empty, exit to prevent creating an empty note.
if [ -z "$PROCESSED_CONTENT" ]; then
  echo "Note content is empty after processing. No note created."
  exit 1
fi


# --- Create Note ---
# Find the first H1 heading (starts with '# ') from the *processed* content
NOTE_TITLE=$(echo "$PROCESSED_CONTENT" | grep '^# ' | head -n 1 | sed 's/# //')

# Sanitize the title to create a valid filename
SANITIZED_TITLE=$(echo "$NOTE_TITLE" | sed 's|[\\/:\*\?"<>|]|\_|g')

# If no heading was found, use a timestamped name as a fallback
if [ -z "$SANITIZED_TITLE" ]; then
    FILENAME="Note-$(date +'%Y%m%d-%H%M%S').md"
    echo "No heading found. Using timestamped name."
else
    FILENAME="${SANITIZED_TITLE}.md"
fi

# Construct the full path for the new note
NOTE_PATH="${NOTES_DIRECTORY}${FILENAME}"

# Create the new note file with the processed clipboard content
echo "$PROCESSED_CONTENT" > "$NOTE_PATH"

echo "Created note: \"$FILENAME\""

