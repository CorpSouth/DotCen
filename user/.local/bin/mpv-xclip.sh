#!/bin/sh

# Plays stream URLs from clipboard selection

mpv "$(xclip -o)"
