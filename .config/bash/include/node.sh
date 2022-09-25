setup () {

    # NVM support
    [ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && {
        alias manpath=false  # https://github.com/nvm-sh/nvm/issues/2747
        source "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"
        unalias manpath
        # [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
    }

}

setup && unset setup
