HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000

setopt appendhistory
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt inc_append_history

export ERL_AFLAGS="-kernel shell_history enabled"
