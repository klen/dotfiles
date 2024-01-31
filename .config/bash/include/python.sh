# Brew support
# if [ "$OS_VERSION" = "Darwin" ]; then
    # PATH="/usr/local/share/python:$PATH"
# fi

export PYTHONBREAKPOINT=ipdb.set_trace

hash pip 2>/dev/null && {
    export PIP_DOWNLOAD_CACHE=/tmp/.pip/$USER/cache
    export PIP_LOG_FILE=/tmp/.pip/$USER/pip.log
}

hash pyenv 2>/dev/null && {
  eval "$(pyenv init -)"
}

hash poetry 2>/dev/null && {
  export POETRY_CONFIG_DIR=$XDG_CONFIG_HOME/pypoetry
  export POETRY_DATA_DIR=$XDG_DATA_HOME/pypoetry
}
