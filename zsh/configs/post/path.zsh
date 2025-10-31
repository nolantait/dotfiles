# Global profile
#--------------------
# The global profile may make changes to the PATH,
# so we source it before setting our own PATHs.

[[ -f '/etc/profile' ]] && emulate sh -c '. /etc/profile'
[[ -f '~/.profile' ]] && emulate sh -c '. ~/.profile'

typeset -gxU path PATH

# ensure dotfiles bin directory is loaded first
path=($HOME/.bin /usr/local/sbin /usr/local/bin $path)
# mkdir .git/safe in the root of repositories you trust
path=($HOME/.git/safe/../../bin $path)

# Set $PATH if ~/.local/bin exist
if [ -d "$HOME/.local/bin" ]; then
  path=($HOME/.local/bin $path)
fi

# Load mise if available
if [ -x "$(command -v mise)" ]; then
  eval "$(mise activate zsh)"
fi
