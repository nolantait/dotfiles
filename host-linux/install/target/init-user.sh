#!/bin/bash

$keys_url = "https://github.com/nolantait.keys"
$dotfiles_url = "https://github.com/nolantait/dotfiles"


# Function to handle errors
handle_error() {
    echo "Error on line $1"
    exit 1
}

# Trap errors
trap 'handle_error $LINENO' ERR

log_file="setup_arch.log"
exec > >(tee -i "$log_file") 2>&1

# Ensure system is up to date
sudo pacman -Syu --noconfirm

## Function to check if a package is installed
is_installed() {
    pacman -Q "$1" &>/dev/null
}

## Disable password authentication in SSH config
configure_ssh() {
    if ! grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
        sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
        sudo systemctl restart sshd
        echo "Password authentication disabled."
    else
        echo "SSH password authentication is already disabled."
    fi
}

add_keys() {
  if [ ! -f "$HOME/.ssh/authorized_keys" ]; then
    mkdir -p "$HOME/.ssh"
    curl -sSL "$keys_url" > "$HOME/.ssh/authorized_keys"
    chmod 600 "$HOME/.ssh/authorized_keys"
    echo "SSH keys added."
  else
    echo "SSH keys already added."
  fi
}

## Install zsh and a font
install_zsh() {
    if is_installed zsh && is_installed ttf-iosevka-nerd; then
        echo "zsh and font already installed."
    else
        sudo pacman -S --noconfirm zsh ttf-iosevka-nerd
        chsh -s /usr/bin/zsh "$username"
        echo "zsh and font installed."
    fi
}

## Install rust
install_rust() {
    if ! command -v rustc &>/dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo "Rust installed."
    else
        echo "Rust is already installed."
    fi
}

## Install paru
install_paru() {
    if is_installed paru; then
        echo "paru is already installed."
    else
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        (cd /tmp/paru && makepkg -si --noconfirm)
        echo "paru installed."
    fi
}

## Set XDG directories
configure_xdg() {
    local xdg_conf="/etc/security/pam_env.conf"
    if ! grep -q "XDG_CACHE_HOME" "$xdg_conf"; then
        sudo tee -a "$xdg_conf" <<EOF
XDG_CACHE_HOME    DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME   DEFAULT=@{HOME}/.config
XDG_DATA_HOME     DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME    DEFAULT=@{HOME}/.local/state
EOF
        echo "XDG directories set in pam_env.conf."
    else
        echo "XDG directories are already configured."
    fi

}

## Install dotfiles
install_dotfiles() {
    if [ -d "$HOME/dotfiles" ]; then
        echo "Dotfiles already cloned."
    else
        paru -S --noconfirm rcm bat eza jq fzf delta asdf-vm github-cli
        git clone $dotfiles_url ~/dotfiles
        rm -rf "$HOME"/.{bashrc,zshrc,gitconfig}
        echo "Dotfiles cloned."
    fi

    cd ~/dotfiles
    env RCRC=$HOME/dotfiles/rcrc rcup -B linux
    echo "Dotfiles installed."
}

## Install modern Unix tools
install_modern_tools() {
    tools=(
        htop bottom broot curlie dog duf git-delta dust dysk entr erdtree fd
        gping ouch the_silver_searcher procs tokei tailspin ripgrep sd
    )
    for tool in "${tools[@]}"; do
        if ! is_installed "$tool"; then
            paru -S --noconfirm "$tool"
            echo "$tool installed."
        else
            echo "$tool is already installed."
        fi
    done
}

## Install i3
install_i3() {
    i3_packages=(
        i3-wm i3-scrot xorg-xinit xclip xorg-server startx xset xrandr
        alacritty feh polybar conky rofi dunst
    )
    for pkg in "${i3_packages[@]}"; do
        if ! is_installed "$pkg"; then
            paru -S --noconfirm "$pkg"
            echo "$pkg installed."
        else
            echo "$pkg is already installed."
        fi
    done
}

## Install NVIDIA drivers
install_nvidia() {
    if is_installed nvidia; then
        echo "NVIDIA drivers already installed."
    else
        paru -S --noconfirm nvidia nvidia-utils nvidia-settings
        sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 /' /etc/default/grub
        sudo grub-mkconfig -o /boot/grub/grub.cfg
        sudo sed -i 's/^MODULES=(.*)/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        sudo sed -i 's/\(HOOKS=.*\)kms/\1/' /etc/mkinitcpio.conf
        sudo mkinitcpio -P
        echo "NVIDIA drivers installed and configured."
    fi
}

## Reduce swappiness
reduce_swappiness() {
    swappiness_file="/etc/sysctl.d/90-swappiness.conf"
    if [ -f "$swappiness_file" ]; then
        echo "Swappiness already configured."
    else
        echo "vm.swappiness = 10" | sudo tee "$swappiness_file"
        echo "Swappiness set to 10."
    fi
}

## Install PostgreSQL
install_postgresql() {
    if is_installed postgresql; then
        echo "PostgreSQL is already installed."
    else
        paru -S --noconfirm postgresql postgresql-libs
        sudo passwd postgres
        sudo -u postgres initdb -D /var/lib/postgres/data
        echo "PostgreSQL installed and initialized."
    fi
}

## Install programming languages via asdf
install_programming_languages() {
    if ! command -v asdf &>/dev/null; then
        paru -S --noconfirm asdf-vm unzip libyaml
        asdf plugin add nodejs
        asdf plugin add ruby
        asdf plugin add python
        asdf plugin add lua
        asdf install
        corepack enable
        echo "Programming languages installed."
    else
        echo "asdf and programming languages are already installed."
    fi
}

## Install applications
install_applications() {
    apps=(
      slack-desktop discord vlc firefox
    )
    for app in "${apps[@]}"; do
        if ! is_installed "$app"; then
            paru -S --noconfirm "$app"
            echo "$app installed."
        else
            echo "$app is already installed."
        fi
    done
}

install_docker() {
  if ! command -v docker &>/dev/null; then
      paru -S --noconfirm docker
      sudo systemctl enable docker
      sudo systemctl start docker
      sudo usermod -aG docker "$username"
      newgrp docker
      docker ps -a
      echo "Docker installed."
  fi
}

# Execute all functions in order
add_keys
configure_ssh
install_zsh
install_rust
install_paru
configure_xdg
install_dotfiles
install_modern_tools
install_i3
install_nvidia
reduce_swappiness
install_postgresql
install_programming_languages
install_docker
install_applications

echo "All steps completed successfully."
