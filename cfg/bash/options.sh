# Set some options
# ================

# Debian package settings
export DEBFULLNAME="Kirill Klenov"
export DEBEMAIL="horneds@gmail.com"

export GPGKEY=7000E266

# Mac OS (silence zsh warning message)
export BASH_SILENCE_DEPRECATION_WARNING=1

# Common settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export EDITOR=vim
export VISUAL=vim
export PAGER=less

export HISTSIZE=
export HISTFILESIZE=
export HISTIGNORE="&:cd:ls:[bf]g:exit:bash:la:deactivate:tox:detox:history"
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

export CLICOLOR=1
export LS_OPTIONS=--color
# export LSCOLORS=Hxfxcxdxbxegedabagacad

# for the love of god don't offer to autocomplete this shit
export FIGNORE="#:~:DS_Store:.pyc:.swp:.swo"

shopt -s checkwinsize
shopt -s cdspell # Spelling correction of directory names

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

# Ansible
export ANSIBLE_NOCOWS=1
