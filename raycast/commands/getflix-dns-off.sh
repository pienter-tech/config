#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title scripts/tool/getflix-dns-off
# @raycast.mode silent
# @raycast.icon 🛜
# @raycast.packageName Getflix DNS Off
# @raycast.author pienter-tech
# @raycast.authorURL https://raycast.com/pienter-tech


networksetup -setdnsservers Wi-Fi 1.1.1.1
echo "Getflix DNS is now OFF."

