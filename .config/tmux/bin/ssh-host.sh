#!/bin/bash
# Returns hostname for the current pane.
# If an SSH session is detected on the pane's TTY, returns the remote host
# highlighted with colour45; otherwise returns the local hostname.

tty=$(tmux display-message -p '#{pane_tty}')
ssh_cmd=$(ps -o command= -t "$tty" 2>/dev/null | grep -E '^ssh ' | head -n1)

if [ -n "$ssh_cmd" ]; then
    host=$(echo "$ssh_cmd" | sed -E 's/^ssh[^ ]* //' | awk '{print $1}' | sed 's/.*@//')
    echo "#[fg=colour45]$host"
else
    hostname
fi
