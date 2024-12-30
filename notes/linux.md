# Setting up a new Arch Linux machine

These are some notes about my latest arch install.

## Format disks

Format disks with a boot/root/swap split using `fdisk`, use `gdisk` if you
   need to set EFI permissions from an existing drive.

Wipe any old stuff from the target:

```
sgdisk --zap-all /dev/sdb
```

For example for BIOS/GPT:

```
sgdisk --new=1:0:+1G --typecode=1:ef00 --new=2:0:+4G --typecode=2:8200 --new=3:0:0 --typecode=3:8300 /dev/sdb
```

## Mount the drives

```
mkfs.ext4 /dev/sdb3
mkswap /dev/sdb2
```

Then we can mount the drives and toggle the swap

```
mount /dev/sdb3 /mnt
swapon /dev/sdb2
```

Pacstrap that shit

```
pacstrap -K /mnt base linux linux-firmware networkmanager man-db man-pages vim intel-ucode grub
```

Generate fstab to connect the drives on reboot automatically

```
genfstab -U /mnt >> /mnt/etc/fstab
```

Chroot to the mounted arch install

```
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/america/vancouver /etc/localtime
```

Edit /etc/locale.gen and uncomment en_US.UTF-8 UTF-8 and other needed UTF-8 locales. Generate the locales by running:
```
locale-gen
```

Create `locale.conf` file

```
# /etc/locale.conf

LANG=en_US.UTF-8
```

Set root password:

```
passwd
```

Install `grub` and `grub-install` the boot directory.

```
grub-install --target=i386-pc /dev/sdb
grub-mkconfig -o /boot/grub/grub.cfg
```

Exit and reboot

```
exit
umount /mnt
reboot
```

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
paru -S rcm bat eza jq fzf delta mise github-cli
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

## Install desktop environment

```
paru -S i3-wm i3-scrot xorg-xinit xclip xorg-server xorg-xset \
              xorg-xrandr alacritty feh polybar conky rofi dunst autocutsel
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
systemctl enable --now postgresql
```

## Install VIPS

Needed as a dependency for Rails

```
paru -S vips
paru -S --asdeps openslide poppler-glib libheif
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
paru -S slack-desktop discord vlc firefox-developer-edition
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

# Install docker

```
paru -S docker
sudo usermod -aG docker $USER
newgrp docker
docker ps -a
paru -S docker-buildx
```

# Troubleshooting

## Time

Install `ntp` and run `ntpd -qg` after setting the timezone. Then sync that
value to the hwclock with `hwclock --systohc`.
