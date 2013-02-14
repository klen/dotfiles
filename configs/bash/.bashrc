# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker


# Path fixes {{{
# ===============

    [ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# }}}


# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Define options
SOURCEDIR=$HOME/.home
UTILSDIR=$SOURCEDIR/configs/bash
PROJECTDIR=$HOME/Dropbox/projects/
WORKDIR=$HOME/Dropbox/work/
OS=$(uname -s)

# Options
. $UTILSDIR/include/options.sh

# Colors
. $UTILSDIR/include/colors.sh

# Login screen
. $UTILSDIR/include/login.sh

# Base promt settings
. $UTILSDIR/include/ps.sh

# Patch PATH
. $UTILSDIR/include/path.sh

# Completion
. /usr/local/etc/bash_completion 2>/dev/null
. $UTILSDIR/completion/makesite.sh
. $UTILSDIR/completion/vagrant.sh
. $UTILSDIR/completion/knife.sh
. $UTILSDIR/completion/cap.sh
. $UTILSDIR/completion/gem.sh

# Git support
. $UTILSDIR/include/git.sh

# Functions
. $UTILSDIR/include/functions.sh

# RVM support
[[ -s "$HOME/.rvm/scripts/rvm" ]] && {
    source "$HOME/.rvm/scripts/rvm"
    source "$HOME/.rvm/scripts/completion"
}


# Python PIP support
# ==================
export PIP_DOWNLOAD_CACHE=/tmp/.pip/$USER/cache
export PIP_LOG_FILE=/tmp/.pip/$USER/pip.log

. $UTILSDIR/completion/pip.sh


# Utitities support {{{
# =====================
    
    _cdp_completion() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "`find $PROJECTDIR -maxdepth 1 -type d -not -empty`" -- ${cur}) )
    }
    cdp () { cd $1; }
    complete -o default -o nospace -F _cdp_completion cdp

    _cdw_completion() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "`find $WORKDIR -maxdepth 1 -type d`" -- ${cur}) )
    }
    cdw () { cd $1; }
    complete -o default -o nospace -F _cdw_completion cdw

# }}}


# Additional sources {{{
# =======================

    # bash aliases
    [ -f ~/.bash_aliases ] && source ~/.bash_aliases

    # bash completion
    [ -f /etc/bash_completion ] && source /etc/bash_completion

    # local bash settings
    [ -f ~/.bash_local ] && source ~/.bash_local

# }}}


# Close promt
PS1="${PS1}\n\$ "

command -v cowsay > /dev/null && {
    fortune -s | cowsay -f $SOURCEDIR/stuff/girl.cow
}
