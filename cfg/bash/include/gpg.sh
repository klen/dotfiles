__command gpg && {

    source $DOT_COMPLETION/gpg.sh

    [ ! -r $HOME/.gnupg/pubring.gpg  ] && {
    
        gpg --import $HOME/.gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
