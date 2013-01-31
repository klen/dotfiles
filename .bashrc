# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker


# Path fixes {{{
# ===============

    [ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
    [ -d "$HOME/.cabal/bin/" ] && PATH="$HOME/.cabal/bin:$PATH"

# }}}


# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Define options
SOURCEDIR=$HOME/.home
UTILSDIR=$SOURCEDIR/.utils
PROJECTDIR=$HOME/Dropbox/projects/
WORKDIR=$HOME/Dropbox/work/

# Options
. $UTILSDIR/bash/options.sh

# Colors
. $UTILSDIR/bash/colors.sh

# Login screen
. $UTILSDIR/bash/login.sh

# Base promt settings
. $UTILSDIR/bash/ps_base.sh

# Functions
. $UTILSDIR/bash/functions.sh

# Completion
. $UTILSDIR/bash/completion_pip.sh
. $UTILSDIR/bash/completion_makesite.sh
. $UTILSDIR/bash/completion_vagrant.sh
. $UTILSDIR/bash/completion_knife.sh
. $UTILSDIR/bash/completion_cap.sh

# Git support
. $UTILSDIR/bash/git.sh


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

    # NodeJS integration
    # ==================
    if [ -d $HOME/node_modules/.bin ]; then
        PATH="$HOME/node_modules/.bin:$PATH"
    fi

    # Android SDK tools
    if [ -d $HOME/Desktop/android-sdk-linux ]; then
        PATH="$HOME/Desktop/android-sdk-linux/tools:$HOME/Desktop/android-sdk-linux/platform-tools:$PATH"
    fi

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

# FIXME: Move to local
export DEBUFULLNAME=Kirill Klenov
export DEBEMAIL=horneds@gmail.com
cowsay -f girl "Let's Go!" 
