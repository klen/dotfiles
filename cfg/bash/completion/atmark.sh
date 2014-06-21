_atmark_complete() {
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _ATMARK_COMPLETE=complete $1 ) )
    return 0
}
complete -F _atmark_complete -o default @ @@;
