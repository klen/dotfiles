setup () {

    # RVM support
    [ -d $HOME/.rvm ] && {
    
        PATH=$PATH:$HOME/.rvm/bin

        source "$HOME/.rvm/scripts/rvm"
        source "$HOME/.rvm/scripts/completion"

    }

    local commands="knife vagrant cap gem"
    for n in $commands; do
        __command $n && source $CMPDIR/${n}.sh
    done

    [ -d /usr/local/opt/ruby/bin ] && PATH=/usr/local/opt/ruby/bin:$PATH
}

setup && unset setup
