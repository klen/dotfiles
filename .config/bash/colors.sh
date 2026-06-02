# Define color variables
# ======================

BLUE=''
CYAN=''
DIM=''
GREEN=''
MAGENTA=''
NC=''
RED=''
WHITE=''
YELLOW=''

if [ -t 1 ]; then
  colors=$(tput colors 2>/dev/null)
  if [ -n "$colors" ] && [ "$colors" -ge 8 ]; then
    BLUE=$(tput setaf 4)
    CYAN=$(tput setaf 6)
    GREEN=$(tput setaf 2)
    MAGENTA=$(tput setaf 5)
    RED=$(tput setaf 1)
    YELLOW=$(tput setaf 3)
    WHITE=$(tput setaf 7)
    NC=$(tput sgr0)
    DIM=$(tput dim)
  fi
fi
