_is_cmd_exist gpg && {

    [ ! -r $HOME/.gnupg/trustdb.gpg  ] && {

        gpg --import $HOME/.home/cfg/gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
