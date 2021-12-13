[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "/usr/local/bin" ] && PATH=/usr/local/bin:$PATH
[ -d "/usr/local/sbin" ] && PATH=/usr/local/sbin:$PATH

# Macports integration
[ -d /opt/local/bin ] && PATH=/opt/local/bin:$PATH
[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH

# Haskel cabal
[ -d "$HOME/.cabal/bin/" ] && PATH=$HOME/.cabal/bin:$PATH

# NodeJS integration
[ -d $HOME/node_modules/.bin ] && PATH=$HOME/node_modules/.bin:$PATH
[ -d /usr/local/share/npm/bin/ ] && PATH=/usr/local/share/npm/bin:$PATH

# Android SDK tools
[ -d $HOME/Desktop/android-sdk-linux ] && PATH=$HOME/Desktop/android-sdk-linux/tools:$HOME/Desktop/android-sdk-linux/platform-tools:$PATH

# Homebrew coreutils
[ -d /usr/local/opt/coreutils/libexec/gnubin/ ] && PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Homebrew curl
[ -d /usr/local/opt/curl/bin ] && PATH=/usr/local/opt/curl/bin:$PATH

# Homebrew mysql-client
[ -d /usr/local/opt/mysql-client/bin ] && PATH=/usr/local/opt/mysql-client/bin:$PATH
