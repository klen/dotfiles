# Functions
# =========

# Show help
hh () {
    echo "Avalible commands:"

    echo "pk type filename                    pack archive"
    echo "ex filename                         unpack archive"

    echo "ff FILENAME                         find file by FILENAME"
    echo "ffe FILENAME COMMAND                find file by FILENAME and execute COMMAND"
    echo "ffs [-i] STRING [FILENAME]          find STRING in file"
    echo "ffr [-i] STRING1 STRING2 [FILENAME] replace STRING in file"

    echo "killps [-SIGNAL] PROCNAME           kill process by PROCNAME"
    echo "psm                                 show my processes"
    echo "psa                                 show all processes"
    echo "psmt                                show my tree process"

    echo "log                                 tailf wrapper"

    echo "ii                                  show system info"

    echo "colors                              show ansi colors table"

    echo "config                              edit dotfiles"
    echo "vim-conf                            edit vim configuration"
    echo "nvim-conf                           edit neovim configuration"
    echo "kitty-conf                          edit kitty configuration"
}

# Find file by template
ff() { find . -type f -iname '*'$*'*' -ls ; }

# find file by template and execute command
ffe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# find string in files
ffs() {
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
    find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

# find and replace string in files
ffr() {
    local CMD=grep -rl $1 $3 | xargs sed -i "s/$1/$2/g"
    echo $CMD
    $CMD
}

# Show current user processes
psm() { ps $@ -u $USER -o pid,user,%cpu,%mem,bsdtime,command ; }

psa() { ps fax -o pid,ppid,user,%cpu,%mem,bsdtime,command ; } 

# Show tree of current user processes
psmt() { psm f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

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
        if _ask "Send signal $sig to process $pid <$pname>?"
            then kill $sig $pid
        fi
    done
}

# Show system information
ii() {
    echo -en "\n${RED}System:$NC " ;uname -a
    echo -en "${RED}Date:$NC " ; date
    echo -en "${RED}Uptime :$NC " ; uptime
    echo -e "\n${RED}System logged users:$NC " ;w -h
    _is_cmd_exist free && echo -e "\n${RED}Free :$NC " && free
    command -v landscape-sysinfo && landscape-sysinfo
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


# Set terminal title
title () {
    echo -en "\033]2;$1\007"
}

# tailf wrapper
log () {
    title $1
    local CMD="tail -f -n ${2:-200} $1"
    test -r $1 && $CMD || sudo $CMD
}

colors () {
    for i in {30..37}; do
        echo -e "\033[0;${i}m 0;${i} | \033[1;${i}m 1;${i}"
        echo -e ""
    done | column -c 80 -s ' ';
   # for i in {0..255}; do echo -e "\e[38;05;${i}m\\\e[38;05;${i}m"; done | column -c 80 -s '  '; echo -e "\e[m" 
}

# Setup editors
conf-vim () {
    cd $HOME/.home/.vim
    vim init.vim
}

conf-nvim () {
    cd $HOME/.home/.config/nvim
    nvim init.lua
}

conf-kitty () {
    cd $HOME/.home/.config/kitty
    $EDITOR kitty.conf
}

conf-bash () {
    cd $HOME/.home/.config/bash
    $EDITOR main.sh
}

conf-home () {
    cd $HOME/.home
    $EDITOR Makefile
}

# Utils
# -----

_is_cmd_exist () {
    type "$1" &> /dev/null ;
}

_ask () {
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

# vim:fdm=indent
