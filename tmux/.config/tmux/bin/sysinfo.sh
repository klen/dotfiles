#!/usr/bin/env bash

# CPU Load Average
if [ "$(uname)" = "Darwin" ]; then
  cpu_count=$(sysctl -n hw.ncpu)
else
  cpu_count=$(nproc)
fi
load_avg=$(uptime | awk -F'load averages?: ' '{ print $2 }' | cut -d' ' -f1)
load_percent=$(echo "$load_avg $cpu_count" | awk '{ printf "%.0f%%", ($1 / $2) * 100 }')

cpu_usage="${load_percent}"

# RAM Usage
if [ "$(uname)" = "Darwin" ]; then
  vm_stat_output=$(vm_stat)

  page_size=$(echo "$vm_stat_output" | grep "page size of" | awk '{print $8}' | sed 's/\.//')
  pages_active=$(echo "$vm_stat_output" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
  pages_wired=$(echo "$vm_stat_output" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
  pages_compressed=$(echo "$vm_stat_output" | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

  pages_used=$((pages_active + pages_wired + pages_compressed))

  mem_used_mb=$((pages_used * page_size / 1024 / 1024 / 1024))

  ram_usage="${mem_used_mb}GB"
else
  # Linux: used in GB
  ram_usage=$(free -m | awk '/Mem:/ { printf "%.0fGB", $3/1024 }')
fi

# Battery (macOS only; skipped on SSH and on machines without one)
status="CPU ${cpu_usage} / RAM ${ram_usage}"
if [ "$(uname)" = "Darwin" ] && [ -z "$SSH_TTY" ]; then
  batt=$(pmset -g batt)
  if [[ $batt == *InternalBattery* ]]; then
    pct=$(grep -Eo '[0-9]+%' <<<"$batt" | head -n 1)
    if [[ $pct == 100% && $batt == *"AC Power"* ]]; then
      status+=" / POW"
    else
      status+=" / BAT ${pct}"
    fi
  fi
fi

echo "$status"
