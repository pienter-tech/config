#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title scripts/tool/docker-clean
# @raycast.mode silent
# @raycast.icon 🧻
# @raycast.packageName Docker Clean
# @raycast.author pienter-tech
# @raycast.authorURL https://raycast.com/pienter-tech

docker system prune --all --filter "until=48h" --force
docker volume prune --force
docker network prune --force
