# Functions
# =========

# Show help
hh() {
  echo "Avalible commands:"

  echo "pk type filename                    pack archive"
  echo "ex filename                         unpack archive"

  echo "ff FILENAME                         find file by FILENAME"
  echo "ffe FILENAME COMMAND                find file by FILENAME and execute COMMAND"
  echo "ffs [-i] STRING [FILENAME]          find STRING in file"
  echo "ffr [-i] STRING1 STRING2 [FILENAME] replace STRING in file"

  echo "killps [-SIGNAL] PROCNAME           kill process by PROCNAME"
  echo "psm                                 show my processes"
  echo "psa                                 show all processes"
  echo "psmt                                show my tree process"

  echo "log                                 tailf wrapper"

  echo "ii                                  show system info"

  echo "colors                              show ansi colors table"

  echo "dotfiles [TYPE]                     edit dotfiles [bash|nvim|vim|...]"
}

# Find file by template
ff() { find . -type f -iname '*'$*'*' -ls; }

# find file by template and execute command
ffe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;; }

# find string in files
ffs() {
  OPTIND=1
  local case=""
  local usage="fstr: search string in files. Usage: fstr [-i] \"str template\" [\"filename template\"] "
  while getopts :it opt; do
    case "$opt" in
    i) case="-i " ;;
    *)
      echo "$usage"
      return
      ;;
    esac
  done
  shift $(($OPTIND - 1))
  if [ "$#" -lt 1 ]; then
    echo "$usage"
    return
  fi
  local SMSO=$(tput smso)
  local RMSO=$(tput rmso)
  find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

# find and replace string in files
ffr() {
  local CMD=grep -rl $1 $3 | xargs sed -i "s/$1/$2/g"
  echo $CMD
  $CMD
}

# Show current user processes
psm() { ps $@ -u $USER -o pid,user,%cpu,%mem,bsdtime,command; }

psa() { ps fax -o pid,ppid,user,%cpu,%mem,bsdtime,command; }

# Show tree of current user processes
psmt() { psm f | awk '!/awk/ && $0~var' var=${1:-".*"}; }

# Kill process by template
killps() {
  local pid pname sig="-TERM"
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: killps [-SIGNAL] template_name"
    return
  fi
  if [ $# = 2 ]; then sig=$1; fi
  for pid in $(mps | awk '!/awk/ && $0~pat { print $1 }' pat=${!#}); do
    pname=$(mps | awk '$1~var { print $5 }' var=$pid)
    if _ask "Send signal $sig to process $pid <$pname>?"; then
      kill $sig $pid
    fi
  done
}

# Show system information
ii() {
  local RED=${RED:-"\e[31m"}
  local NC=${NC:-"\e[0m"}

  echo -e "\n${RED}System:${NC}"
  uname -a

  echo -e "${RED}Date:${NC}"
  date

  echo -e "${RED}Uptime:${NC}"
  uptime

  echo -e "\n${RED}Logged-in users:${NC}"
  w -h

  if command -v free >/dev/null 2>&1; then
    echo -e "\n${RED}Memory usage:${NC}"
    free -h
  fi

  if command -v landscape-sysinfo >/dev/null 2>&1; then
    echo -e "\n${RED}Landscape sysinfo:${NC}"
    landscape-sysinfo
  fi

  if command -v df >/dev/null 2>&1; then
    echo -e "\n${RED}Disk usage:${NC}"
    df -h
  fi
}
# unpack
ex() {
  if [ $# -eq 0 ]; then
    echo "Usage: ex <file>"
    return 1
  fi

  local file="$1"

  if [ ! -f "$file" ]; then
    echo "Error: '$file' is not a valid file"
    return 2
  fi

  case "$file" in
  *.tar.bz2) tar xjf "$file" ;;
  *.tar.gz) tar xzf "$file" ;;
  *.tar.xz) tar xJf "$file" ;;
  *.bz2) bunzip2 "$file" ;;
  *.rar) unrar x "$file" ;;
  *.gz) gunzip "$file" ;;
  *.tar) tar xf "$file" ;;
  *.tbz2) tar xjf "$file" ;;
  *.tgz) tar xzf "$file" ;;
  *.zip) unzip "$file" ;;
  *.Z) uncompress "$file" ;;
  *.7z) 7z x "$file" ;;
  *)
    echo "Error: '$file' cannot be extracted via ex()"
    return 3
    ;;
  esac
}
# pack
pk() {
  if [ $# -lt 2 ]; then
    echo "Usage: pk {tbz|tgz|tar|bz2|gz|gzip|zip|7z} <file_or_folder>"
    return 1
  fi

  local type=$1
  local target=$2

  case "$type" in
  tbz)
    tar cjvf "$target.tar.bz2" "$target"
    ;;
  tgz)
    tar czvf "$target.tar.gz" "$target"
    ;;
  tar)
    tar cpvf "$target.tar" "$target"
    ;;
  bz2)
    bzip2 "$target"
    ;;
  gz | gzip)
    gzip -c -9 -n "$target" >"$target.gz"
    ;;
  zip)
    zip -r "$target.zip" "$target"
    ;;
  7z)
    7z a "$target.7z" "$target"
    ;;
  *)
    echo "Error: '$type' is not supported by pk()"
    return 2
    ;;
  esac
}

# Set terminal title
title() {
  echo -en "\033]2;$1\007"
}

# tailf wrapper
log() {
  title $1
  local CMD="tail -f -n ${2:-200} $1"
  test -r $1 && $CMD || sudo $CMD
}

colors() {
  for i in {30..37}; do
    echo -e "\033[0;${i}m 0;${i} | \033[1;${i}m 1;${i}"
    echo -e ""
  done | column -c 80 -s ' '
  # for i in {0..255}; do echo -e "\e[38;05;${i}m\\\e[38;05;${i}m"; done | column -c 80 -s '  '; echo -e "\e[m"
}

cdp() { cd $1; }

# Utils
# -----

_ask() {
  echo "$* [y/n]?"
  read ans
  if [ $ans = y -o $ans = Y -o $ans = yes -o $ans = Yes -o $ans = YES ]; then
    return 0
  fi

  if [ $ans = n -o $ans = N -o $ans = no -o $ans = No -o $ans = NO ]; then
    return 1
  fi
}

# vim:fdm=indent
