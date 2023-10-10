## Downloads and installs antigen hooks
if [[ ! -f $HOME/antigen.zsh ]]; then
  curl -L git.io/antigen > $HOME/antigen.zsh
fi

# Load antigen
source $HOME/antigen.zsh

# Using oh-my-zsh
antigen use oh-my-zsh

# Bundles
antigen bundle colored-man-pages                    # prettier man pages
antigen bundle ssh-agent                            # manage ssh agents
# antigen bundle fzf                                  # fuzzy finder with ag
antigen bundle zsh-users/zsh-autosuggestions        # prefill suggestions
antigen bundle djui/alias-tips                      # teaches you aliases you stole
# antigen bundle command-not-found

# Update the theme if its not already installed
antigen theme nolantait/typewritten

# Commit antigen changes
antigen apply
