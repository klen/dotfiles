command -v git >/dev/null && {

    source $HOME/.home/configs/bash/completion/git.sh
    source $HOME/.home/configs/bash/completion/git-flow.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    PS1=$PS1$GREEN'$(__git_ps1 " (%s)"):'$NC

}
