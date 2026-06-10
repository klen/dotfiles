
type -P tmux >/dev/null && {
  # # Make tmux use the same PATH as the shell
  # tmux set-environment -g PATH "$PATH"

  # Auto run tmux on remote servers
  if [ ! -z "$SSH_CLIENT" ] && [ -z $TMUX ]; then
    exec tmux new-session -A -s ssh
  fi
}

type -P tmuxp >/dev/null 2>&1 && {
  alias tml='tmuxp load -y'

  _tml_completions() {
    local curr_word
    curr_word="${COMP_WORDS[COMP_CWORD]}"

    # Получаем список tmuxp configs (по умолчанию в ~/.tmuxp/)
    COMPREPLY=($(compgen -W "$(ls ~/.tmuxp/ | sed 's/\.yaml$//' | sed 's/\.yml$//')" -- "$curr_word"))
  }

  complete -F _tml_completions tml
}
