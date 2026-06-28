#!/bin/bash
sleep 2

# Switch to workspace 1
hyprctl dispatch workspace 1
sleep 0.3

# First window: nvim (becomes left pane)
kitty bash -c "tmux new-session -A -s main -n 'nvim' -c ~/Desktop/Coding 'nvim'" &
sleep 1

# Second window: fastfetch (splits right)
kitty bash -c "fastfetch; exec bash" &
sleep 1

# Third window: cava (splits below fastfetch)
kitty bash -c "cava" &
sleep 0.8

# Left pane takes ~65% of screen width (nvim)
hyprctl dispatch splitratio -0.15

# Right column: fastfetch gets ~35%, cava gets ~65%
# Focus fastfetch first then set its ratio
hyprctl dispatch focuswindow class:kitty,title:bash
sleep 0.2
hyprctl dispatch splitratio -0.3
