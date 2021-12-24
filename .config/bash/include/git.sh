_is_cmd_exist git && {

    # source $XDG_CONFIG_HOME/bash/completion/git.sh
    # source $XDG_CONFIG_HOME/bash/completion/git-flow.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    PS1=$PS1$GREEN'$(__git_ps1 " (%s)"):'$NC

}
