#!/bin/sh

# Screensaver

xscreensaver --no-splash &

# Wallpaper

sleep 1 &&
xwallpaper --stretch Pictures/Wallpapers/Gradient/Mint-Y/Mint-Y-Pink-Gradient.png &

# XDG User Directories

xdg-user-dirs-update &

# Xfce4 Settings Daemon, required for configuring Xfwm4 as a standalone window manager.

xfsettingsd --daemon &

# Start Xfwm4 in a [while] loop, allows us to restart Xfwm4 as a standalone window manager.

while true ; do
    xfwm4
done
