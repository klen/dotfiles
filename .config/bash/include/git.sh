hash git 2>/dev/null && {

  source $XDG_CONFIG_HOME/bash/include/git-promt.sh

  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  PS1=$PS1$GREEN'$(__git_ps1 " (%s)")'$NC

  alias gs ='git status --short --branch'
  alias gd ='git diff'
  alias gl ='git log'
  alias gb ='git branch'

  alias ga ='git add'
  alias gc ='git commit'

  alias gp ='git pull'
  alias gP ='git push'
}
