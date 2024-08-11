#!/bin/sh

# Captures and saves screenshot to preferred directory (full window)

SAVEAS="$(date +%c)-maim.png"
SCREENSHOTSDIR="$HOME/Pictures/Screenshots/"

# Create screenshots directory if it doesn't already exist

if [ ! -d "$SCREENSHOTSDIR" ] ; then
    	mkdir -p "$SCREENSHOTSDIR" ;
fi;

maim -i "$(xdotool getactivewindow)" "$SCREENSHOTSDIR/$SAVEAS" -u
