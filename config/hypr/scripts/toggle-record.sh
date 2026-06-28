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
  # Start recording
  FILENAME="$CAPDIR/$(date '+%Y-%m-%d_%H-%M-%S').mp4"
  gpu-screen-recorder \
    -w eDP-1 \
    -f 60 \
    -k h264 \
    -c mp4 \
    -a default_output \
    -o "$FILENAME" &
  echo $! >"$PIDFILE"
  notify-send -i media-record "Recording started" "$(date '+%H:%M:%S')"
fi
