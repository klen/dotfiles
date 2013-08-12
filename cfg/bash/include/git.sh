__command git && {

    source $CMPDIR/git.sh
    source $CMPDIR/git-flow.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    PS1=$PS1$GREEN'$(__git_ps1 " (%s)"):'$NC

}
