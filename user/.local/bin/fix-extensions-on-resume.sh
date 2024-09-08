#!/usr/bin/env bash

# We don't want multiple instances of the same exact script
pidof -x -o $$ "$(basename "$0")" && exit 1

# This fixes issues with misbehaving extensions on Cinnamon, particularly during resume from suspend
# Edit the necessary fields to your requirements
dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver'" | \
(
  while true; do
    read -r X
    # If the screen is locked, unset ALL extensions
    if echo "$X" | grep "boolean true" &> /dev/null ; then
      /usr/bin/gsettings reset org.cinnamon enabled-extensions ;
    # When the screen is unlocked, reactivate the following extensions
    elif echo "$X" | grep "boolean false" &> /dev/null ; then
      /usr/bin/gsettings set org.cinnamon enabled-extensions "['opacify@anish.org', 'transparent-panels@germanfr', 'watermark@germanfr']" ;
    fi
  done
)

# How to verify if this script is working:
# Step 1: Open terminal
# Step 2: Type "dconf watch /"
# Step 3: Lock screen or suspend system and pay attention to the outputs
