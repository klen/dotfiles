# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Read main configuration
source $HOME/.config/bash/bashrc

# Stop LM Studio to modify PATH
# export PATH="$PATH:/Users/horneds/.lmstudio/bin"
