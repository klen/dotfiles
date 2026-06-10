case ":${PATH}:" in
  *:"$HOME/bin":*) ;;
  *) [ -d "$HOME/bin" ] && PATH="$HOME/bin${PATH:+:$PATH}" ;;
esac

case ":${PATH}:" in
  *:"$HOME/.local/bin":*) ;;
  *) [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin${PATH:+:$PATH}" ;;
esac

case ":${PATH}:" in
  *:"/usr/local/bin":*) ;;
  *) [ -d "/usr/local/bin" ] && PATH="/usr/local/bin${PATH:+:$PATH}" ;;
esac

case ":${PATH}:" in
  *:"/usr/local/sbin":*) ;;
  *) [ -d "/usr/local/sbin" ] && PATH="/usr/local/sbin${PATH:+:$PATH}" ;;
esac
