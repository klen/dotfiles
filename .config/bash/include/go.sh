type -P go >/dev/null 2>&1 && {

    mkdir -p $HOME/go
    export GOPATH=$HOME/go
    case ":${PATH}:" in
      *:"$GOPATH/bin":*) ;;
      *) export PATH="${PATH:+$PATH:}$GOPATH/bin" ;;
    esac

}
