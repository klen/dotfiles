# Setup Smartcd
[ -d $XDG_CONFIG_HOME/smartcd/lib ] && {

    source $XDG_CONFIG_HOME/smartcd/lib/core/arrays
    source $XDG_CONFIG_HOME/smartcd/lib/core/varstash
    source $XDG_CONFIG_HOME/smartcd/lib/core/smartcd
    smartcd setup cd
    smartcd setup pushd
    smartcd setup popd
    smartcd setup completion

}
