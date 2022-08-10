# Define color variables
# ======================

export NC=''
export BLUE=''
export CYAN=''
export GREEN=''
export MAGENTA=''
export RED=''
export WHITE=''
export YELLOW=''

if [ -t 1 ] || [ $(tput colors) -ge 8 ]; then
    export NC=$(tput sgr 0)
    export RED=$(tput setaf 9)
    export GREEN=$(tput setaf 10)
    export YELLOW=$(tput setaf 11)
    export BLUE=$(tput setaf 12)
    export MAGENTA=$(tput setaf 13)
    export CYAN=$(tput setaf 14)
    export WHITE=$(tput setaf 15)
fi
