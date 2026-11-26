#!/usr/bin/env bash
# Default layout for sessions started from a directory (s → zoxide) when that
# directory has no layout of its own (sessions/<dirname>.sh, <dir>/.tmux.sh) and
# no custom layout was picked. The picker already created the first window with
# cwd set to the chosen directory and the window title = session name. Runs in
# the first window's shell, with $s = session name.

pane=$(tmux split-window -hP -F '#{pane_id}')  # a real shell in the right pane, so it survives pi exiting
tmux send-keys -t "$pane" 'pi -c' C-m          # pi -c (continue) on top of that shell
tmux select-pane -t "$TMUX_PANE"               # back to the pane that runs this file
