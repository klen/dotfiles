# Login screen
# ============

# echo    -e ${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}
# uname   -a
# cat /etc/lsb-release 2&>/dev/null
if [ -z "$NVIM_LISTEN_ADDRESS" ]; then
    hash cowsay 2>/dev/null && hash fortune 2>/dev/null && fortune -s | cowsay -f $XDG_CONFIG_HOME/bash/girl.cow 2>/dev/null
    # hash landscape-sysinfo 2>/dev/null && landscape-sysinfo
    # hash lastlog 2>/dev/null && lastlog -u $USER
fi

# Information about screens
if [ ! -z "$WINDOW" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
    detached_screens=`screen -list | grep Detached`
    echo -e $YELLOW
    if [ ! -z "$detached_screens" ]; then
        echo "+---------------------------------------+"
        echo "| Detached screens are available:       |"
        echo "$detached_screens"
        echo "+---------------------------------------+"
    else
        echo "[ screen is activated ]"
    fi
    echo -e $NC
    export SHOWED_SCREEN_MESSAGE="true"
fi
