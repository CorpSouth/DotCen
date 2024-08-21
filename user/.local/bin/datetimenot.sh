#!/bin/sh

# Define a message tag to reduce clutter.
date_time_msg_tag="date_time_msg_tag"

# Simple string to relay the current date-time.
dunstify "$(date '+%x %r')" -h string:x-dunst-stack-tag:"$date_time_msg_tag"
