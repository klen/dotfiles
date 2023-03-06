# Brew support
# if [ "$OS_VERSION" = "Darwin" ]; then
    # PATH="/usr/local/share/python:$PATH"
# fi

export PYTHONBREAKPOINT=ipdb.set_trace

_is_cmd_exist pip && {
    export PIP_DOWNLOAD_CACHE=/tmp/.pip/$USER/cache
    export PIP_LOG_FILE=/tmp/.pip/$USER/pip.log
}

_is_cmd_exist pyenv && {
  eval "$(pyenv init -)"
}

_is_cmd_exist poetry && {
  export POETRY_CONFIG_DIR=$XDG_CONFIG_HOME/pypoetry
  export POETRY_DATA_DIR=$XDG_DATA_HOME/pypoetry
}
