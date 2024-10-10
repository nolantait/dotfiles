# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1
# enable colored output from ls, etc. on GNU-based systems
export COLORTERM=truecolor
# Set colors for terminal in mac
export LSCOLORS=ExFxBxDxCxegedabagacad

# Activate dircolors
[[ -f ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)"
