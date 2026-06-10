[ -d "$HOME/Library/Android/sdk" ] && {
    export ANDROID_HOME=$HOME/Library/Android/sdk
    for d in "$ANDROID_HOME/emulator" "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools"; do
        case ":${PATH}:" in
          *:"$d":*) ;;
          *) PATH="${PATH:+$PATH:}$d" ;;
        esac
    done
    export PATH
}
