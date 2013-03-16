[ -d "/usr/local/sbin" ] && PATH="$/usr/local/sbin:$PATH"

# Haskel cabal
[ -d "$HOME/.cabal/bin/" ] && PATH="$HOME/.cabal/bin:$PATH"

# NodeJS integration
[ -d $HOME/node_modules/.bin ] && PATH="$HOME/node_modules/.bin:$PATH"
[ -d /usr/local/share/npm/bin/ ] && PATH="/usr/local/share/npm/bin/:$PATH"

# Android SDK tools
[ -d $HOME/Desktop/android-sdk-linux ] && PATH="$HOME/Desktop/android-sdk-linux/tools:$HOME/Desktop/android-sdk-linux/platform-tools:$PATH"
