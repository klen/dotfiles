setup () {
    _cd_prjdir=$HOME/Dropbox/projects
    _cd_wrkdir=$HOME/Dropbox/work

    [ -d $_cd_prjdir ] && {
    
        _cdp_completion() {
            local cur="${COMP_WORDS[COMP_CWORD]}"
            local choices=$(find $_cd_prjdir -maxdepth 1 -mindepth 1 -type d)
            COMPREPLY=( $(compgen -W "$choices" -- ${cur}) )
        }
        cdp () { cd $1; }
        complete -o default -o nospace -F _cdp_completion cdp

    }

    [ -d $_cd_wrkdir ] && {
    
        _cdw_completion() {
            local cur="${COMP_WORDS[COMP_CWORD]}"
            local choices=$(find $_cd_wrkdir -maxdepth 1 -mindepth 1 -type d)
            COMPREPLY=( $(compgen -W "$choices" -- ${cur}) )
        }
        cdw () { cd $1; }
        complete -o default -o nospace -F _cdw_completion cdw

    }
}

setup && unset setup
