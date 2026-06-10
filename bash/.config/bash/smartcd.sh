# Setup Smartcd
[ -d $XDG_CONFIG_HOME/smartcd/source/lib ] && {

    source $XDG_CONFIG_HOME/smartcd/source/lib/core/arrays
    source $XDG_CONFIG_HOME/smartcd/source/lib/core/varstash
    source $XDG_CONFIG_HOME/smartcd/source/lib/core/smartcd

    smartcd setup cd
    smartcd setup pushd
    smartcd setup popd
    smartcd setup completion

    [ -d $HOME/.smartcd/templates ] || {
      mkdir $HOME/.smartcd >&- || true
      ln -s $XDG_CONFIG_HOME/smartcd/templates $HOME/.smartcd/templates
  }
}
