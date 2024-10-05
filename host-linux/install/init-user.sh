#!/bin/bash

# Function to handle errors
handle_error() {
    echo "Error on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

$keys_url = "https://github.com/nolantait.keys"
$dotfiles_url = "https://github.com/nolantait/dotfiles"

# Update system
sudo pacman -Syu

# Install base packages
sudo pacman -S --noconfirm base-devel git curl zsh
chsh -s /usr/bin/zsh "$USER"

# Download keys
mkdir -p ~/.ssh && curl $keys_url > ~/.ssh/authorized_keys
systemctl enable sshd.service

# Edit `/etc/ssh/sshd_config` to disable password authentication
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

## Install a font
sudo pacman -S --noconfirm ttf-iosevka-nerd

## Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Install `paru`
sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru && makepkg -si --noconfirm
cd ~ && rm -rf /tmp/paru

## Explicitly set XDG
sudo tee -a /etc/security/pam_env.conf <<EOF
XDG_CACHE_HOME    DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME   DEFAULT=@{HOME}/.config
XDG_DATA_HOME     DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME    DEFAULT=@{HOME}/.local/state
EOF

## Install dotfiles
# Remove any remaining original configs in the home folder
rm -rf "$HOME"/.{bashrc,zshrc,gitconfig}

# Install `rcm` and dotfile dependencies
paru -S --noconfirm rcm bat eza jq fzf delta asdf-vm github-cli

## Install modern unix tools
paru -S --noconfirm \
  htop bottom broot curlie dog duf git-delta dust dysk entr erdtree fd gping \
  ouch the_silver_searcher procs tokei tailspin ripgrep sd

## Setup Xorg
paru -S --noconfirm xorg-server startx xrandr xorg-xinit xclip startx \
  xset xrandr

## Install i3
paru -S --noconfirm i3-wm i3-scrot \
        alacritty feh polybar conky rofi dunst neovim

## Install NVIDIA drivers
paru -S --noconfirm nvidia nvidia-utils nvidia-settings

# Enable the modeset with GRUB
sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 /' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Change modules in mkinitcpio.conf
sudo sed -i 's/^MODULES=(.*)/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo sed -i 's/\(HOOKS=.*\)kms/\1/' /etc/mkinitcpio.conf
sudo mkinitcpio -P

## Reduce swapiness
sudo tee /etc/sysctl.d/90-swappiness.conf <<EOF
vm.swappiness = 10
EOF

# Clone dotfiles
if [ -d "$HOME/dotfiles" ]; then
  git clone $dotfiles_url $HOME/dotfiles
fi
cd ~/dotfiles
env RCRC=$HOME/dotfiles/rcrc rcup -B linux

## Install sound stuff
paru -S --noconfirm pipewire pipewire-pulse pavucontrol wireplumber pipewire-jack \
        headsetcontrol rtkit
systemctl --user status pipewire pipewire-pulse pipewire-jack wireplumber

## Install PostgreSQL
paru -S --noconfirm postgresql postgresql-libs
sudo passwd postgres
sudo -u postgres initdb -D /var/lib/postgres/data

## Install programming languages
paru -S --noconfirm unzip libyaml
asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add python
asdf plugin add lua
asdf install

corepack enable

## Install applications
paru -S --noconfirm slack-desktop discord vlc

echo "Installation and configuration completed!"
