# Base promt settings
# ===================


unset PROMPT_COMMAND

PS1="\n"

# shell level
if [ ! "$SHLVL" = "1" ]; then
    PS1="\n${MAGENTA}[$SHLVL] "
fi

# time
PS1="${PS1}${GRAY}\A "

# parent and current pids
PS1="${PS1}${GREEN}$$ "

# current user
case `id -u` in
    0) PS1="${PS1}$RED\u";;
    *) PS1="${PS1}$BLUE\u" ;;
esac

# hostname
__command hostname && {
    if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_CLIENT2" ]; then
        PS1="${PS1}@${BLUE}$(hostname -f)"
    else
        PS1="${PS1}@${RED}$(hostname -f)"
    fi
} || {
    PS1="${PS1}@${BLUE}\H"
}

# current path
PS1="${PS1} ${WHITE}\w"
