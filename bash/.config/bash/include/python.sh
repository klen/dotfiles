# Brew support
# if [ "$OS_VERSION" = "Darwin" ]; then
    # PATH="/usr/local/share/python:$PATH"
# fi

export PYTHONBREAKPOINT=ipdb.set_trace

type -P pyenv >/dev/null 2>&1 && {
  eval "$(pyenv init -)"
}

type -P poetry >/dev/null 2>&1 && {
  export POETRY_CONFIG_DIR=$XDG_CONFIG_HOME/pypoetry
  export POETRY_DATA_DIR=$XDG_DATA_HOME/pypoetry
}

type -P uv >/dev/null 2>&1 && source $XDG_CONFIG_HOME/bash/include/uv.sh
