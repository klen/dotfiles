# Support for Conda (insalled via Homebrew)
#
[ -d "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d" ] && {
  [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ] && . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"

  export MAMBA_EXE='/opt/homebrew/Caskroom/miniforge/base/bin/mamba'
  [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh" ] && . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/mamba.sh"
}
