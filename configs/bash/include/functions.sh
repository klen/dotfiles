# Functions
# =========

# Show help
hh () {
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
}

# Auto virtualenv activation
cd () {
    builtin cd "$@"
    envs=".env env"
    for e in $envs; do
        if [ -f "$e/bin/activate" ]; then
            if [ "$VIRTUAL_ENV" != "$(pwd -P)/$e" ]; then
                source $e/bin/activate 2> /dev/null && echo Activate virtualenv \"$VIRTUAL_ENV\" && break
            fi
        fi
    done
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
