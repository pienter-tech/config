#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title script/tool/toggle-system-appearance
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌗
# @raycast.packageName Toggle System Appearance

# Documentation:
# @raycast.author pienter-tech
# @raycast.authorURL https://github.com/pienter-tech

osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
