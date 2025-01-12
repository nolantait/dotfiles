# Executed everytime the user opens a new shell with bash

# Checks the window size after each command and, if necessary, updates LINES and COLUMNS values.
shopt -s checkwinsize

# Attempts to save all lines of a multi-line command as a single history entry for easy re-editing.
shopt -s cmdhist

# Enables extended pattern matching features.
shopt -s extglob

# The history list is appended (instead of being overwritten) as defined by the HISTFILE variable.
shopt -s histappend

# Enables history expansion with space (i.e. `!!<space>`).
bind Space:magic-space

# Load our profile for any shared configs between bash and zsh
[[ -r "$HOME/.profile" ]] && . "$HOME/.profile"
