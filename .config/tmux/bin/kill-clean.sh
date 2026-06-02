#!/usr/bin/env bash
# tmux-kill-clean
# Kills all nvim processes in a tmux session before removing it

set -e

# Argument check
if [ -z "$1" ]; then
  echo "Usage: tmux-kill-clean <session-name>"
  exit 1
fi

SESSION="$1"

# Check if the specified session exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "Session '$SESSION' does not exist."
  exit 1
fi

echo "Closing Neovim instances in tmux session '$SESSION'..."

# Get all pane PIDs in the session
PANES=$(tmux list-panes -t "$SESSION" -F "#{pane_pid}")

for PID in $PANES; do
  # Find child nvim processes for each pane PID
  NVIMS=$(pgrep -P "$PID" nvim || true)
  for NPID in $NVIMS; do
    echo "Sending ':qa' to nvim process $NPID"
    # Check if the process supports RPC
    if lsof -p "$NPID" | grep -q '/tmp/nvim'; then
      # If nvim is configured with --listen /tmp/nvim
      nvim --server /tmp/nvim --remote-send ":qa<CR>"
    else
      # Otherwise send SIGTERM (graceful shutdown)
      kill -TERM "$NPID"
    fi
  done
done

# Wait a few seconds for graceful exit
sleep 1

echo "Killing tmux session '$SESSION'"
tmux kill-session -t "$SESSION"

echo "Done."
