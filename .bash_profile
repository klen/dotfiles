# ---------------
# $HOME/.Bash_profile for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com

# ---------------
# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

source "$HOME/.cargo/env"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"