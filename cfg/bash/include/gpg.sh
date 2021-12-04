__is_cmd_exist gpg && {

    source $CMPDIR/gpg.sh

    [ ! -r $HOME/.gnupg/trustdb.gpg  ] && {

        gpg --import $HOME/.home/cfg/gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
