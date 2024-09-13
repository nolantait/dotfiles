# Global profile
#--------------------
# The global profile may make changes to the PATH,
# so we source it before setting our own PATHs.

[[ -f '/etc/profile' ]] && emulate sh -c '. /etc/profile'
[[ -f '~/.profile'   ]] && emulate sh -c '. ~/.profile'

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:/usr/local/bin:$PATH"
# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH
