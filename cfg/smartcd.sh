# Setup Smartcd
[ -d $CFGDIR/smartcd/lib ] && {

    source $CFGDIR/smartcd/lib/core/arrays
    source $CFGDIR/smartcd/lib/core/varstash
    source $CFGDIR/smartcd/lib/core/smartcd
    smartcd setup cd
    smartcd setup pushd
    smartcd setup popd
    smartcd setup completion

}
