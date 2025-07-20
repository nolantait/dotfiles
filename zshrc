# DOCS: .zshrc sets the environment for interactive shells. .zshrc gets loaded
# after .zprofile. It is a place where you “set and forget” things.
#
# NOTE: Since it’s loaded after .zprofile, in interactive shells, it will
# override anything you set in .zprofile. Like the $PATH variable. It’s a good
# place to define aliases and functions that you would like to have both in
# login and interactive shells.
#
# .zshenv → .zprofile → .zshrc → .zlogin → .zlogout

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# .zshrc Configuration Script

# This is your main Zsh configuration script. It's used to load additional settings
# from various files and directories within the ~/.zsh/configs directory.

# Define a function to load Zsh configuration files.
_load_settings() {
  _dir="$1"

  # Check if the specified directory exists.
  if [ -d "$_dir" ]; then

    # Check for a "pre" directory within the config directory.
    if [ -d "$_dir/pre" ]; then
      # Load configuration files from the "pre" directory, excluding compiled files (zwc).
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    # Load configuration files from the main directory and its subdirectories, excluding specific file types.
    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          # Skip directories named "pre" or "post" and compiled files (zwc).
          :
          ;;
        *)
          # Load other configuration files.
          . $config
          ;;
      esac
    done

    # Check for a "post" directory within the config directory.
    if [ -d "$_dir/post" ]; then
      # Load configuration files from the "post" directory, excluding compiled files (zwc).
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    # Check for a "plugin" directory within the config directory.
    if [ -d "$_dir/plugins" ]; then
      # Load configuration files from the "plugin" directory, excluding compiled files (zwc).
      for plugin in "$_dir"/plugins/**/*~*.zwc(N-.); do
        . $plugin
      done
    fi
  fi
}

# Call the _load_settings function with the path to the main configuration directory.
# In this script, it's set to "$HOME/.zsh/configs."
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.host ]] && source ~/.zshrc.host
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
