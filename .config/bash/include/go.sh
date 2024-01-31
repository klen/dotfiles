hash go 2>/dev/null && {

    mkdir -p $HOME/go
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin

}
