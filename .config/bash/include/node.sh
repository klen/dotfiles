setup () {

    # RVM support
    [ -d $HOME/.meteor ] && {
        PATH=$PATH:$HOME/.meteor
    }

    # NVM support
    # [ -s "/usr/local/opt/nvm/nvm.sh" ] && {
    #     source "/usr/local/opt/nvm/nvm.sh"
    #     [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
    # }

}

setup && unset setup
