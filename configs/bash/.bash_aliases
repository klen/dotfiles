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
alias less='less -r'

# dir list
alias ls='ls -FG' 
alias ll='ls -l'
alias la='ll -A'
alias l='ls -CF'

# others
alias vi='vim'
alias sim='sudo vim'
