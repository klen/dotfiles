# Base promt settings
# ===================

unset PROMPT_COMMAND

# current processes pid, number jobs, history number
PS1="\n${GREEN}${SHLVL}${GRAY}.$$:$PPID \j:\!${GRAY}"

# current user and domain
dns=$(dnsdomainname)
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_CLIENT2" ]; then
    host=$BLUE
else
    host=$RED
fi

case `id -u` in
    0) user=$RED ;;
    *) user=$GREEN ;;
esac

PS1="${PS1} ${user}\u${NC}@${host}\H.${dns}:"

# current path
PS1="${PS1} ${WHITE}\w${white}"

# new line for command
PS1="${PS1} ${NC}"
