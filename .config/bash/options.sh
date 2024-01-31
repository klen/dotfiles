# Set some options
# ================

# Common settings
shopt -s checkwinsize # Check the window size after each command, and update LINES and COLUMNS if the size has changed.
shopt -s cdspell # Spelling correction of directory names
shopt -s dotglob  # Include filenames beginning with a ‘.’ in the results of filename expansion
shopt -s histappend

# When the first word of a simple command cannot be executed, try to cd to it.
if [ "${BASH_VERSINFO:-0}" -ge 4 ]; then
    shopt -s autocd
fi

[ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Dont make core dump files
ulimit -S -c 0

set -o notify
set -o noclobber
set -o ignoreeof

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export PAGER="less"
export LESS="\
    --RAW-CONTROL-CHARS \
    --ignore-case \
    --LONG-PROMPT \
    --quit-if-one-screen \
    --chop-long-lines"

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
