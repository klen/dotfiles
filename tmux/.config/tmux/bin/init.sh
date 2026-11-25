
type -P tmux >/dev/null && {
  # # Make tmux use the same PATH as the shell
  # tmux set-environment -g PATH "$PATH"

  # Auto run tmux on remote servers
  if [ -n "$SSH_CLIENT" ] && [ -z "$TMUX" ]; then
    exec tmux new-session -A -s ssh
  fi
}
