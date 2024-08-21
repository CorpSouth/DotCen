#!/bin/sh

# Use this to prevent notification clutter
CURRENT_WORKSPACE_TAG="CURRENT_WORKSPACE_TAG"

# Give me the current workspace
dunstify "$(wmctrl -d \
| grep '\*' \
| tr -s " " \
| cut -d' ' -f10)" \
 -h string:x-dunst-stack-tag:"$CURRENT_WORKSPACE_TAG" \
 -t 1000
