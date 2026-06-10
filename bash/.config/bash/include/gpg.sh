type -P gpg >/dev/null 2>&1 && {

    [ ! -r $HOME/.gnupg/trustdb.gpg  ] && {

        gpg --import $HOME/.home/cfg/gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
