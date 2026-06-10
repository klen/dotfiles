LUA_VERSION="5.4"

[ -d "$HOME/.luarocks/bin/" ] && {
    case ":${PATH}:" in
      *:"$HOME/.luarocks/bin":*) ;;
      *) export PATH="${PATH:+$PATH:}$HOME/.luarocks/bin" ;;
    esac
}

# [ -d "/usr/local/share/lua/${LUA_VERSION}" ] && {
#     export LUA_PATH="/usr/local/share/lua/${LUA_VERSION}/?.lua;/usr/local/share/lua/${LUA_VERSION}/?/init.lua"
# }
# [ -d "/usr/local/lib/lua/${LUA_VERSION}" ] && {
#     export LUA_CPATH="/usr/local/lib/lua/${LUA_VERSION}/?.so;/usr/local/lib/lua/${LUA_VERSION}/?/init.so"
# }
