[ -d /opt/homebrew ] && HOMEBREW_PREFIX="/opt/homebrew" || HOMEBREW_PREFIX="/usr/local"

case ":${PATH}:" in
  *:"${HOMEBREW_PREFIX}/bin":*) ;;
  *) PATH="${HOMEBREW_PREFIX}/bin${PATH+:$PATH}" ;;
esac

case ":${PATH}:" in
  *:"${HOMEBREW_PREFIX}/sbin":*) ;;
  *) PATH="${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}" ;;
esac
