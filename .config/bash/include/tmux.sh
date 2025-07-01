hash tmuxp 2>/dev/null && {
  alias tml='tmuxp load -y'

  _tml_completions() {
    local curr_word
    curr_word="${COMP_WORDS[COMP_CWORD]}"

    # Получаем список tmuxp configs (по умолчанию в ~/.tmuxp/)
    COMPREPLY=($(compgen -W "$(ls ~/.tmuxp/ | sed 's/\.yaml$//' | sed 's/\.yml$//')" -- "$curr_word"))
  }

  complete -F _tml_completions tml
}
