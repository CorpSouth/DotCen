#!/bin/sh

# Screen Locker

xset s 600 &
xss-lock --transfer-sleep-lock -- slock &

# Slstatus

slstatus &

# Allows DWM to Restart Without Patching

while true ; do
    # No error logging
    dwm >/dev/null 2>&1 
done
