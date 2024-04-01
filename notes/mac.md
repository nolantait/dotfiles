Mac M3 Pro Setup

Install brew:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Run these two commands in your terminal to add Homebrew to your PATH:

````
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/nolan/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install deps

```
brew install zsh
brew install neovim
brew install rcm
brew install tmux
brew install asdf
brew install htop
brew install rg
brew install fg
brew install bitwarden-cli
brew install ranger
brew install gh
brew install vips

brew install --cask alacritty
brew install --cask firefox

brew install redis
brew services start redis

brew install postgresql@16
brew services start postgresql@16
```

Install fonts

```
brew tap homebrew/cask-fonts
brew install --cask font-iosevka-nerd-font
```

Install programming languages

```
asdf plugin add ruby
asdf install ruby 3.3.0

asdf plugin add python
asdf install python 3.12.2

asdf plugin add nodejs
asdf install nodejs 21.7.1
corepack enable

asdf plugin add lua
asdf install lua 5.4.6
```

Setup workspace and override mac defaults

```
mkdir Workspace
chmod +x ~/.macos
cd ~/ && ./.macos
```

Setup git

```
git clone https://github.com/nolantait/dotfiles.git
gh auth
```
