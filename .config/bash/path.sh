[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "/usr/local/bin" ] && PATH=/usr/local/bin:$PATH
[ -d "/usr/local/sbin" ] && PATH=/usr/local/sbin:$PATH

# NodeJS integration
[ -d $HOME/node_modules/.bin ] && PATH=$HOME/node_modules/.bin:$PATH
[ -d $XDG_DATA_HOME/npm/bin/ ] && PATH=$XDG_DATA_HOME/npm/bin:$PATH

# Haskel cabal
[ -d "$HOME/.cabal/bin/" ] && PATH=$HOME/.cabal/bin:$PATH
