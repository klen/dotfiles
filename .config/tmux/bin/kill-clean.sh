#!/bin/bash
# Kill all nvim instances in a tmux session, then kill the session itself.

# Ensure tmux and other tools are found when run-shell launches a minimal shell
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# If no argument given, infer the current tmux session
SESSION="${1:-$(tmux display-message -p '#{session_name}' 2>/dev/null)}"

if [ -z "$SESSION" ]; then
  echo "Usage: $0 <session-name>"
  exit 1
fi

if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "Session '$SESSION' does not exist."
  exit 1
fi

echo "Closing Neovim instances in tmux session '$SESSION'..."

# Recursively find nvim descendants of a PID
find_nvim_children() {
  local parent=$1
  local children
  children=$(pgrep -P "$parent" 2>/dev/null)
  for child in $children; do
    local cmd
    cmd=$(ps -p "$child" -o comm= 2>/dev/null | sed 's/^ *//')
    if [ "$cmd" = "nvim" ]; then
      echo "$child"
    fi
    find_nvim_children "$child"
  done
}

PANES=$(tmux list-panes -t "$SESSION" -F "#{pane_pid}")
for PID in $PANES; do
  for NPID in $(find_nvim_children "$PID"); do
    echo "Sending SIGTERM to nvim $NPID"
    kill -TERM "$NPID" 2>/dev/null || true
  done
done

sleep 1

echo "Killing tmux session '$SESSION'"
tmux kill-session -t "$SESSION"
echo "Done."
