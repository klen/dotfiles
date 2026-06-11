type -P fzf > /dev/null || return

export FZF_DEFAULT_OPTS='
  --height=50%
  --layout=reverse
  --border
  --info=inline
  --preview-window=right:60%
  --preview "bat --color=always --style=numbers --line-range=:200 {}"
  --bind "enter:execute-silent(tmux split-window -h nvim {})+abort"
'
