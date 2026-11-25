#!/usr/bin/env bash
# Session layout, listed by session-picker.sh (S → s). The picker creates the
# session and sources this file in its first window's shell, so lines work like
# typed commands and $s is the session name. No `set -e` or `exit` here.

# Rename the window to "radio"
tmux rename-window -t pyradio radio

# Start pyradio
cd ~/.config/pyradio
pyradio
