#!/usr/bin/env bash

if [[ "$(playerctl status 2>/dev/null)" == "Playing" ]]; then
  # pkill cava
  #
  # # Start cava (NOT desktop mode)
  # cava &
  # sleep 0.6
  #
  # # Focus cava window
  # hyprctl dispatch focuswindow class:cava
  # sleep 0.1
  #
  # # Fullscreen focused window
  # hyprctl dispatch fullscreen

  ~/.config/hyprlock/scripts/cava2.sh &
  CAVA_PID=$!
  echo Cava runnning at "$CAVA_PID"
  # Lock screen
  hyprlock --config ~/.config/hyprlock/music.conf
else
  hyprlock
fi

pkill $CAVA_PID
