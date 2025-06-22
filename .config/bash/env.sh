# Set some options
# ================

# Setup XDG Base Directory specification
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Common settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export OS=$(uname -s)

export EDITOR=nvim
# export VISUAL=nvim
export PAGER=less

# Bash history
export HISTSIZE=
export HISTFILESIZE=
export HISTIGNORE="&:cd:ls:[bf]g:exit:bash:la:deactivate:tox:detox:history"
export HISTCONTROL=ignoreboth:erasedups

# Debian package settings
export DEBFULLNAME="Kirill Klenov"
export DEBEMAIL="horneds@gmail.com"

export GPGKEY=7000E266

# Mac OS (silence zsh warning message)
export BASH_SILENCE_DEPRECATION_WARNING=1

export CLICOLOR=1
export LS_OPTIONS=--color
# export LSCOLORS=Hxfxcxdxbxegedabagacad

# for the love of god don't offer to autocomplete this shit
export FIGNORE="#:~:DS_Store:.pyc:.swp:.swo"

# Ansible
export ANSIBLE_NOCOWS=1

# Tools
type pyenv &>/dev/null && eval "$(pyenv init --path)"
type zoxide &>/dev/null && eval "$(zoxide init bash)"

# Load user-specific environment variables
[ -f "$XDG_CONFIG_HOME/env.local" ] && source "$XDG_CONFIG_HOME/env.local"

alias env='env | sort'
alias envs='env | sort | grep -v -E "^(BASH|PWD|SHLVL|XDG_|_)"'
