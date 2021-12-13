setup () {

    # RVM support
    [ -d $HOME/.rvm ] && {

        PATH=$PATH:$HOME/.rvm/bin

        source "$HOME/.rvm/scripts/rvm"
        source "$HOME/.rvm/scripts/completion"

    }

    local commands="knife vagrant cap gem"
    for n in $commands; do
        _is_cmd_exist $n && source $XDG_CONFIG_HOME/bash/completion/${n}.sh
    done

    [ -d /usr/local/opt/ruby/bin ] && PATH=/usr/local/opt/ruby/bin:$PATH
}

setup && unset setup
