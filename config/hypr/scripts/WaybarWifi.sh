#!/bin/bash                                                                                                                                                                      0 (5.239s) < 07:23:47

essid=$(nmcli -t -f active,ssid dev wifi | grep \'^yes\' | cut -d: -f2)
last_word="${essid##* }"
signal=$(cat /proc/net/wireless | awk \'NR==3{print int($3 * 100 / 70)}\')

# Pick icon based on signal (matching your 5-icon array thresholds)
if   [ "$signal" -ge 80 ]; then icon="󰤨"
elif [ "$signal" -ge 60 ]; then icon="󰤥"
elif [ "$signal" -ge 40 ]; then icon="󰤢"
elif [ "$signal" -ge 20 ]; then icon="󰤟"
else                             icon="󰤯"
fi

echo "$icon $last_word"
