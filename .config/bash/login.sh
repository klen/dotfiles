# Login screen
# ============

# echo    -e ${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}
# uname   -a
# cat /etc/lsb-release 2&>/dev/null
_is_cmd_exist cowsay && _is_cmd_exist fortune &&  fortune -s | cowsay -f $XDG_CONFIG_HOME/girl.cow 2>/dev/null
# _is_cmd_exist landscape-sysinfo && landscape-sysinfo
_is_cmd_exist lastlog && lastlog -u $USER

# Information about screens
if [ ! -z "$WINDOW" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
    local detached_screens=`screen -list | grep Detached`
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
