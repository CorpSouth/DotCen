#!/bin/sh

# We don't want multiple terminal instances running the same exact script.
pidof -x -o $$ "$(basename "$0")" && exit 1

# System Applications Directory
if [ -d "/usr/share/applications" ] ; then
	SYSTEM="/usr/share/applications"
fi

# User Applications Directory, make directory for the user
# if it doesn't already exist yet.
if [ -d "$HOME/.local/share/applications" ] ; then
	USER="$HOME/.local/share/applications"
  elif [ ! -d "$HOME/.local/share/applications" ] ; then
	mkdir -p "$HOME/.local/share/applications"
fi

IFS=':'

# List the given directories for a specific file
# extension and then pipe through fzf.
get_selection() {
    if type fzf >/dev/null 2>&1 ; then
        { IFS=':' ls "$SYSTEM" ; ls "$USER" ; } \
         | grep '.desktop' \
         | sort -u \
         | fzf \
         --border-label="[FZF-GTK-Launch]"
	else
		exit 1
	fi
}

# Prepending setsid to gtk-launch allows this to work at all.
# This requires redirecting outputs to /dev/null, but it's among the
# most UNIX and POSIX compliant solution available, much like nohup.
# Sleep conditions are also placed here so exit isn't slow.
if selection="$( get_selection )" ; then
    setsid gtk-launch "$selection" 2>/dev/null 1>/dev/null &
    if [ -n "$1" ]; then
        sleep "$1"
    else
        sleep 0.005
    fi
fi
