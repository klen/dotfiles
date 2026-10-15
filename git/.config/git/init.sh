type -P git > /dev/null || return

source $XDG_CONFIG_HOME/git/promt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1

# Prompt git calls must not take .git/index.lock (they only refresh the index
# cache as a side effect), otherwise they race with real `git add`/`commit`.
# NB: `git diff` ignores this and writes the index anyway, so promt.sh uses
# the diff-files/diff-index plumbing instead.
__git_ps1_nolock() { GIT_OPTIONAL_LOCKS=0 __git_ps1 "$@"; }
PS1=$PS1$GREEN'$(__git_ps1_nolock " (%s)")'$NC
