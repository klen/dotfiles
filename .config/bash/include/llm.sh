[ -d "$HOME/.lmstudio/bin" ] && {
    case ":${PATH}:" in
      *:"$HOME/.lmstudio/bin":*) ;;
      *) PATH="$HOME/.lmstudio/bin:$PATH" ;;
    esac
}
