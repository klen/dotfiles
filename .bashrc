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


# Options {{{
# ===========

    # Debian package settings
    export DEBFULLNAME="Kirill Klenov"
    export DEBEMAIL="horneds@gmail.com"

    # Common settings
    export LANG="en_US.UTF-8"
    export LC_PAPER="ru_RU.UTF-8"
    export LC_MEASUREMENT="ru_RU.UTF-8"
    export LC_TIME="ru_RU.UTF-8"

    export EDITOR=vim
    export PAGER=less
    export HISTSIZE=1000
    export HISTIGNORE="&:cd:ls:[bf]g:exit:bash:[cxh]:a\ "
    export HISTCONTROL=ignoredups

    shopt -s checkwinsize
    shopt -s cdspell
    shopt -s histappend
    shopt -s dotglob

    [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
    [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)

    # Dont make core dump files
    ulimit -S -c 0
    set -o notify
    set -o noclobber
    set -o ignoreeof

    # History search
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'

# }}}


# Define color variables {{{
# ==========================

    red='\e[0;31m'; RED='\e[1;31m'; GREEN='\e[0;32m'; green='\e[0;32m'; yellow='\e[0;33m'; YELLOW='\e[1;33m'
    blue='\e[0;34m'; BLUE='\e[1;34m'; magenta='\e[0;35m'; MAGENTA='\e[1;35m'; cyan='\e[0;36m'; CYAN='\e[1;36m'
    GRAY='\e[1;30m'; NC='\e[0m'; WHITE='\e[1;37m'; white='\e[0;37m';

# }}}


# Login screen and promt-base {{{
# ==========================

    echo    -e ${yellow}------------------------------ $NC
    echo    -e ${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}
    uname   -a
    cat /etc/*release*
    date

    unset PROMPT_COMMAND

    # current processes pid, number jobs, history number
    PS1="\n${GREEN}${SHLVL}${GRAY}.$$:$PPID \j:\!${GRAY}"

    # current user and domain
    dns=$(dnsdomainname)
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_CLIENT2" ]; then
        color=$BLUE
    else
        color=$RED
    fi
    PS1="${PS1} ${color}\u@\H.${dns}:"

    # current path
    PS1="${PS1} ${WHITE}\w${white}"

    # new line for command
    PS1="${PS1} ${NC}"

# }}}


# Functions {{{
# =============

    # Show help
    function hh () {
        echo "Avalible commands:"
        echo "ff FILENAME                   find file by FILENAME"
        echo "fe FILENAME COMMAND           find file by FILENAME and execute COMMAND"
        echo "fstr [-i] STRING [FILENAME]   find STRING in file"
        echo "mps                           show my process"
        echo "mpst                          show my tree process"
        echo "killps [-SIGNAL] PROCNAME     kill process by PROCNAME"
        echo "ii                            show system info"
        echo "ex filename                   unpack archive"
        echo "pk type filename              pack archive"
        echo "start name                    start service"
        echo "stop name                     stop service"
        echo "restart name                  restart service"
    }

    # find file by template
    ff() { find . -type f -iname '*'$*'*' -ls ; }

    # find file by template and execute command
    fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

    # find string in files
    fstr() {
        OPTIND=1
        local case=""
        local usage="fstr: search string in files. Usage: fstr [-i] \"str template\" [\"filename template\"] "
        while getopts :it opt
        do
            case "$opt" in
            i) case="-i " ;;
            *) echo "$usage"; return;;
            esac
        done
        shift $(( $OPTIND - 1 ))
        if [ "$#" -lt 1 ]; then
            echo "$usage"
            return;
        fi
        local SMSO=$(tput smso)
        local RMSO=$(tput rmso)
        find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
    }

    # Show current user processes
    mps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

    # Show tree of current user processes
    mpst() { mps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

    # Kill process by template
    killps() {
        local pid pname sig="-TERM"
        if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
            echo "Usage: killps [-SIGNAL] template_name"
            return;
        fi
        if [ $# = 2 ]; then sig=$1 ; fi
        for pid in $(mps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
            pname=$(mps | awk '$1~var { print $5 }' var=$pid )
            if ask "Send signal $sig to process $pid <$pname>?"
                then kill $sig $pid
            fi
        done
    }

    ask () {
        echo "$* [y/n]?"
        read ans
        if [ $ans = y -o $ans = Y -o $ans = yes -o $ans = Yes -o $ans = YES ]
        then
            return 0
        fi

        if [ $ans = n -o $ans = N -o $ans = no -o $ans = No -o $ans = NO ]
        then
            return 1
        fi
    }

    # Show system information
    ii() {
        echo -en "\n${RED}System:$NC " ;uname -a
        echo -en "${RED}Date:$NC " ; date
        echo -en "${RED}Uptime :$NC " ; uptime
        echo -e "\n${RED}System logged users:$NC " ;w -h
        echo -e "\n${RED}Free :$NC " ; free
    }

    # unpack
    ex () {
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)   tar xjf $1     ;;
                *.tar.gz)    tar xzf $1     ;;
                *.bz2)       bunzip2 $1     ;;
                *.rar)       rar x $1       ;;
                *.gz)        gunzip $1      ;;
                *.tar)       tar xf $1      ;;
                *.tbz2)      tar xjf $1     ;;
                *.tgz)       tar xzf $1     ;;
                *.zip)       unzip $1       ;;
                *.Z)         uncompress $1  ;;
                *.7z)        7z x $1        ;;
                *)           echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }

    # pack
    pk () {
        if [ $1 ] ; then
            case $1 in
                tbz)   	tar cjvf $2.tar.bz2 $2      ;;
                tgz)   	tar czvf $2.tar.gz  $2      ;;
                tar)  	tar cpvf $2.tar  $2         ;;
                bz2)	bzip $2             ;;
                gz)		gzip -c -9 -n $2 > $2.gz    ;;	
                zip)   	zip -r $2.zip $2    ;;
                7z)    	7z a $2.7z $2               ;;
                *)     	echo "'$1' cannot be packed via pk()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }

    _service () {
        daemon=$1
        action="$2 $3"
        if [ -f /etc/init.d/$daemon ]; then
            for a in $action; do
                sudo /etc/init.d/$daemon $a
            done
        else
            echo "Service '$daemon' not found."
        fi
    }

    start () { _service $1 start ; }
    stop () { _service $1 stop ; }
    restart () { _service $1 stop start; }

#}}}


# Utitities support {{{
# =====================

    # Fast project navigation
    PROJECT_DIR=~/Projects/
    _cdp_completion() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "`find $PROJECT_DIR -maxdepth 1 -type d -not -empty`" -- ${cur}) )
    }
    cdp () { cd $1; }
    complete -o default -o nospace -F _cdp_completion cdp

    # pip bash completion
    _pip_completion() {
        COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" COMP_CWORD=$COMP_CWORD PIP_AUTO_COMPLETE=1 $1 ) )
    }
    complete -o default -F _pip_completion pip

    # Git complete and promt
    if [ -f /usr/bin/git ]; then
        source ~/bin/git-completion.bash
        PS1=$PS1$GREEN'$(__git_ps1 " (%s)"):'$NC
    fi

    # Android SDK tools
    if [ -d $HOME/android-sdk-linux_x86 ]; then
        PATH="$HOME/android-sdk-linux_x86/tools:$HOME/android-sdk-linux_x86/platform-tools:$PATH"
    fi

    # Most usable pip
    spip () {
        if [ ! -z "$VIRTUAL_ENV" ]; then
            sudo pip -E $VIRTUAL_ENV $@
        fi
    }

    # Makesite integration 
    export MAKESITE_HOME=/var/www
    source $(python -c "import makesite, os.path;print os.path.dirname(makesite.__file__)")/shell.sh

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
