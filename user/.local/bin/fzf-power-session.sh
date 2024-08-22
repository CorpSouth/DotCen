#!/bin/sh

# This allows us to back out gracefully.
set -e

# We don't want multiple instances of the same exact script.
pidof -x -o $$ "$(basename "$0")" && exit 1

# Print out session options in a line-broken format and pipe through to fzf.
MENU="$(printf 'Lock Screen\nLog Out\nPower Off\nReboot\nSuspend' | fzf --border-label='[FZF-Power-&-Session]' --disabled --info='hidden' --no-scrollbar)"

# Print out confirmation options in a line-broken format and pipe through to fzf.
CONFIRM="$(printf 'Yes\nNo' | fzf --border-label='Proceed?' --disabled --info='hidden' --no-scrollbar)"

# If you edit this, make sure to change the variable strings above to reflect your changes.
case "$MENU" in
                "Lock Screen" )
                case "$CONFIRM" in
                        "Yes" ) slock
                        ;;
                        "No" ) exit 1
                        ;;
                esac
                ;;
                "Log Out" )
                case "$CONFIRM" in
                        "Yes" ) pkill -x Xorg
                        ;;
                        "No" ) exit 1
                        ;;
                esac
		;;
                "Power Off" )
                case "$CONFIRM" in
                        "Yes" ) systemctl poweroff
                        ;;
                        "No" ) exit 1
                        ;;
                esac
		;;
	        "Reboot" )
	        case "$CONFIRM" in
	                "Yes" ) systemctl reboot
	                ;;
	                "No" ) exit 1
	                ;;
	        esac
		;;
	        "Suspend" )
	        case "$CONFIRM" in
	                "Yes" ) systemctl suspend -i
	                ;;
	                "No" ) exit 1
	                ;;
	        esac
		;;
esac
