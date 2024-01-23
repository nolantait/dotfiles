# Global profile
#--------------------
# The global profile may make changes to the PATH,
# so we source it before setting our own PATHs.

[[ -f '/etc/profile' ]] && emulate sh -c '. /etc/profile'
[[ -f '~/.profile'   ]] && emulate sh -c '. ~/.profile'

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:/usr/local/bin:$PATH"

# Try loading ASDF from the regular home dir location
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

# Add foundry to the path
PATH=$HOME/.foundry/bin:$PATH

export -U PATH
