if [ -d "$HOME/.config/broot/launcher/bash" ]; then
  # Load broot
  source ~/.config/broot/launcher/bash/br
fi

# Load cargo env if it exists
if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi
