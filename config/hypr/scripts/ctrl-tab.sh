#!/usr/bin/env bash

MODE="$1"

ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r '.class')

if [[ "$ACTIVE_CLASS" =~ ^(kitty|Alacritty|foot|wezterm)$ ]]; then
  if [[ "$MODE" == "next" ]]; then
    wtype -M ctrl -k b -m ctrl
    wtype -k n
  else
    wtype -M ctrl -k b -m ctrl
    wtype -k p
  fi
else
  if [[ "$MODE" == "next" ]]; then
    wtype -M ctrl -k Tab -m ctrl
  else
    wtype -M ctrl -M shift -k Tab -m shift -m ctrl
  fi
fi
