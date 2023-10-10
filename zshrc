## Path section
# Set $PATH if ~/.local/bin exist
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

source ~/.zsh/configs/plugins.zsh
source ~/.zsh/configs/color.zsh
source ~/.zsh/configs/editor.zsh
source ~/.zsh/configs/history.zsh
source ~/.zsh/configs/homebrew.zsh
source ~/.zsh/configs/keybindings.zsh
source ~/.zsh/configs/options.zsh
source ~/.zsh/configs/prompt.zsh
source ~/.zsh/configs/post/completion.zsh
source ~/.zsh/configs/post/path.zsh

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
