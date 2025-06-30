# Login screen
# ============

echo -e ${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}
uname -a
cat /etc/lsb-release 2 &>/dev/null
show_welcome() {
  hash cowsay 2>/dev/null && hash fortune 2>/dev/null &&
    fortune -s | cowsay -f "$XDG_CONFIG_HOME/bash/girl.cow" 2>/dev/null
}

if [ -n "$TMUX" ]; then
  if ! tmux show-environment SHOWED_WELCOME >/dev/null 2>&1; then
    show_welcome
    tmux set-environment SHOWED_WELCOME "true"
  fi
else
  if [ -z "$SHOWED_WELCOME" ]; then
    show_welcome
    export SHOWED_WELCOME="true"
  fi
fi

# Information about screens
if [ ! -z "$WINDOW" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
  detached_screens=$(screen -list | grep Detached)
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
