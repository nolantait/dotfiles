# Setting up a new Arch Linux machine

1. Format disks with a boot/root/swap split using `fdisk`, use `gdisk` if you
   need to set EFI permissions from an existing drive.
2. Mount the drives and format the root for `mkfs.ext4 /mnt`. Install `grub` and
   `grub-install` the boot directory. Then reboot.
2. Sign in, change password with `passwd`. Install `sudo` and edit `/etc/sudoers` to enable `wheel`
3. Install `openssh`. Start the service `systemctl sshd.servivce`. Add keys to the root `mkdir -p ~/.ssh && curl https://github.com/nolantait.keys > ~/.ssh/authorized_keys`
4. Install `networkmanager` and start `NetworkManager.service` then configure:
```
hostname=homelab

echo "${hostname}" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1  localhost" >> /etc/hosts
echo "127.0.1.1 ${hostname}.local ${hostname}" >> /etc/hosts
```

6. Add user, set group to `wheel`. Edit `/etc/ssh_config` to disable password,
   only public key authorization.

7. Install `zsh` and a font
```
sudo pacman -S zsh ttf-iosevka-nerd
chsh -s /usr/bin/zsh
```

8. Install `rustup` to make primary Rust toolchain link up with development
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

8. Install `paru`
```
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru && makepkg -si
```

9. Explicitly set XDG folders in `/etc/security/pam_env.conf`
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

10. First, remove any remaining original configs in the home folder. Then install
   `rcm`, clone dotfiles
```
paru -S rcm bat eza jq fzf delta asdf-vm github-cli
git clone https://github.com/nolantait/dotfiles ~/dotfiles
cd ~/dotfiles
env RCRC=$HOME/dotfiles/rcrc rcup -B linux
```

11. Install modern unix tools
```
paru -S \
  htop bottom broot curlie dog duf git-delta dust dysk entr erdtree fd gping \
  hyperfine jqp jnv ouch the_silver_searcher procs tokei tailspin ripgrep \
  sd viddy
```

12. Install i3
```
paru -S i3-wm xorg-xinit xorg-server startx xset xrandr \
        alacritty feh polybar conky rofi dunst
```

13. Install NVIDIA drivers

First we install the drivers
```
paru -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils
```

Then we enable the modeset with our boot loader:
```
# /etc/default/grub
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

14. Setup Xorg

```
paru -S xorg-xinit xorg-server startx xrandr
```

15. Reduce swapiness by opening `/etc/sysctl.d/90-swappiness.conf`
```
vm.swappiness = 10
```

16. Install sound stuff and ensure services are running under --user namespace
```
paru -S pipewire pipewire-pulse pavucontrol wireplumber pipewire-jack \
        headsetcontrol rtkit
systemctl --user status pipewire pipewire-pulse pipewire-jack wireplumber
```
