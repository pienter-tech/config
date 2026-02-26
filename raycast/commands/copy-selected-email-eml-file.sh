#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Copy Selected Email (.eml file)
# @raycast.mode silent
# @raycast.packageName Mail Tools
# @raycast.author pienter-tech
# @raycast.authorURL https://github.com/pienter-tech

set -euo pipefail

SELECTED_COUNT="$(osascript <<'APPLESCRIPT'
tell application "Mail"
	set selectedMessages to selection
	if selectedMessages is {} then
		return 0
	end if
	return count of selectedMessages
end tell
APPLESCRIPT
)"

if [ "$SELECTED_COUNT" -eq 0 ]; then
	echo "Error: No email selected in Apple Mail."
	exit 1
fi

TMP_PATH="$(mktemp /tmp/raycast-mail-XXXXXX)"
EML_PATH="${TMP_PATH}.eml"
mv "$TMP_PATH" "$EML_PATH"

if ! osascript <<'APPLESCRIPT' >"$EML_PATH"; then
tell application "Mail"
	set selectedMessages to selection
	if selectedMessages is {} then
		error "No email selected in Apple Mail."
	end if
	return source of item 1 of selectedMessages
end tell
APPLESCRIPT
	echo "Error: Could not read selected email source."
	rm -f "$EML_PATH"
	exit 1
fi

if [ ! -s "$EML_PATH" ]; then
	echo "Error: Selected email has no source content."
	rm -f "$EML_PATH"
	exit 1
fi

if ! osascript - "$EML_PATH" <<'APPLESCRIPT' >/dev/null; then
on run argv
	set emlPath to item 1 of argv
	set the clipboard to ((POSIX file emlPath) as alias)
end run
APPLESCRIPT
	echo "Error: Could not copy .eml file to clipboard."
	exit 1
fi

if [ "$SELECTED_COUNT" -eq 1 ]; then
	echo "Copied .eml file to clipboard: $EML_PATH"
else
	echo "Copied first selected email as .eml file to clipboard ($SELECTED_COUNT selected): $EML_PATH"
fi
