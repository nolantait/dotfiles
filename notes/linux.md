# Setting up a new Arch Linux machine

These are some notes about my latest arch install.

## Format disks

Format disks with a boot/root/swap split using `fdisk`, use `gdisk` if you
   need to set EFI permissions from an existing drive.

## Mount the drives

Mount the drives and format the root for `mkfs.ext4 /mnt`. Install `grub` and
`grub-install` the boot directory. Then reboot.

## Setup password

Sign in, change password with `passwd`. Install `sudo` and edit `/etc/sudoers` to enable `wheel`

## Setup SSH

Install `openssh`. Start the service `systemctl sshd.servivce`. Add keys to the
root.

```
mkdir -p ~/.ssh && curl https://github.com/nolantait.keys > ~/.ssh/authorized_keys
```

## Setup networking

Install `networkmanager` and start `NetworkManager.service` then configure
`/etc/hosts`:

```
hostname=homelab

hostnamectl hosstname $hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1  localhost" >> /etc/hosts
echo "127.0.1.1 ${hostname}.local ${hostname}" >> /etc/hosts
```

Then start and enable the `systemd-resolved.service`

## Manage users

Add user, set group to `wheel`. Edit `/etc/ssh_config` to disable password,
only public key authorization.

## Install `zsh` and a font

```
sudo pacman -S zsh ttf-iosevka-nerd
chsh -s /usr/bin/zsh
```

## Install rust

Use `rustup`

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install `paru`

```
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru && makepkg -si
```

## Explicitly set XDG

Open up `/etc/security/pam_env.conf`

```
XDG_CACHE_HOME    DEFAULT=@{HOME}/.cache
XDG_CONFIG_HOME   DEFAULT=@{HOME}/.config
XDG_DATA_HOME     DEFAULT=@{HOME}/.local/share
XDG_STATE_HOME    DEFAULT=@{HOME}/.local/state
```

Why there? Most display managers cause the commands in `/etc/profile` (and thus
files in `/etc/profile.d`) to be run for graphical logins too. However, not all
do, and that's a significant argument in favor of using the facilities provided
by PAM instead

## Install dotfiles

First, remove any remaining original configs in the home folder.

Then install `rcm`, clone dotfiles:

```
paru -S rcm bat eza jq fzf delta asdf-vm github-cli
git clone https://github.com/nolantait/dotfiles ~/dotfiles
cd ~/dotfiles
env RCRC=$HOME/dotfiles/rcrc rcup -B linux
```

## Install modern unix tools
```
paru -S \
  htop bottom broot curlie dog duf git-delta dust dysk entr erdtree fd gping \
  hyperfine jqp jnv ouch the_silver_searcher procs tokei tailspin ripgrep \
  sd viddy
```

## Install i3

```
paru -S i3-wm xorg-xinit xclip xorg-server startx xset xrandr \
        alacritty feh polybar conky rofi dunst
```

## Install NVIDIA drivers

First we install the drivers
```
paru -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils
```

Then we enable the modeset with our boot loader:
```
## /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1"
```

Then save the file and recreate the config:
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Then navigate to our `/etc/mkinitcpio.conf` and change the modules to include
the NVIDIA ones:
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

Also remove `kms` from `HOOKS`. Then reinit the initramfs `sudo mkinitcpio -P`

## Setup Xorg

```
paru -S xorg-xinit xorg-server startx xrandr
```

## Reduce swapiness 

Open `/etc/sysctl.d/90-swappiness.conf`

```
vm.swappiness = 10
```

## Install sound stuff

Ensure services are running under `--user` namespace

```
paru -S pipewire pipewire-pulse pavucontrol wireplumber pipewire-jack \
        headsetcontrol rtkit
systemctl --user status pipewire pipewire-pulse pipewire-jack wireplumber
```

## Install postgresql

The install creates a `postgres` user who owns the `/var/lib/postgres` folder.

```
paru -S postgresql postgresql-libs
sudo passwd postgres
su - postgres
initdb -D /var/lib/postgres/data
exit
```

## Install programming languages

```
paru -S unzip libyaml

asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add python
asdf plugin add lua

asdf install

corepack enable
yarn set version stable
```

## Install applications

```
paru -S slack-desktop discord
```

## Setup gaming

```
paru -S wine-staging

paru -S --needed --asdeps giflib lib32-giflib gnutls lib32-gnutls v4l-utils lib32-v4l-utils libpulse \
lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib sqlite lib32-sqlite libxcomposite \
lib32-libxcomposite ocl-icd lib32-ocl-icd libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs \
lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader sdl2 lib32-sdl2

paru -S steam

paru -S lutris
```

# Troubleshooting

## Time

Install `ntp` and run `ntpd -qg` after setting the timezone. Then sync that
value to the hwclock with `hwclock --systohc`.
