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

if [ -t 1 ] && [ "$(tput colors)" -ge 8 ]; then
  BLUE=$(tput setaf 4)
  CYAN=$(tput setaf 6)
  GREEN=$(tput setaf 2)
  MAGENTA=$(tput setaf 5)
  RED=$(tput setaf 1)
  YELLOW=$(tput setaf 3)
  WHITE=$(tput setaf 7)
fi

NC=$(tput sgr0)
DIM=$(tput dim)
