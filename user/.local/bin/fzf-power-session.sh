#!/bin/sh

# This allows us to back out gracefully when hitting the escape key.
set -e

# We don't want multiple instances of the same exact script.
pidof -x -o $$ "$(basename "$0")" && exit 1

# Print out session options in a line-broken format and pipe through to fzf.
MENU="$(printf 'Lock Screen\nLog Out\nPower Off\nReboot\nSuspend' | fzf --border-label='[FZF-Power-&-Session]' --disabled --info='hidden' --no-scrollbar)"

# Print out confirmation options in a line-broken format and pipe through to fzf.
CONFIRM="$(printf 'Yes\nNo\nBack' | fzf --border-label='Proceed?' --disabled --info='hidden' --no-scrollbar)"

# Yes means proceed, No exits the script, and Back will return you to the previous menu.
# Editing any of the list choices below will require modifying the printf string above. 
case "$MENU" in
             "Lock Screen" )
               case "$CONFIRM" in
                      "Yes" ) echo "Currently Locking Your Screen" ; slock 
       ;;
                      "No" ) exit 1
       ;;
                      "Back" ) exec "$0"
       ;;
               esac
       ;;
             "Log Out" )
               case "$CONFIRM" in
                      "Yes" ) pkill -x Xorg
       ;;
                      "No" ) exit 1
       ;;
                      "Back" ) exec "$0"
       ;;
               esac
       ;;
             "Power Off" )
               case "$CONFIRM" in
                      "Yes" ) systemctl poweroff
       ;;
                      "No" ) exit 1
       ;;
                      "Back" ) exec "$0"
       ;;
               esac
       ;;
	     "Reboot" )
	       case "$CONFIRM" in
	              "Yes" ) systemctl reboot
       ;;
	              "No" ) exit 1
       ;;
	              "Back" ) exec "$0"
       ;;
	       esac
       ;;
	      "Suspend" )
	       case "$CONFIRM" in
	              "Yes" ) systemctl suspend -i
       ;;
	              "No" ) exit 1
       ;;
	              "Back" ) exec "$0"
       ;;
	       esac
       ;;
esac


