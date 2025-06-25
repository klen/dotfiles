# pass
hash pass 2>/dev/null && {
  export PASSWORD_STORE_ENABLE_EXTENSIONS=true

  # Support for pass otp (https://github.com/betabrandao/simple-totp)
  PASSWORD_STORE_EXTENSION_COMMANDS+=(otp)

  __password_store_extension_complete_otp() {
    COMPREPLY+=($(compgen -W "-o --option" -- ${cur}))
    _pass_complete_entries 1
  }
}
