#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title scripts/startup
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🚀
# @raycast.packageName Startup

# Documentation:
# @raycast.description Opens common workspace applications (Outlook, Mail, WezTerm, Chrome, Firefox)
# @raycast.author pienter-tech
# @raycast.authorURL https://github.com/pienter-tech

# Open Outlook
open -a "Microsoft Outlook"

# Open Apple Mail
open -a "Mail"

# Open WezTerm
open -a "WezTerm"

# Open Chrome
open -a "Google Chrome"

# Open Firefox
open -a "Firefox"

open -a "Slack"

open -a "Shortcut"

open -g raycast://extensions/raycast/raycast-ai/ai-chat

open -g raycast://script-commands/project-notes

echo "All applications have been launched!"
