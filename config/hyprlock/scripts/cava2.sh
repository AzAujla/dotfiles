#!/bin/bash
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"
bar_length=${#bar}
for ((i = 0; i < bar_length; i++)); do
  dict+=";s/$i/${bar:$i:1}/g"
done

config_file="/dev/shm/cava_lock_config"
cat >"$config_file" <<EOF
[general]
bars = 14
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

pkill -f "cava -p $config_file"
# cava -p "$config_file" | while IFS= read -r line; do
#   echo "$line" | sed -u "$dict" >/dev/shm/cava_bar
# done

cava -p "$config_file" | while IFS= read -r line; do
  result=""
  IFS=';' read -ra values <<<"$line"
  for val in "${values[@]}"; do
    [[ -z "$val" ]] && continue
    n=$((val > 7 ? 7 : val))
    result+="${bar:$n:1}"
  done
  [[ -n "$result" ]] && echo "$result" >/dev/shm/cava_bar
done
