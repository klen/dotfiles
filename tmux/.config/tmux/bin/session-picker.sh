#!/usr/bin/env bash
# ─────────────────────────────────────────────
# Session switcher — pick a session with fzf, switch the calling client
# ─────────────────────────────────────────────

set -euo pipefail

current=$(tmux display-message -p '#{session_name}')

session=$(tmux list-sessions -F '#{session_name}' | FZF_DEFAULT_OPTS= fzf --reverse --tiebreak=index \
  --prompt='session › ' --header="current: $current" \
  --preview 'tmux list-windows -t {} -F "#{window_index}: #{window_name} (#{window_panes}p)"' \
  --preview-window='right:50%' || true)

[ -n "$session" ] || exit 0
tmux switch-client -t "$session"
