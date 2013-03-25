# Login screen
# ============

echo    -e ${yellow}------------------------------ $NC
echo    -e ${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}
uname   -a
cat /etc/*release* 2>/dev/null
date
__command cowsay && fortune -s | cowsay -f $DOT_SOURCE/stuff/girl.cow 2>/dev/null

setup () {
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
}

setup && unset setup
