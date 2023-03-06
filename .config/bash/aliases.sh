# ---------------
# Better terminal
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias fix_term='echo -e "\033c"'            # fix_term:     Reset the conosle.  Similar to the reset command
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias nano='nano -W'                        # Preferred 'nano' implementation
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias rm='rm -i'
alias show_options='shopt'                  # Show_options: display bash options settings
alias src='source ~/.bashrc'                # src:          Reload .bashrc file
alias wget='wget -c'                        # Preferred 'wget' implementation (resume download)
alias t='tail -f'

# Replacements
# _is_cmd_exist bat && alias cat='bat -p --theme="Solarized (dark)"'
# _is_cmd_exist z && alias cd='z'

# Personal
# connect to remote host
alias dsync='rsync -rlvztu --progress --stats'
alias hsync='rsync -lrtvpC .'

# ---------------
# Common
alias ..='cd ..'
alias ...='cd ../..'

alias g='grep'

# ls
alias ls='ls $LS_OPTIONS -Fh'
alias ll='ls $LS_OPTIONS -A'
alias la='ll $LS_OPTIONS -FhlA'

# others
alias vi='vim'
alias sim='sudo vim'
alias timestamp='date "+%Y%m%dT%H%M%S"'

alias myip='dig +short txt ch whoami.cloudflare @1.0.0.1'
