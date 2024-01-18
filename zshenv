# DOCS: This is read first and read every time, regardless of the shell being
# login, interactive, or none. This is the recommended place to set environment
# variables needed on every shell, even the ones launching scripts
#
# NOTE: Why would you need this? Because, for example, if you have a script that
# gets called by launchd, it will run under non-interactive non-login shell, so
# neither .zshrc nor .zprofile will get loaded.
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout

# Set $PATH if ~/.local/bin exist
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

local _old_path="$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

if [[ $PATH != $_old_path ]]; then
  # `colors` isn't initialized yet, so define a few manually
  typeset -AHg fg fg_bold
  if [ -t 2 ]; then
    fg[red]=$'\e[31m'
    fg_bold[white]=$'\e[1;37m'
    reset_color=$'\e[m'
  else
    fg[red]=""
    fg_bold[white]=""
    reset_color=""
  fi

  cat <<MSG >&2
${fg[red]}Warning:${reset_color} your \`~/.zshenv.local' configuration seems to edit PATH entries.
Please move that configuration to \`.zshrc.local' like so:
  ${fg_bold[white]}cat ~/.zshenv.local >> ~/.zshrc.local && rm ~/.zshenv.local${reset_color}

(called from ${(%):-%N:%i})

MSG
fi

unset _old_path

export PATH=$HOME/.foundry/bin:$PATH
