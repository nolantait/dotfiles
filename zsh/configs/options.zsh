DIRSTACKSIZE=5
# Show time taken for the command to finish if it takes longer than 6 seconds
REPORTTIME=6
# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars

## Options section
setopt correct              # Auto correct mistakes
setopt extendedglob         # Extended globbing. Allows using regular expressions with *
setopt nocaseglob           # Case insensitive globbing
setopt rcexpandparam        # Array expension with parameters
setopt nocheckjobs          # Don't warn about running processes when exiting
setopt numericglobsort      # Sort filenames numerically when it makes sense
setopt nobeep               # No beep
setopt appendhistory        # Immediately append history instead of overwriting
setopt histignorealldups    # If a new command is a duplicate, remove the older one
setopt autocd               # if only directory path is entered, cd there.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt menu_complete        # Automatically highlight first element of completion
setopt auto_list            # Automatically list choices on ambiguous completion
setopt complete_aliases     # Complete aliases


# Allow [ or ] whereever you want
unsetopt nomatch

# Replace yay with paru if installed
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'
