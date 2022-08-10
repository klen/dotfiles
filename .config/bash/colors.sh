# Define color variables
# ======================

BLUE=''
CYAN=''
GREEN=''
MAGENTA=''
NC=''
RED=''
WHITE=''
YELLOW=''

if [ -t 1 ] || [ $(tput colors) -ge 8 ]; then
    BLUE=$(tput setaf 12)
    CYAN=$(tput setaf 14)
    GREEN=$(tput setaf 10)
    MAGENTA=$(tput setaf 13)
    NC=$(tput sgr 0)
    RED=$(tput setaf 9)
    WHITE=$(tput setaf 15)
    YELLOW=$(tput setaf 11)
fi
