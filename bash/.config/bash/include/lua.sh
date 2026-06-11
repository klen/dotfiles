[ -d "$HOME/.luarocks/bin/" ] && {
    case ":${PATH}:" in
      *:"$HOME/.luarocks/bin":*) ;;
      *) export PATH="${PATH:+$PATH:}$HOME/.luarocks/bin" ;;
    esac
}
