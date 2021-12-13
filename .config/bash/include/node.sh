setup () {

    # RVM support
    [ -d $HOME/.meteor ] && {
        PATH=$PATH:$HOME/.meteor
    }

}

setup && unset setup
