setup () {

    # RVM support
    [ -d $HOME/.rvm ] && {

        case ":${PATH}:" in
          *:"$HOME/.rvm/bin":*) ;;
          *) PATH="${PATH:+$PATH:}$HOME/.rvm/bin" ;;
        esac

        source "$HOME/.rvm/scripts/rvm"
        source "$HOME/.rvm/scripts/completion"

    }

    # RBEnv support
    type -P rbenv >/dev/null 2>&1 && eval "$(rbenv init - bash)"

    local commands="cap gem"
    # for n in $commands; do
    #     hash $n 2>/dev/null && source $XDG_CONFIG_HOME/bash/completion/${n}.sh
    # done

    if [ -d "$HOMEBREW_PREFIX/opt/ruby/bin" ]; then
      case ":${PATH}:" in
        *:"$HOMEBREW_PREFIX/opt/ruby/bin":*) ;;
        *) PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH" ;;
      esac
    fi
    # [ -d /usr/local/lib/ruby/gems/3.0.0/bin/ ] && PATH=/usr/local/lib/ruby/gems/3.0.0/bin:$PATH
}

setup && unset setup
