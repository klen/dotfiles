_is_cmd_exist gpg && {

    source $XDG_CONFIG_HOME/bash/completion/gpg.sh

    [ ! -r $HOME/.gnupg/trustdb.gpg  ] && {

        gpg --import $HOME/.home/cfg/gnupg/horneds-pubkey.asc
        gpg --list-keys

    }

}
