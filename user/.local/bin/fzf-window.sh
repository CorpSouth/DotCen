#!/bin/sh

# Use this to prevent notification clutter
CURRENT_WORKSPACE_TAG="CURRENT_WORKSPACE_TAG"

# We don't need nor want multiple instances of the same exact script.
pidof -x -o $$ "$(basename "$0")" && exit 1

# Basic string...
wmctrl -i -a \
"$(wmctrl -l \
| fzf \
 --bind='end:last' \
 --bind='home:first' \
 --bind='shift-tab:up' \
 --bind='tab:down' \
 --border-label="[WINDOWS]" \
 -d ' ' \
 -e \
 -i \
 --no-info \
 --scroll-off="5" \
 --tiebreak="index" \
 --with-nth="3.." \
| cut -d ' ' -f1)" \
2>/dev/null &&

# Send a notification upon workspace change
dunstify "$(wmctrl -d \
| grep '\*' \
| tr -s " " \
| cut -d' ' -f10)" \
 -h string:x-dunst-stack-tag:"$CURRENT_WORKSPACE_TAG" \
 -t 1000
