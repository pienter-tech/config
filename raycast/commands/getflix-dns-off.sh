#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title script/tool/getflix-dns-off
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🛜
# @raycast.packageName Getflix DNS Off

# Documentation:
# @raycast.author pienter-tech
# @raycast.authorURL https://raycast.com/pienter-tech


networksetup -setdnsservers Wi-Fi 1.1.1.1
echo "Getflix DNS is now OFF."

