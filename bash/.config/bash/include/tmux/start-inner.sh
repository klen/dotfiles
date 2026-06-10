#!/usr/bin/env bash

set -euo pipefail

SESSION_NAME="default"

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

TMUX_BIN="$(command -v tmux)"

sync_tmux_env() {
  tmux set-environment -g PATH "$PATH"
  "$TMUX_BIN" set-environment -g SHELL "${SHELL:-/bin/bash}"
  "$TMUX_BIN" set-environment -g HOME "$HOME"
  "$TMUX_BIN" set-environment -g LANG "${LANG:-en_US.UTF-8}"
  "$TMUX_BIN" set-environment -g LC_ALL "${LC_ALL:-}"

  if [ -n "${SSH_AUTH_SOCK:-}" ]; then
    "$TMUX_BIN" set-environment -g SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
  fi

  if [ -n "${GPG_TTY:-}" ]; then
    "$TMUX_BIN" set-environment -g GPG_TTY "$GPG_TTY"
  fi
}

if "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; then
  sync_tmux_env
  exec "$TMUX_BIN" attach-session -t "$SESSION_NAME"
else
  "$TMUX_BIN" new-session -s "$SESSION_NAME" -d
  sync_tmux_env
  exec "$TMUX_BIN" attach-session -t "$SESSION_NAME"
fi
