#!/bin/bash

kill $(pgrep -x wallpaper.sh | grep -v $$) 2>/dev/null || true
[ -f "$HOME/.config/hypr/wallpaper.env" ] && source "$HOME/.config/hypr/wallpaper.env"

while true; do
  # Shuffle through all images
  find "$AWW_WALLPAPER_DIR"/ -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf | while read -r wallpaper; do
    awww img "$wallpaper" \
      --transition-type random \
      --transition-duration 1 \
      --transition-fps 144
    sleep 15
  done
done
