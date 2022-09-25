[ -d /opt/homebrew ] && HOMEBREW_PREFIX="/opt/homebrew" || HOMEBREW_PREFIX="/usr/local"
HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

if type brew &>/dev/null
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
fi

# # Homebrew coreutils
# [ -d /usr/local/opt/coreutils/libexec/gnubin/ ] && PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# # Homebrew curl
# [ -d /usr/local/opt/curl/bin ] && PATH=/usr/local/opt/curl/bin:$PATH

# # Homebrew mysql-client
# [ -d /usr/local/opt/mysql-client/bin ] && PATH=/usr/local/opt/mysql-client/bin:$PATH
