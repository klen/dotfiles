#!/usr/bin/env bash
# Session layout, listed by session-picker.sh (S → s). The picker creates the
# session and sources this file in its first window's shell, so lines work like
# typed commands and $s is the session name. No `set -e` or `exit` here.
# Kept here rather than in ~/.config/pyradio/.tmux.sh: pyradio deletes unknown
# files from its config directory on startup.

tmux rename-window radio

cd ~/.config/pyradio
pyradio
