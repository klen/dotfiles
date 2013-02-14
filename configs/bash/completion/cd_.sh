setup () {
    local PROJECTDIR=$HOME/Dropbox/projects
    local WORKDIR=$HOME/Dropbox/projects

    [ -d $PROJECTDIR ] && {
    
        _cdp_completion() {
            local cur="${COMP_WORDS[COMP_CWORD]}"
            COMPREPLY=( $(compgen -W "`find $PROJECTDIR -maxdepth 1 -type d -not -empty`" -- ${cur}) )
        }
        cdp () { cd $1; }
        complete -o default -o nospace -F _cdp_completion cdp

    }

    [ -d $WORKDIR ] && {
    
        _cdw_completion() {
            local cur="${COMP_WORDS[COMP_CWORD]}"
            COMPREPLY=( $(compgen -W "`find $WORKDIR -maxdepth 1 -type d`" -- ${cur}) )
        }
        cdw () { cd $1; }
        complete -o default -o nospace -F _cdw_completion cdw

    }
}

setup && unset setup
