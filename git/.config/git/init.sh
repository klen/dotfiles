type -P git > /dev/null || return

source $XDG_CONFIG_HOME/git/promt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
PS1=$PS1$GREEN'$(__git_ps1 " (%s)")'$NC
