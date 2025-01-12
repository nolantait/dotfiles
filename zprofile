# DOCS: .zlogin and .zprofile do the same thing. They set the environment for
# login shells. The only difference is they just get loaded at different times.
# This is the place to put user facing env variables
#
# WARN: Apple terminal initially opens both a login and an interactive shell even
# though you don't authenticate (i.e., enter login credentials). That’s why
# .zshrc will always be loaded. However, after the first terminal session, any
# subsequent shells that are opened are only interactive; thus .zprofile will
# not be loaded.

export BROWSER=firefox
export VISUAL=nvim
export EDITOR=nvim
export GOROOT=$HOME/.go
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"default\"'"
export MANROFFOPT="-c"

# As recommended in https://wiki.archlinux.org/title/Zsh
emulate sh -c 'source /etc/profile'

[[ -f ~/.zprofile.host ]] && source ~/.zprofile.host
[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local
