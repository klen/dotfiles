# Base promt settings
# ===================

unset PROMPT_COMMAND

# current processes pid, number jobs, history number
PS1="\n${GREEN}${SHLVL}.$$:$PPID"

# current user and domain
command -v dnsdomainname > /dev/null && {
    DNS=.$(dnsdomainname)
} || {
    DNS=""
}

if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_CLIENT2" ]; then
    host=$BLUE
else
    host=$RED
fi

case `id -u` in
    0) user=$RED ;;
    *) user=$GREEN ;;
esac

PS1="${PS1} ${user}\u${NC}@${host}\H${DNS}:"

# current path
PS1="${PS1} ${WHITE}\w${white}"

# new line for command
PS1="${PS1} ${NC}"

