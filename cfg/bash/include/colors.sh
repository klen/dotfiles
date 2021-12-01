# Define color variables
# ======================

if [ ! -t 1 ] || [ $(tput colors) -lt 8 ]; then
    export BLUE=''
    export CYAN=''
    export GREEN=''
    export MAGENTA=''
    export NC=''
    export RED=''
    export WHITE=''
    export YELLOW=''
    export blue=''
    export cyan=''
    export green=''
    export magenta=''
    export red=''
    export white=''
    export yellow=''
else
    export BLUE='\033[1;34m'
    export CYAN='\033[1;36m'
    export GREEN='\033[0;32m'
    export MAGENTA='\033[1;35m'
    export NC='\033[0m'
    export RED='\033[1;31m'
    export WHITE='\033[1;37m'
    export YELLOW='\033[1;33m'
    export blue='\033[0;34m'
    export cyan='\033[0;36m'
    export green='\033[0;32m'
    export magenta='\033[0;35m'
    export red='\033[0;31m'
    export white='\033[0;37m'
    export yellow='\033[0;33m'
fi
