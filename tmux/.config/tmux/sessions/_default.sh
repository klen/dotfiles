#!/usr/bin/env bash
# Default layout for sessions started from a directory (s → zoxide) when that
# directory has no layout of its own (sessions/<dirname>.sh) and no custom
# layout was picked. The picker already created the first window with cwd set to
# the chosen directory and the window title = session name, so add windows or
# panes here. Runs in the first window's shell, with $s = session name.

tmux split-window -h                # -h = left/right; without it: top/bottom
tmux select-pane -t "$TMUX_PANE"    # back to the pane that runs this file
