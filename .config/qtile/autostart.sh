#!/bin/bash

# Network Manager Applet
nm-applet &

# Use `qtile cmd-obj` to control Qtile from the command line
# Open zsh terminal in workspace 1
qtile cmd-obj -o cmd -f spawn -a "alacritty -e zsh" -o group -f toscreen -a 0
qtile cmd-obj -o group 1 -f toscreen

# Open Brave browser in workspace 2
qtile cmd-obj -o cmd -f spawn -a "brave-bin" -o group -f toscreen -a 1
qtile cmd-obj -o group 2 -f toscreen

