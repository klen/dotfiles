
_is_cmd_exist todo.sh && {
    source $XDG_CONFIG_HOME/bash/completion/todo_completion
    alias t='todo.sh'
    complete -F _todo t
}
