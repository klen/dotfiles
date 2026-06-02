# ---------------
# Better terminal
alias cic='set completion-ignore-case On' # cic:          Make tab-completion case-insensitive
alias cp='cp -iv'                         # Preferred 'cp' implementation
alias fix_stty='stty sane'                # fix_stty:     Restore terminal settings when screwed up
alias fix_term='echo -e "\033c"'          # fix_term:     Reset the conosle.  Similar to the reset command
alias mkdir='mkdir -pv'                   # Preferred 'mkdir' implementation
alias mv='mv -iv'                         # Preferred 'mv' implementation
alias nano='nano -W'                      # Preferred 'nano' implementation
alias path='echo -e ${PATH//:/\\n}'       # path:         Echo all executable Paths
alias rm='rm -i'
alias show_options='shopt'     # Show_options: display bash options settings
alias src='source ~/.bashrc'   # src:          Reload .bashrc file
alias wget='wget -c'           # Preferred 'wget' implementation (resume download)
alias grep='grep --color=auto' # Preferred 'grep' implementation (colorize output)

# Personal
# connect to remote host
alias dsync='rsync -rlvztu --progress --stats'
alias hsync='rsync -lrtvpC .'

# ---------------
# Common

# ls
if type -P gls >/dev/null 2>&1; then
    alias ls='gls --color=auto -Fh'
    alias ll='gls --color=auto -lFh'
    alias la='gls --color=auto -lAFh'
elif ls --color=auto /dev/null >/dev/null 2>&1; then
    alias ls='ls --color=auto -Fh'
    alias ll='ls --color=auto -lFh'
    alias la='ls --color=auto -lAFh'
else
    alias ls='ls -Fh'
    alias ll='ls -lFh'
    alias la='ls -lAFh'
fi

# others
alias vi='vim'
alias myip='dig +short txt ch whoami.cloudflare @1.0.0.1'
alias oc=opencode
