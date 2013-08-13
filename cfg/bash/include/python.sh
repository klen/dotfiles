__command pip && {
    export PIP_DOWNLOAD_CACHE=/tmp/.pip/$USER/cache
    export PIP_LOG_FILE=/tmp/.pip/$USER/pip.log

    source $CMPDIR/pip.sh
}

# Brew support
if [ "$OS_VERSION" = "Darwin" ]; then
    PATH="/usr/local/share/python:$PATH"
fi
