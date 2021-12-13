# Set some options
# ================

# Common settings
shopt -s histappend
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
