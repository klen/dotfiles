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

if [ -d "$HOMEBREW_PREFIX/opt/ruby/bin" ]; then
  case ":${PATH}:" in
    *:"$HOMEBREW_PREFIX/opt/ruby/bin":*) ;;
    *) PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH" ;;
  esac
fi
