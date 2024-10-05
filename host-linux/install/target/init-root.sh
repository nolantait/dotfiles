#!/bin/bash

set -euo pipefail

NEW_USER=$1

echo "#################### Add New User ####################"
useradd -m -g wheel ${NEW_USER}
passwd ${NEW_USER}
usermod -aG storage,video,input ${NEW_USER}

echo "#################### Modify /etc/sudoers File ####################"
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
cp sudoers_custom_configs /etc/sudoers.d/

echo "#################### Configure pacman and makepkg ####################"
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color/Color/" /etc/pacman.conf
grep "^ParallelDownloads" /etc/pacman.conf >/dev/null || sed -i "s/^#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf
# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

# Copy over SSH keys
cp -r /root/.ssh /home/${NEW_USER}/
chown -R $NEW_USER /home/$NEW_USER/.ssh

# Copy over installation scripts
mv /root/target /home/${NEW_USER}/
chown -R $NEW_USER /home/$NEW_USER/target
