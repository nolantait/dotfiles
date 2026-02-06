# DOCS: This is read first and read every time, regardless of the shell being
# login, interactive, or none. This is the recommended place to set environment
# variables needed on every shell, even the ones launching scripts
#
# NOTE: Why would you need this? Because, for example, if you have a script that
# gets called by launchd, it will run under non-interactive non-login shell, so
# neither .zshrc nor .zprofile will get loaded.
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout

export CLIPPY_CONF_DIR=$HOME/.config/clippy
export DOCKER_BUILDKIT=1
export RUBYOPT="-W:deprecated -W:performance --yjit --enable-frozen-string-literal --debug-frozen-string-literal"
export TIMEFMT="%U user %S system %P cpu %*E total, running %J"

# Local config
[[ -f "$HOME/.zshenv.host" ]] && source "$HOME/.zshenv.host"
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"
