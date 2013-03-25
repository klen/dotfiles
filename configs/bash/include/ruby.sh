[ -d $HOME/.rvm ] || return

setup () {

    # RVM support

    PATH=$PATH:$HOME/.rvm/bin

    source "$HOME/.rvm/scripts/rvm"
    source "$HOME/.rvm/scripts/completion"

    local commands="knife vagrant cap gem"
    for n in $commands; do
        __command $n && source $DOT_COMPLETION/${n}.sh
    done
}

setup && unset setup
