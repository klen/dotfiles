# Define color variables
# ======================

NC=''
BLUE=''
CYAN=''
GREEN=''
MAGENTA=''
RED=''
WHITE=''
YELLOW=''
blue=''
cyan=''
green=''
magenta=''
red=''
white=''
yellow=''
BOLD=''

if [ -t 1 ] || [ $(tput colors) -ge 8 ]; then
    NC=$(tput sgr 0)
    BOLD=$(tput bold)

    red=$(tput setaf 1)
    RED=$(tput setaf 9)

    green=$(tput setaf 2)
    GREEN=$(tput setaf 10)

    yellow=$(tput setaf 3)
    YELLOW=$(tput setaf 11)

    blue=$(tput setaf 4)
    BLUE=$(tput setaf 12)

    magenta=$(tput setaf 5)
    MAGENTA=$(tput setaf 13)

    cyan=$(tput setaf 6)
    CYAN=$(tput setaf 14)

    white=$(tput setaf 7)
    WHITE=$(tput setaf 15)
fi
