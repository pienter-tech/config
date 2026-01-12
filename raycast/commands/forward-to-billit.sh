#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Forward To Billit
# @raycast.mode silent
# @raycast.packageName Billit Tools

-- Get email from environment variable
set targetEmail to do shell script "source ~/dev/projects/pienter/config/.env.public && echo $BILLIT_EMAIL"
if targetEmail is "" then
	return "Error: BILLIT_EMAIL environment variable not set."
end if

tell application "Mail"
	-- Get the list of emails currently selected in the user interface
	set selectedMessages to selection

	-- Check if anything is actually selected
	if selectedMessages is {} then
		return "Error: No email selected in Apple Mail."
	end if

	set forwardCount to 0

	-- Loop through each selected message (in case you selected multiple)
	repeat with aMessage in selectedMessages
		try
			-- Create the forwarded message
			set forwardMessage to forward aMessage

			-- Configure the forwarded message
			tell forwardMessage
				make new to recipient at end of to recipients with properties {address:targetEmail}
				-- remove the next line if you want to review the email before sending
				send
			end tell

			set forwardCount to forwardCount + 1
		on error
			-- If one fails, continue to the next
		end try
	end repeat

	return "Forwarded " & forwardCount & " email(s) to " & targetEmail
end tell

