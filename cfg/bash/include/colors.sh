# Define color variables
# ======================

if [ ! -t 1 ] || [ $(tput colors) -lt 8 ]; then

    export red=''
    export RED=''
    export GREEN=''
    export green=''
    export yellow=''
    export YELLOW=''
    export blue=''
    export BLUE=''
    export magenta=''
    export MAGENTA=''
    export cyan=''
    export CYAN=''
    export WHITE=''
    export white=''
    export GRAY=''
    export NC=''

else

    export red='\033[0;31m'
    export RED='\033[1;31m'
    export GREEN='\033[0;32m'
    export green='\033[0;32m'
    export yellow='\033[0;33m'
    export YELLOW='\033[1;33m'
    export blue='\033[0;34m'
    export BLUE='\033[1;34m'
    export magenta='\033[0;35m'
    export MAGENTA='\033[1;35m'
    export cyan='\033[0;36m'
    export CYAN='\033[1;36m'
    export WHITE='\033[1;37m'
    export white='\033[0;37m'
    export GRAY='\033[1;30m'
    export NC='\033[0m'

fi

