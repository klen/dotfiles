# ---------------
# $HOME/.Bash_profile for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com

# ---------------
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
