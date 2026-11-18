#!/usr/bin/env bash
# ─────────────────────────────────────────────
# Command palette — pick a tmux action with fzf
# Runs inside display-popup and acts on the pane that opened it.
# ─────────────────────────────────────────────

set -euo pipefail

# inside a popup tmux resolves these to the pane that opened it
pane=$(tmux display-message -p '#{pane_id}')
session=$(tmux display-message -p '#{session_id}')
dir=$(tmux display-message -p '#{pane_current_path}')

actions=$(cat <<'EOF'
pane: split right|split-right
pane: split down|split-down
pane: break to own window|break-pane
pane: zoom|zoom
pane: rotate up|rotate-up
pane: rotate down|rotate-down
pane: swap with previous|swap-prev
pane: swap with next|swap-next
pane: swap with marked|swap-marked
pane: mark|mark-pane
pane: clear mark|unmark-pane
pane: join marked here|join-marked
pane: copy mode|copy-mode
pane: clear history|clear-history
pane: restart shell|respawn-pane
window: new|new-window
window: next|next-window
window: previous|prev-window
window: last|last-window
window: swap with previous|swap-prev-window
window: swap with next|swap-next-window
window: rename|rename-window
window: synchronize input|sync
layout: tiled|layout-tiled
layout: even vertical|layout-even-v
layout: even horizontal|layout-even-h
layout: main horizontal|layout-main-h
layout: main vertical|layout-main-v
layout: cycle|next-layout
kill: pane|kill-pane
kill: other panes in window|kill-others
kill: window|kill-window
kill: session|kill-session
session: switch|switch-session
session: rename|rename-session
tmux: reload config|reload
EOF
)

# FZF_DEFAULT_OPTS is cleared: its file preview and enter->nvim bind do not fit a command picker
key=$(printf '%s\n' "$actions" | FZF_DEFAULT_OPTS= fzf --reverse --tiebreak=index --delimiter='[|]' --with-nth='{1}' --accept-nth=2 \
    --prompt='tmux › ' --header='pane: / window: / layout: / kill: / session: / tmux:' || true)
[ -n "$key" ] || exit 0

# report the real error on the status line, otherwise it vanishes with the popup
t() { local err; err=$(tmux "$@" 2>&1) || tmux display-message "palette: ${err:-tmux $* failed}"; }

confirm() {
  local answer
  read -r -p "$1 [y/N] " answer
  [[ $answer == [yY] ]]
}

case $key in
new-window)      t new-window -c "$dir" -t "$session:" ;;
next-window)     t next-window -t "$session" ;;
prev-window)     t previous-window -t "$session" ;;
last-window)     t last-window -t "$session" ;;
swap-prev-window) t swap-window -d -s "$pane" -t "$session:-1" ;;
swap-next-window) t swap-window -d -s "$pane" -t "$session:+1" ;;
split-right)     t split-window -h -c "$dir" -t "$pane" ;;
split-down)      t split-window -v -c "$dir" -t "$pane" ;;
break-pane)      t break-pane -s "$pane" ;;
join-marked)     t join-pane -s '{marked}' -t "$pane" ;;
mark-pane)       t select-pane -m -t "$pane" ;;
unmark-pane)     t select-pane -M ;;
swap-prev)       t swap-pane -U -t "$pane" ;;
swap-next)       t swap-pane -D -t "$pane" ;;
swap-marked)     t swap-pane -s '{marked}' -t "$pane" ;;
rotate-up)       t rotate-window -U -t "$pane" ;;
rotate-down)     t rotate-window -D -t "$pane" ;;
zoom)            t resize-pane -Z -t "$pane" ;;
layout-tiled)    t select-layout -t "$pane" tiled ;;
layout-even-v)   t select-layout -t "$pane" even-vertical ;;
layout-even-h)   t select-layout -t "$pane" even-horizontal ;;
layout-main-h)   t select-layout -t "$pane" main-horizontal ;;
layout-main-v)   t select-layout -t "$pane" main-vertical ;;
next-layout)     t next-layout -t "$pane" ;;
sync)            t setw -t "$pane" synchronize-panes ;;
copy-mode)       t copy-mode -t "$pane" ;;
clear-history)   t clear-history -t "$pane" ;;
respawn-pane)    confirm "restart pane $pane?" && t respawn-pane -k -t "$pane" ;;
kill-others)     confirm "kill other panes in this window?" && t kill-pane -a -t "$pane" ;;
rename-window)   read -r -p "window name: " name && t rename-window -t "$pane" "$name" ;;
switch-session)  ~/.config/tmux/bin/session-picker.sh ;;
rename-session)  read -r -p "session name: " name && t rename-session -t "$session" "$name" ;;
kill-pane)       confirm "kill pane $pane?" && t kill-pane -t "$pane" ;;
kill-window)     confirm "kill current window?" && t kill-window -t "$pane" ;;
kill-session)    confirm "kill session $session?" && t kill-session -t "$session" ;;
reload)          t source-file ~/.config/tmux/tmux.conf ;;
esac
