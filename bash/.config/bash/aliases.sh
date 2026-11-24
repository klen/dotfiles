# Replace defaults
# ----------------
alias cp='cp -iv'               # interactive copy
alias mkdir='mkdir -pv'         # create parent directories as needed
alias mv='mv -iv'               # interactive move
alias rm='rm -i'                # interactive remove
alias wget='wget -c'            # resume downloads
alias grep='grep --color=auto'  # colorize grep output

# Helpers
alias vi='vim'
alias myip='dig +short txt ch whoami.cloudflare @1.0.0.1'
alias grepc='grep --color=auto -C 3' # always forget how to use context with grep, so this is a reminder

# ls aliases
alias ls='ls -Fh'
alias ll='ls -lFh'
alias la='ls -lAFh'

if type -P gls >/dev/null 2>&1; then
    alias ls='gls --color=auto -Fh'
    alias ll='gls --color=auto -lFh'
    alias la='gls --color=auto -lAFh'
elif ls --color=auto /dev/null >/dev/null 2>&1; then
    alias ls='ls --color=auto -Fh'
    alias ll='ls --color=auto -lFh'
    alias la='ls --color=auto -lAFh'
fi
