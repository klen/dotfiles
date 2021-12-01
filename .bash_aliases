# ---------------
# $HOME/.bash_aliases for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com

# ---------------
# Personal
# connect to remote host
alias dsync='rsync -rlvztu --progress --stats'
alias hsync='rsync -lrtvpC .' 

# ---------------
# Common
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias g='grep'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias less='less -r'

alias ls='ls $LS_OPTIONS -Fh' 
alias ll='ls $LS_OPTIONS -A'
alias la='ll $LS_OPTIONS -FhlA'

# others
alias vi='vim'
alias sim='sudo vim'

alias myip='curl ifconfig.co'
