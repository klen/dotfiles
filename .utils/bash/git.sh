which git >/dev/null && {

    [ -f $HOME/bin/git-completion.bash ] && . $HOME/bin/git-completion.bash
    [ -f $HOME/bin/git-flow-completion.bash ] && . $HOME/bin/git-flow-completion.bash

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    PS1=$PS1$GREEN'$(__git_ps1 " (%s)"):'$NC

}
