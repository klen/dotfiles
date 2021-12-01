# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker


# if not running interactively, don't do anything
[ -z "$PS1" ] && return

__command () {
    command -v $1 1>/dev/null
}

setup () {

    local SRCDIR=$HOME/.home
    local CFGDIR=$SRCDIR/cfg
    local LIBDIR=$SRCDIR/lib

    local INCDIR=$CFGDIR/bash/include
    local CMPDIR=$CFGDIR/bash/completion
    local OS_VERSION=$(uname -s)

    # Load options
    source $CFGDIR/bash/options.sh

    # Load colors
    source $INCDIR/colors.sh

    # Load path
    source $CFGDIR/bash/path.sh

    # Load functions
    source $CFGDIR/bash/functions.sh

    # Setup PS
    source $CFGDIR/bash/ps.sh

    # Setup gpg (disabled now)
    # source $INCDIR/gpg.sh

    # Setup completion
    source /usr/local/etc/bash_completion 2>/dev/null || source /etc/bash_completion 2> /dev/null
    source $CMPDIR/makesite.sh
    source $CMPDIR/cd_.sh
    source $CMPDIR/rmqadmin.sh
    __command @ &&  source $CMPDIR/atmark.sh

    # Setup tools
    source $INCDIR/ruby.sh
    source $INCDIR/python.sh
    source $INCDIR/git.sh
    source $INCDIR/go.sh
    source $INCDIR/todo.sh
    source $INCDIR/js.sh
    source $INCDIR/docker.sh

    # Close promt
    PS1="${PS1}\n$ "

    # Smartcd
    source $CFGDIR/smartcd.sh

    # Load aliases
    source ~/.bash_aliases 2>/dev/null

    # Show login screen
    source $CFGDIR/bash/login.sh

    # Auto run screen on remote servers
    __command screen && {
        if [ ! -z "$SSH_CLIENT" ] && [ -z $WINDOW ]; then
            exec screen
        fi
    }
}

setup && unset setup

# Changing the terminal title to the last shell command
# trap 'echo -e "\e]0;$BASH_COMMAND\007"' DEBUG

# Load local settings
source $HOME/.bash_local 2>/dev/null
