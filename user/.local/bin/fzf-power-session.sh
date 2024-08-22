#!/bin/sh

# We don't want multiple instances of the same exact script.
pidof -x -o $$ "$(basename "$0")" && exit 1

# Preformat a string to pipe through fzf for the case statement below.
CHOOSE="$(printf 'Lock Screen\nLog Out\nPower Off\nReboot\nSuspend' | fzf --border-label='[FZF-Power-&-Session]' --disabled --info='hidden' --no-scrollbar)"

case "$CHOOSE" in
     "Lock Screen" )
		echo "Are You Sure You Want to Lock Your Screen?"
			read -r "CONFIRMATION"
				if [ "$CONFIRMATION" = "YES" ] ; then
					slock >/dev/null 2>&1
				fi
														;;
     "Log Out" )
		echo "Are You Sure You Want to Log Out?"
			read -r "CONFIRMATION"
				if [ "$CONFIRMATION" = "YES" ] ; then
					pkill -x Xorg >/dev/null 2>&1
     			        fi
														;;
	"Power Off" )
     	echo "Are You Sure You Want to Shut Down?"
     		read -r "CONFIRMATION"
     			        if [ "$CONFIRMATION" = "YES" ] ; then
     				        systemctl poweroff >/dev/null 2>&1
     			        fi
														;;
	"Reboot" )
     	echo "Are You Sure You Want to Reboot?"
     		read -r "CONFIRMATION"
     			        if [ "$CONFIRMATION" = "YES" ] ; then
     				systemctl reboot >/dev/null 2>&1
     			        fi
														;;
	"Suspend" )
     	echo "Are You Sure You Want to Suspend?"
     		read -r "CONFIRMATION"
     			        if [ "$CONFIRMATION" = "YES" ] ; then
					systemctl suspend -i >/dev/null 2>&1
				fi
														;;
     		*)
      													;;
esac






