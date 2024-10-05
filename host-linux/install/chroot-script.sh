#!/bin/bash

set -euo pipefail

# set settings related to locale
sed -i -e 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# set the time zone
echo -n "Enter Time Zone: "
read -r TIME_ZONE
ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
hwclock --systohc

# set hostname
echo -n "Enter hostname: "
read -r HOSTNAME
echo "${HOSTNAME}" >/etc/hostname

# configure hosts file
cat <<EOF >>/etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    ${HOSTNAME}

192.168.1.71 proxmox.homelab.local

192.168.1.150 traefik.homelab.local
192.168.1.150 adguard.homelab.local
192.168.1.150 jellyfin.homelab.local
192.168.1.150 prowlarr.homelab.local
192.168.1.150 radarr.homelab.local
192.168.1.150 sonarr.homelab.local
192.168.1.150 transmission.homelab.local
192.168.1.150 jellyseer.homelab.local
192.168.1.150 bazarr.homelab.local
192.168.1.150 nzbget.homelab.local
EOF

# set root user password
passwd

# generate initramfs for linux and linux-lts
mkinitcpio -p linux

# Install boot manager
bootctl install

# Add pacman hook
cat <<EOF >>/etc/pacman.d/hooks/95-systemd-boot.hook
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Gracefully upgrading systemd-boot...
When = PostTransaction
Exec = /usr/bin/systemctl restart systemd-boot-update.service
EOF

# enable NetworkManager systemd service
systemctl enable NetworkManager
