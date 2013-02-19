# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker


# Update path
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

__command () {
    command -v $1 1>/dev/null
}

setup () {

    local DOT_SOURCE=$HOME/.home
    local DOT_INCLUDE=$DOT_SOURCE/configs/bash/include
    local DOT_COMPLETION=$DOT_SOURCE/configs/bash/completion
    local OS=$(uname -s)
    
    # Load options
    source $DOT_INCLUDE/options.sh
    source $DOT_INCLUDE/colors.sh
    source $DOT_INCLUDE/path.sh
    source $DOT_INCLUDE/ps.sh

    # Functions
    source $DOT_INCLUDE/functions.sh

    # Setup completion
    source /usr/local/etc/bash_completion 2>/dev/null || source /etc/bash_completion 2> /dev/null
    source $DOT_COMPLETION/makesite.sh
    source $DOT_COMPLETION/cd_.sh

    # Setup tools
    source $DOT_INCLUDE/ruby.sh
    source $DOT_INCLUDE/python.sh
    source $DOT_INCLUDE/git.sh

    # Close promt
    PS1="${PS1}\n${GRAY}\A${NC} "

    # Smartcd
    [ -d $DOT_SOURCE/stuff/smartcd/lib ] && {

        source $DOT_SOURCE/stuff/smartcd/lib/core/arrays
        source $DOT_SOURCE/stuff/smartcd/lib/core/varstash
        source $DOT_SOURCE/stuff/smartcd/lib/core/smartcd
        smartcd setup cd
        smartcd setup pushd
        smartcd setup popd
        smartcd setup completion
    
    }

    # Load aliases
    source ~/.bash_aliases 2>/dev/null

    # Load local settings
    source ~/.bash_local 2>/dev/null

    # Show login screen
    source $DOT_INCLUDE/login.sh
}

setup && unset setup
