#!/bin/sh

# Use this to prevent notification clutter
MAIM_TAG="MAIM_TAG"

# This command will allow you to select an area on your screen, 
# then copy the selection to your clipboard. This can be used to 
# easily post images in mumble, discord, gimp-- or any other image 
# supporting application.
maim -s -u | xclip -selection clipboard -t image/png && \
dunstify "Screenshot Taken" "(Selection, Copied to Clipboard)" \
 -h string:x-dunst-stack-tag:"$MAIM_TAG" -t 1000
