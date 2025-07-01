# $HOME/.bashrc for bash-3.0 (or later)
# By Kirill Klenov horneds@gmail.com
# ======================================
# vim:ft=sh:fdm=marker

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# Read main configuration
source $HOME/.config/bash/bashrc

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/horneds/.lmstudio/bin"
# End of LM Studio CLI section

