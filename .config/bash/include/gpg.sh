hash gpg 2>/dev/null && {

    [ ! -r $HOME/.gnupg/trustdb.gpg  ] && {

        gpg --import $HOME/.home/cfg/gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
