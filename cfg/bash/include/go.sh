__is_cmd_exist go && {

    mkdir -p $HOME/go
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin

}
