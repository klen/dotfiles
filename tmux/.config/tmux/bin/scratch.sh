#!/usr/bin/env bash
# ─────────────────────────────────────────────
# FloaX — floating pane toggle (no plugin)
# ─────────────────────────────────────────────

SESSION="scratch"

current_session=$(tmux display -p '#{session_name}')
current_dir=$(tmux display -p '#{pane_current_path}')

if [ "$current_session" = "$SESSION" ]; then
    tmux detach-client
else
    if ! tmux has-session -t "$SESSION" 2>/dev/null; then
        tmux new-session -d -c "$current_dir" -s "$SESSION"
        tmux set-option -t "$SESSION" status off
        tmux set-option -t "$SESSION" detach-on-destroy on
    else
        tmux send-keys -t "$SESSION:0" " cd \"$current_dir\"" C-m
    fi

    tmux display-popup \
        -S "fg=magenta" \
        -w 90% -h 90% \
        -b rounded \
        -E \
        "tmux attach-session -t '$SESSION'"
fi
