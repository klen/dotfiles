
__is_cmd_exist todo.sh && {
    source $CMPDIR/todo_completion
    alias t='todo.sh'
    complete -F _todo t
}
