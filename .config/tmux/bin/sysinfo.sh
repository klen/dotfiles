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
  mem_total_bytes=$(sysctl -n hw.memsize)
  mem_total_mb=$((mem_total_bytes / 1024 / 1024 / 1024))

  ram_usage="${mem_used_mb}Gb/${mem_total_mb}Gb"
else
  # Linux: used/total in Gb (one decimal)
  ram_usage=$(free -m | awk '/Mem:/ { printf "%.1fGb/%.1fGb", $3/1024, $2/1024 }')
fi

# Battery (macOS only; skip on SSH)
if [ "$(uname)" = "Darwin" ] && [ -z "$SSH_TTY" ]; then
  bat_usage=$(pmset -g batt | grep -Eo '[0-9]+%' | head -n 1)
  echo "CPU ${cpu_usage} | RAM ${ram_usage} | BAT ${bat_usage}"
else
  echo "CPU ${cpu_usage} | RAM ${ram_usage}"
fi
