setopt hist_ignore_all_dups
setopt inc_append_history
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt appendhistory

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000

export ERL_AFLAGS="-kernel shell_history enabled"
