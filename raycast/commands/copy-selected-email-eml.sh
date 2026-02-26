#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Copy Selected Email (.eml)
# @raycast.mode silent
# @raycast.packageName Mail Tools
# @raycast.author pienter-tech
# @raycast.authorURL https://github.com/pienter-tech

set selectedCount to 0
set rawSource to ""

tell application "Mail"
	set selectedMessages to selection

	if selectedMessages is {} then
		return "Error: No email selected in Apple Mail."
	end if

	set selectedCount to count of selectedMessages

	try
		set rawSource to source of item 1 of selectedMessages
	on error errMessage
		return "Error: Could not read the selected email source. " & errMessage
	end try
end tell

if rawSource is "" then
	return "Error: Selected email has no source content."
end if

set the clipboard to rawSource

if selectedCount is 1 then
	return "Copied selected email source (.eml text) to clipboard."
end if

return "Copied first selected email source (.eml text) to clipboard (" & selectedCount & " selected)."
