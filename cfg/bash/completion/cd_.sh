export PRJDIR=$HOME/projects

[ -d $HOME/Dropbox ] && {
    export PRJDIR=$HOME/Dropbox/projects
}

_cdp_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local choices=$(find $PRJDIR -maxdepth 1 -mindepth 1 -type d)
    COMPREPLY=( $(compgen -W "$choices" -- ${cur}) )
}
cdp () { cd $1; }
complete -o default -o nospace -F _cdp_completion cdp
