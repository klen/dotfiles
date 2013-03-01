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
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias calc='bc -l'
# scroller
alias less='less -r'
# delete
function del () {
    mkdir -p /tmp/.Trash
    mv -f $1 /tmp/.Trash/.
}
# dir list
alias ls='ls -FG' 
alias ll='ls -l'
alias la='ll -A'
alias l='ls -CF'
# deb
# alias dch='dch --vendor=debian'

# others
alias vi='vim'
alias sim='sudo vim'
alias lvim='vim -S "~/.data/sessions/last.session"'

# ---------------
# Color ls
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi
