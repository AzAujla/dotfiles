#!/bin/bash

PIDFILE=/tmp/gpu-screen-recorder.pid
CAPDIR="$HOME/Videos/Captures"

mkdir -p "$CAPDIR"

if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
  # Stop recording
  kill -INT $(cat "$PIDFILE")
  rm "$PIDFILE"
  notify-send -i media-record "Recording stopped" "Saved to $CAPDIR"
else
  RAW_GEOM=$(slurp -b 00000080 -c ffffffff)

  # Exit safely if the user cancels selection
  if [ -z "$RAW_GEOM" ]; then
    echo "Recording canceled."
    notify-send -i media-record "Recording Cancelled" -t 500
    exit 1
  fi

  REGION=$(echo "$RAW_GEOM" | awk -F '[ ,x]' '{
    x = $1; 
    y = $2; 
    w = $3; 
    h = $4; 
    if (w % 2 != 0) w = w - 1; 
    if (h % 2 != 0) h = h - 1; 
    print x " " y " " w " " h
  }')

  # Start recording
  FILENAME="$CAPDIR/$(date '+%Y-%m-%d_%H-%M-%S').mp4"
  gpu-screen-recorder \
    -w "$REGION" \
    -f 60 \
    -k h264 \
    -c mp4 \
    -a default_output \
    -o "$FILENAME" &
  echo $! >"$PIDFILE"
  notify-send -i media-record "Recording started" "$(date '+%H:%M:%S')" -t 500
fi
