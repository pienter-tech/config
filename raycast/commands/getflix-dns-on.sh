#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title script/tool/getflix-dns-on
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🛜
# @raycast.packageName Getflix DNS On

# Documentation:
# @raycast.author pienter-tech
# @raycast.authorURL https://raycast.com/pienter-tech


networksetup -setdnsservers Wi-Fi 82.103.129.240 && curl https://gfx.globalapi.net/api/helper/ip-address/268f3e65-ca87-412f-fec9-1159bd58d83e
echo "Getflix DNS is now ON."

