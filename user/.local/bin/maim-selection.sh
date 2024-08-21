#!/bin/sh

# Captures and saves screenshot to preferred directory (selected area).
SAVEAS="$(date +%c)-maim.png"
SAVETO="$HOME/Pictures/Screenshots/"

# Use this to prevent notification clutter.
MAIM_TAG="MAIM_TAG"

# Create screenshots directory if it doesn't already exist.
if [ ! -d "$SAVETO" ] ; then
    	mkdir -p "$SAVETO" ;
fi;

# Capture the screenshot, then send a carefully delayed notification.
maim -s "$SAVETO/$SAVEAS" -u && \
sleep 0.005 && \
dunstify "Screenshot Taken" "(Selected Area)" -h string:x-dunst-stack-tag:"$MAIM_TAG" -t 1000
