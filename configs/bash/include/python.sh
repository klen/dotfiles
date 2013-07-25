__command pip && {
    export PIP_DOWNLOAD_CACHE=/tmp/.pip/$USER/cache
    export PIP_LOG_FILE=/tmp/.pip/$USER/pip.log

    source $DOT_COMPLETION/pip.sh
}

# Brew support
# if [ "$OS" = "Darwin" ]; then
    # PATH="/usr/local/share/python:$PATH"
# fi
