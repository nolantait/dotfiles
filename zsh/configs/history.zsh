HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000

setopt appendhistory
setopt extended_history       # Include more information about when the command was executed, etc
setopt hist_expire_dups_first
setopt hist_find_no_dups      # When searching history don't display results already cycled through twice'
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt histignorealldups      # If a new command is a duplicate, remove the older one
setopt hist_reduce_blanks     # Remove extra blanks from each command line being added to history
setopt hist_ignore_space
setopt hist_save_no_dups
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit'

export ERL_AFLAGS="-kernel shell_history enabled"
