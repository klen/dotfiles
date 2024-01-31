setup () {

    # RVM support
    [ -d $HOME/.rvm ] && {

        PATH=$PATH:$HOME/.rvm/bin

        source "$HOME/.rvm/scripts/rvm"
        source "$HOME/.rvm/scripts/completion"

    }

    # RBEnv support
    hash rbenv 2>/dev/null && eval "$(rbenv init - bash)"

    local commands="cap gem"
    # for n in $commands; do
    #     hash $n 2>/dev/null && source $XDG_CONFIG_HOME/bash/completion/${n}.sh
    # done

    [ -d /usr/local/opt/ruby/bin ] && PATH=/usr/local/opt/ruby/bin:$PATH
    # [ -d /usr/local/lib/ruby/gems/3.0.0/bin/ ] && PATH=/usr/local/lib/ruby/gems/3.0.0/bin:$PATH
}

setup && unset setup
