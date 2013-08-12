__command gpg && {

    source $CMPDIR/gpg.sh

    [ ! -r $HOME/.gnupg/pubring.gpg  ] && {
    
        gpg --import $HOME/.gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
