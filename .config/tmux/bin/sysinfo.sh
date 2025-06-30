#!/usr/bin/env bash

# CPU Load Average
load=$(uptime | awk -F'load averages?: ' '{ print $2 }' | cut -d' ' -f1)

# RAM Usage
if [ "$(uname)" = "Darwin" ]; then
  # macOS: используем vm_stat
  pages_free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
  pages_active=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
  pages_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
  pages_speculative=$(vm_stat | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
  pages_wired=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
  pages_compressed=$(vm_stat | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

  pages_used=$((pages_active + pages_inactive + pages_speculative + pages_wired + pages_compressed))
  page_size=$(vm_stat | grep "page size of" | awk '{print $8}' | sed 's/\.//')

  mem_used_mb=$((pages_used * page_size / 1024 / 1024))
  mem_total_bytes=$(sysctl -n hw.memsize)
  mem_total_mb=$((mem_total_bytes / 1024 / 1024))

  mem_usage="${mem_used_mb}M/${mem_total_mb}M"
else
  # Linux: используем free
  mem_usage=$(free -m | awk '/Mem:/ { printf "%dM/%dM", $3, $2 }')
fi

echo "CPU: ${load} | RAM: ${mem_usage}"
