source $XDG_CONFIG_HOME/bash/include/homebrew/path.sh

HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

if type -P brew >/dev/null 2>&1
then
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi

  source $XDG_CONFIG_HOME/bash/include/homebrew/java.sh
  source $XDG_CONFIG_HOME/bash/include/homebrew/javascript.sh
  source $XDG_CONFIG_HOME/bash/include/homebrew/python.sh
fi
