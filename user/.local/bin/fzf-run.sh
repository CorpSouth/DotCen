#!/bin/sh

# This allows us to back out gracefully when hitting the escape key
set -e

# We don't want multiple instances of the same exact script
pidof -x -o $$ "$(basename "$0")" && exit 1

# In-Field Separator
IFS=':'

get_selection() {
    if type fzf >/dev/null 2>&1; then
        { IFS=':'; ls -H $PATH; } \
         | sort -u \
         | fzf \
         --border-label="[FZF-Run]"
    else
        exit 1
    fi
}

if selection=$( get_selection ); then
    setsid "$selection" 2>/dev/null 1>/dev/null &

    if [ -n "$1" ]; then
        sleep "$1"
    else
        sleep 0.005
    fi
fi
