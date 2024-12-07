# DOCS: This is read first and read every time, regardless of the shell being
# login, interactive, or none. This is the recommended place to set environment
# variables needed on every shell, even the ones launching scripts
#
# NOTE: Why would you need this? Because, for example, if you have a script that
# gets called by launchd, it will run under non-interactive non-login shell, so
# neither .zshrc nor .zprofile will get loaded.
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout

export BROWSER=firefox
export VISUAL=nvim
export EDITOR=nvim
export GOROOT=$HOME/.go
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"default\"'"
export MANROFFOPT="-c"
export CLIPPY_CONF_DIR=$HOME/.config/clippy
export DOCKER_BUILDKIT=1

typeset -U path

# Set $PATH if ~/.local/bin exist
if [ -d "$HOME/.local/bin" ]; then
    path=($HOME/.local/bin $path)
fi

# Load cargo env if it exists
if [ -d "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
fi

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
