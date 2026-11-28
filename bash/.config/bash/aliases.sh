# Replace defaults
# ----------------
alias cp='cp -iv'               # interactive copy
alias mkdir='mkdir -pv'         # create parent directories as needed
alias mv='mv -iv'               # interactive move
alias rm='rm -i'                # interactive remove
alias grep='grep --color=auto'  # colorize grep output

# Helpers
alias vi='vim'
alias myip='dig +short txt ch whoami.cloudflare @1.0.0.1'
alias grepc='grep --color=auto -C 3' # always forget how to use context with grep, so this is a reminder

# ls aliases
if type -P gls >/dev/null 2>&1; then
    alias ls='gls --color=auto -Fh'
    alias ll='gls --color=auto -Fhl'
    alias la='gls --color=auto -FhlA'
elif ls --color=auto /dev/null >/dev/null 2>&1; then
    alias ls='ls --color=auto -Fh'
    alias ll='ls --color=auto -Fhl'
    alias la='ls --color=auto -FhlA'
else
    alias ls='ls -Fh'
    alias ll='ls -Fhl'
    alias la='ls -FhlA'
fi
