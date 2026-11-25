#!/usr/bin/env bash
# Session layout, listed by session-picker.sh (S → s). The picker creates the
# session and sources this file in its first window's shell, so lines work like
# typed commands and $s is the session name. Plain lines hit that first pane;
# tmux commands run inside this pane, so they need no -t for their own session.
# No `set -e` or `exit` here — this is your shell.

tmux rename-window api

cd ~/projects/ticketscloud.org/vibe-api

tmux new-window -n devops -c ~/projects/ticketscloud.org/vibe-devops

tmux select-window -t "$s:api"
