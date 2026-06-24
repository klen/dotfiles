# pass
type -P pass > /dev/null || return
[[ -z "$PASSWORD_STORE_DIR" ]] && export PASSWORD_STORE_DIR="$HOME/.password-store"

export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# Support for pass otp
PASSWORD_STORE_EXTENSION_COMMANDS+=(otp)

__password_store_extension_complete_otp() {
  COMPREPLY+=($(compgen -W "-o --option" -- ${cur}))
  _pass_complete_entries 1
}

# Create a symlink .password-store/.extensions -> ~/.config/pass/.extensions if not already exists
if [[ ! -L "$HOME/.password-store/.extensions" ]]; then
  ln -s "$HOME/.config/pass/.extensions" "$HOME/.password-store/.extensions"
fi
