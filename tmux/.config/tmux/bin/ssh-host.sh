#!/bin/bash
# Prints the remote host for panes running ssh, stays silent on the local machine.

tty=$(tmux display-message -p '#{pane_tty}')
ssh_cmd=$(ps -o command= -t "$tty" 2>/dev/null | grep -E '^ssh ' | head -n1)

if [ -n "$ssh_cmd" ]; then
    host=$(echo "$ssh_cmd" | sed -E 's/^ssh[^ ]* //' | awk '{print $1}' | sed 's/.*@//')
    echo " | #[fg=colour45]$host"
fi
