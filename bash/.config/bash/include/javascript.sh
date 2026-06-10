# NodeJS integration
[ -d $HOME/node_modules/.bin ] && PATH=$HOME/node_modules/.bin:$PATH
[ -d $XDG_DATA_HOME/npm/bin/ ] && PATH=$XDG_DATA_HOME/npm/bin:$PATH

# Nodeenv support
type -P nodenv >/dev/null 2>&1 && eval "$(nodenv init -)"

# Check that the .bun directory exists before adding it to PATH
if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi
