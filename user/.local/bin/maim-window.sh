#!/bin/sh

# Captures and saves screenshot to preferred directory (full window)
SAVEAS="$(date +%c)-maim.png"
SAVETO="$HOME/Pictures/Screenshots/"

# Use this to prevent notification clutter
MAIM_TAG="MAIM_TAG"

# Create screenshots directory if it doesn't already exist
if [ ! -d "$SAVETO" ] ; then
    	mkdir -p "$SAVETO" ;
fi;

# Capture the screenshot, then send a carefully delayed notification.
maim -i "$(xdotool getactivewindow)" "$SAVETO/$SAVEAS" -u && \
sleep 0.005 && \
dunstify "Screenshot Taken" "(Full Window)" -h string:x-dunst-stack-tag:"$MAIM_TAG" -t 1000
