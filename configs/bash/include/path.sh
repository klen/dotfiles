# Haskel cabal
[ -d "$HOME/.cabal/bin/" ] && PATH="$HOME/.cabal/bin:$PATH"

# NodeJS integration
[ -d $HOME/node_modules/.bin ] && PATH="$HOME/node_modules/.bin:$PATH"

# Android SDK tools
[ -d $HOME/Desktop/android-sdk-linux ] && PATH="$HOME/Desktop/android-sdk-linux/tools:$HOME/Desktop/android-sdk-linux/platform-tools:$PATH"

# RVM scripting
[ -d $HOME/.rvm/bin ] && PATH=$PATH:$HOME/.rvm/bin

# Brew
if [ "$OS" = "Darwin" ]; then
    PATH="/usr/local/share/python:$PATH"
fi
