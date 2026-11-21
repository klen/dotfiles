#!/usr/bin/env bash
# ─────────────────────────────────────────────
# Session switcher — pick a session with fzf, switch the calling client
# ─────────────────────────────────────────────

set -euo pipefail

current=$(tmux display-message -p '#{session_name}')

out=$(tmux list-sessions -F '#{session_name}' | FZF_DEFAULT_OPTS= fzf --layout=reverse-list --no-input --print-query --tiebreak=index \
  --bind 'start:disable-search,j:down,k:up,q:abort,i:enable-search+show-input+clear-query+unbind(j)+unbind(k)+unbind(d)+unbind(q)+unbind(i),esc:transform:[ "$FZF_INPUT_STATE" = hidden ] && echo abort || echo "disable-search+hide-input+rebind(j)+rebind(k)+rebind(d)+rebind(q)+rebind(i)"' \
  --bind 'd:execute-silent(target={}; [ -n "$target" ] || exit 0; if [ "$target" = "'"$current"'" ]; then next=$(tmux list-sessions -F "#{session_name}" | grep -vxF "$target" | head -1); [ -n "$next" ] || exit 0; tmux switch-client -t "$next"; fi; tmux kill-session -t "$target")+reload(tmux list-sessions -F "#{session_name}")' \
  --prompt='session › ' --header="current: $current · j/k move · i search · Enter new · d kill · q quit" \
  --preview 'tmux capture-pane -ep -t {} | tail -n ${FZF_PREVIEW_LINES:-30}' \
  --preview-window='right:50%') || [ $? = 1 ] || exit 0

session=$(printf '%s\n' "$out" | sed -n 2p)
query=$(printf '%s\n' "$out" | sed -n 1p)
[ -n "$session" ] || { [ -n "$query" ] || exit 0; session=$(tmux new-session -dP -F '#{session_name}' -s "$query"); }
tmux switch-client -t "$session"
