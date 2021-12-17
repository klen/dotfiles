# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker

# Load env
source $HOME/.config/bash/env.sh

# Load functions
source $XDG_CONFIG_HOME/bash/functions.sh

# Load options
source $XDG_CONFIG_HOME/bash/options.sh

# Load colors
source $XDG_CONFIG_HOME/bash/colors.sh

# Load path
source $XDG_CONFIG_HOME/bash/path.sh

# Setup PS
source $XDG_CONFIG_HOME/bash/ps.sh

# Aliases
source $XDG_CONFIG_HOME/bash/aliases.sh

# Setup gpg (disabled now)
# source $XDG_CONFIG_HOME/bash/include/gpg.sh

# Setup completion
source /usr/local/etc/bash_completion 2>/dev/null || source /etc/bash_completion 2> /dev/null
source $XDG_CONFIG_HOME/bash/completion/cd_.sh
source $XDG_CONFIG_HOME/bash/completion/rmqadmin.sh
_is_cmd_exist @ && source $XDG_CONFIG_HOME/bash/completion/atmark.sh

# Setup tools
source $XDG_CONFIG_HOME/bash/include/python.sh
source $XDG_CONFIG_HOME/bash/include/git.sh
source $XDG_CONFIG_HOME/bash/include/go.sh
source $XDG_CONFIG_HOME/bash/include/todo.sh
source $XDG_CONFIG_HOME/bash/include/docker.sh
source $XDG_CONFIG_HOME/bash/include/android.sh
source $XDG_CONFIG_HOME/bash/include/rust.sh
_is_cmd_exist node && source $XDG_CONFIG_HOME/bash/include/node.sh
_is_cmd_exist ruby && source $XDG_CONFIG_HOME/bash/include/ruby.sh

# Close promt
PS1="${PS1}\n$ "

# Smartcd
source $XDG_CONFIG_HOME/bash/smartcd.sh

# Load aliases
source ~/.bash_aliases 2>/dev/null

# Show login screen
source $XDG_CONFIG_HOME/bash/login.sh

# Auto run screen on remote servers
_is_cmd_exist screen && {
    if [ ! -z "$SSH_CLIENT" ] && [ -z $WINDOW ]; then
        exec screen
    fi
}

# Changing the terminal title to the last shell command
# trap 'echo -e "\e]0;$BASH_COMMAND\007"' DEBUG

# Load local settings
source $HOME/.bash_local 2>/dev/null