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

open -a "Microsoft Outlook"

open -a "Mail"

open -a "WezTerm"

open -a "Google Chrome"

open -a "Google Chrome Dev"

open -a "Dorion"

open -a "Shortcut"

open -a "Obsidian"

echo "All applications have been launched!"
