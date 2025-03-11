#!/bin/sh

# Symlink dunst config
ln -sf ~/.cache/wal/betterlockscreenrc ~/.config/betterlockscreen/betterlockscreenrc

# Restart dunst with the new color scheme
pkill betterlockscreen
betterlockscreen &

