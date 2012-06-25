# Set some options
# ================

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
