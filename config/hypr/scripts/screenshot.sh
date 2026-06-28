#!/usr/bin/env bash
FILEPATH="$HOME/Pictures/Screenshots/Screenshot $(date +%Y-%m-%d_%H%M%S).png"
FILENAME=$(basename "$FILEPATH")

hyprshot -m output -m active --output-folder ~/Pictures/Screenshots/ --filename "$FILENAME" --silent

CHOICE=$(notify-send "Screenshot Saved" \
  --action="default,Open")

if [ "$CHOICE" == "0" ]; then
  gwenview "$FILEPATH" &
fi
