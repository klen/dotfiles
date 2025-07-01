#!/usr/bin/env bash

# CPU Load Average
cpu_count=$(sysctl -n hw.ncpu)
load_avg=$(uptime | awk -F'load averages?: ' '{ print $2 }' | cut -d' ' -f1)
load_percent=$(echo "$load_avg $cpu_count" | awk '{ printf "%.0f%%", ($1 / $2) * 100 }')

cpu_usage="${load_percent}"

# RAM Usage (macOS)
if [ "$(uname)" = "Darwin" ]; then
  vm_stat_output=$(vm_stat)

  page_size=$(echo "$vm_stat_output" | grep "page size of" | awk '{print $8}' | sed 's/\.//')
  pages_active=$(echo "$vm_stat_output" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
  pages_wired=$(echo "$vm_stat_output" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
  pages_compressed=$(echo "$vm_stat_output" | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

  pages_used=$((pages_active + pages_wired + pages_compressed))

  mem_used_mb=$((pages_used * page_size / 1024 / 1024))
  mem_total_bytes=$(sysctl -n hw.memsize)
  mem_total_mb=$((mem_total_bytes / 1024 / 1024))

  mem_usage="${mem_used_mb}M/${mem_total_mb}M"
else
  # Linux: используем free
  mem_usage=$(free -m | awk '/Mem:/ { printf "%dM used / %dM free / %dM total", $3, $4, $2 }')
fi

echo "CPU: ${cpu_usage} | RAM: ${mem_usage}"
