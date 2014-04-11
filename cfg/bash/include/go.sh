__command go && {

    mkdir -p $HOME/go
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin

}
