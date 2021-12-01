# Brew support
# if [ "$OS_VERSION" = "Darwin" ]; then
    # PATH="/usr/local/share/python:$PATH"
# fi

export PYTHONBREAKPOINT=ipdb.set_trace

__command pip && {
    export PIP_DOWNLOAD_CACHE=/tmp/.pip/$USER/cache
    export PIP_LOG_FILE=/tmp/.pip/$USER/pip.log

    source $CMPDIR/pip.sh
}

__command salt && {
    source $CMPDIR/salt.sh
}

__command pyenv && {
    echo "Setup PYENV"
    # export PYENV_ROOT="$HOME/.pyenv"
    # export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    # eval "$(pyenv init -)"
}
