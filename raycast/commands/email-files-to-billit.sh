#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Files to Billit
# @raycast.mode silent
# @raycast.packageName Billit Tools

-- Get email from environment variable
set targetEmail to do shell script "source ~/dev/projects/pienter/config/.env.public && echo $BILLIT_EMAIL"
if targetEmail is "" then
	return "Error: BILLIT_EMAIL environment variable not set."
end if

tell application "Finder"
	set selectedFiles to selection

	if selectedFiles is {} then
		return "Error: No files selected in Finder."
	end if

	-- Convert to POSIX paths for Mail attachment
	set filePaths to {}
	repeat with aFile in selectedFiles
		set end of filePaths to (aFile as alias)
	end repeat
end tell

tell application "Mail"
	set newMessage to make new outgoing message with properties {subject:"Files", visible:false}

	tell newMessage
		make new to recipient at end of to recipients with properties {address:targetEmail}

		-- Attach each selected file
		repeat with aFile in filePaths
			make new attachment with properties {file name:aFile} at after the last paragraph
		end repeat

		send
	end tell
end tell

return "Emailed " & (count of filePaths) & " file(s) to " & targetEmail
