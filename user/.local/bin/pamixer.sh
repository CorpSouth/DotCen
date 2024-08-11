#!/bin/sh

# Author: sharpicx 
# Edits: corpsouth

# Arbitary but unique message tag (string:x-dunst-stack-tag:)
# We're using this to prevent notification clutter
vol_msg_tag="pamixer.sh"

case "$1" in
        -d)     # Decrease the volume by five percent
                pamixer -d 5
                # Query pamixer for current volume level
                volume="$(pamixer --get-volume-human)"
                # Notification       # Progress Bar         # Message Tag String                       # Timeout 
                dunstify "󰝞 $volume" -h int:value:"$volume" -h string:x-dunst-stack-tag:"$vol_msg_tag" -t 1000
                ;;
        -i)     # Increase the volume by five percent, allow the volume to go over one-hundred percent
                pamixer --allow-boost -i 5
                # Query pamixer for current volume level
                volume="$(pamixer --get-volume-human)"
                # Notification       # Progress Bar         # Message Tag String                       # Timeout
                dunstify "󰝝 $volume" -h int:value:"$volume" -h string:x-dunst-stack-tag:"$vol_msg_tag" -t 1000
                ;;
        -t)     # Toggle the muted state
                pamixer -t
                # Query pamixer whether or not the source is muted
                muted="$(pamixer --get-mute)"
                # Condition to notify whether the source is muted or unmuted
                if "$muted" ; then
                        # Notification     # Message Tag String                       # Timeout
                        dunstify "󰝟 muted" -h string:x-dunst-stack-tag:"$vol_msg_tag" -t 1000
                else
                        # Notification       # Message Tag String                       # Timeout
                        dunstify "󱄠 unmuted" -h string:x-dunst-stack-tag:"$vol_msg_tag" -t 1000
                fi
                ;;
esac
