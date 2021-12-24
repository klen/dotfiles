if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
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

# Homebrew coreutils
[ -d /usr/local/opt/coreutils/libexec/gnubin/ ] && PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Homebrew curl
[ -d /usr/local/opt/curl/bin ] && PATH=/usr/local/opt/curl/bin:$PATH

# Homebrew mysql-client
[ -d /usr/local/opt/mysql-client/bin ] && PATH=/usr/local/opt/mysql-client/bin:$PATH
