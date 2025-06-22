# dotfiles - Quickly navigate to and edit various dotfiles and configuration directories.
# Usage: dotfiles [nvim|vim|bin|env|bash|<other>]
#   nvim  - Open Neovim config directory and init.lua in nvim
#   vim   - Open Vim config directory and init.vim in vim
#   bin   - Open user's bin directory in nvim
#   env   - Open env.local in config home with nvim
#   bash  - Open bashrc in bash config directory with nvim
#   <other> - Navigate to the specified directory under config home
#   (no argument) - Go to ~/dotfiles directory

dotfiles() {
  if [ $1 ]; then
    echo "Setting up dotfiles for $1"
    case $1 in
    nvim)
      cd $XDG_CONFIG_HOME/nvim
      nvim $XDG_CONFIG_HOME/nvim/init.lua
      ;;
    vim)
      cd $XDG_CONFIG_HOME/vim
      vim $XDG_CONFIG_HOME/vim/init.vim
      ;;
    bin)
      cd $HOME/bin
      nvim $HOME/bin
      ;;
    env)
      cd $XDG_CONFIG_HOME
      nvim $XDG_CONFIG_HOME/env.local
      ;;
    bash)
      cd $XDG_CONFIG_HOME/bash
      nvim $XDG_CONFIG_HOME/bash/bashrc
      ;;
    *)
      cd $XDG_CONFIG_HOME/$1
      ;;
    esac
  else
    cd ~/dotfiles
  fi
}

# Setup dotfiles completion
_dotfiles_completion() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  opts="bash bin env nvim vim"

  if [[ "$cur" == * ]]; then
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
  fi
}
complete -F _dotfiles_completion dotfiles
