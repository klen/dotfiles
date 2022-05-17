# Base promt settings
# ===================


setup () {
    PS1="\n"

    # shell level
    if [ ! "$SHLVL" = "1" ]; then
        PS1="${MAGENTA}[$SHLVL] "
    fi

    # support screen
    if [ ! -z "$WINDOW" ]; then
        PS1="$PS1${YELLOW}<$WINDOW> "
    fi

    # Reset Collor
    PS1="${PS1}${NC}"

    # time
    # PS1="${PS1}\A "

    # PID
    # PS1="${PS1}$$ "

    # current user
    if [ "$SSH_CONNECTION"] ; then
        PS1="${PS1}\u@\h "
    else
        [ "$EUID" -eq 0 ] && PS1="${PS1}$RED\u@ "
    fi
    # case `id -u` in
    #     0) PS1="${PS1}$RED\u";;
    #     *) PS1="${PS1}\u" ;;
    # esac

    # hostname
    # PS1="${PS1}${NC}@\H "

    # current path
    PS1="${PS1}${BLUE}\w"
}

setup && unset setup
