#!/usr/bin/env bash

set -euo pipefail

SESSION_NAME="default"

PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

sync_tmux_env() {
  tmux set-environment -g PATH "$PATH"
  tmux set-environment -g SHELL "${SHELL:-/bin/bash}"
  tmux set-environment -g HOME "$HOME"
  tmux set-environment -g LANG "${LANG:-en_US.UTF-8}"
  tmux set-environment -g LC_ALL "${LC_ALL:-}"

  if [ -n "${SSH_AUTH_SOCK:-}" ]; then
    tmux set-environment -g SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
  fi

  if [ -n "${GPG_TTY:-}" ]; then
    tmux set-environment -g GPG_TTY "$GPG_TTY"
  fi
}

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  sync_tmux_env
  tmux attach-session -t "$SESSION_NAME"
else
  tmux new-session -s "$SESSION_NAME" -d
  sync_tmux_env
  tmux attach-session -t "$SESSION_NAME"
fi
