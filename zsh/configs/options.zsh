DIRSTACKSIZE=5
# Show time taken for the command to finish if it takes longer than 6 seconds
REPORTTIME=6
# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars

## Options section
setopt appendhistory        # Immediately append history instead of overwriting
setopt auto_list            # Automatically list choices on ambiguous completion
setopt auto_param_keys      # Intelligently add a space after variable completion
setopt auto_param_slash     # Intelligently add a slash after directory completion
setopt auto_remove_slash    # Remove trailing slash if next char is a word delim
setopt auto_pushd           # cd becomes pushd
setopt autocd               # if only directory path is entered, cd there
setopt bg_nice              # Run background jobs at lower priority
setopt check_jobs           # Warn about suspended jobs on exit
setopt check_running_jobs   # Warn about background jobs on exit
setopt complete_aliases     # Treat aliases as distinct commands
setopt complete_in_word     # Completions happen at the cursor's location
setopt correct              # Auto correct mistakes
setopt extendedglob         # Extended globbing. Allows using regular expressions with *
setopt glob                 # Enable globbing (i.e. the use of the '*' operator).
setopt glob_complete        # Tab completion expands globs.
setopt hash_list_all        # Ensure the command path is hashed before completion.
setopt histignorealldups    # If a new command is a duplicate, remove the older one
setopt mark_dirs            # Mark directories resulting from globs with trailing slashes.
setopt menu_complete        # Automatically highlight first element of completion
setopt nobeep               # No beep
setopt nocaseglob           # Case insensitive globbing
setopt nocheckjobs          # Don't warn about running processes when exiting
setopt numericglobsort      # Sort filenames numerically when it makes sense
setopt pushd_ignore_dups
setopt pushdminus
setopt rcexpandparam        # Array expension with parameters


# Allow [ or ] whereever you want
unsetopt nomatch

# Prevent zsh from sourcing config files from /etc, except /etc/zshenv.
unsetopt global_rcs
