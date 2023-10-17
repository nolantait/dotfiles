# If antidote is not installed, install it
#
antidote_folder=$HOME/.antidote

if [ ! -d "$antidote_folder" ]; then
  echo "Antidote not found, installing it..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git $antidote_folder
fi

# source antidote
source $antidote_folder/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load
