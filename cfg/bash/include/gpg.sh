__command gpg && {

    source $CMPDIR/gpg.sh

    [ ! -r $HOME/.gnupg/pubring.gpg  ] && {
    
        gpg --import $HOME/.home/cfg/gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
