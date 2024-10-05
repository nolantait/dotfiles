#!/bin/bash

set -euo pipefail

# Check if boot type is UEFI
ls /sys/firmware/efi/efivars || { echo "Boot Type Is Not UEFI!; "exit 1; }

# Check if internet connection exists
ping -q -c 1 archlinux.org >/dev/null || { echo "No Internet Connection!; "exit 1; }

# Set font for HiDPI screens
setfont ter-132b

# Update system clock
timedatectl set-ntp true

# Read the block device path you want to install Arch on
echo -n "Enter the block device path you want to install Arch on: "
read -r BLOCK_DEVICE

# Ask if the user wants default partitioning or wants to do partitioning manually with cfdisk?
echo -n "Do you want to do partitioning manually with cfdisk? [y/N]: "
read -r PARTITIONING

# If the user wants to create a partition manually with cfdisk (in case there are already other OS's installed)
if [ "${PARTITIONING}" = "y" ]; then
    # partition the block device with cfdisk
    cfdisk "${BLOCK_DEVICE}"
else
    sudo sgdisk --zap-all "${BLOCK_DEVICE}"
    # Make a standard arch partition:
    # 1. EFI partition: 1GB
    # 2. Swap partition: 4GB
    # 3. Root partition: remaining space
    # Clear and create partitions
    sgdisk --new=1:0:+1G --typecode=1:ef00 "${BLOCK_DEVICE}"
    sgdisk --new=2:0:+4G --typecode=2:8200 "${BLOCK_DEVICE}"
    sgdisk --new=3:0:0 --typecode=3:8300 "${BLOCK_DEVICE}"
    sgdisk --change-name=1:EFI --change-name=2:SWAP --change-name=3:ROOT "${BLOCK_DEVICE}"
    sgdisk --print "${BLOCK_DEVICE}"

    # format EFI partition
    mkfs.fat -F32 "${BLOCK_DEVICE}p1"
    # make the swap
    mkswap "${BLOCK_DEVICE}p2"
    # format root partition with ext4 filesystem
    mkfs.ext4 "${BLOCK_DEVICE}p3"
fi

# Show partitions
lsblk

sleep 5

# Mount the root partition
mount "${BLOCK_DEVICE}p3" /mnt

# Create boot directory
mkdir -p /mnt/boot

# Mount the EFI partiton
mount "${BLOCK_DEVICE}p1" /mnt/boot

# Activate the swap
swapon "${BLOCK_DEVICE}p2"

# Show the mounted partitions
lsblk

# Install necessary packages
pacstrap -K /mnt base base-devel linux linux-headers linux-firmware vim git networkmanager efibootmgr intel-ucode

# Generate an fstab config
genfstab -U /mnt >>/mnt/etc/fstab

# Copy chroot-script.sh to /mnt
cp chroot-script.sh /mnt

# Copy ssh keys to /mnt
cp -r ~/.ssh /mnt/root

# Copy over installation scripts
cp -r /root/target /mnt/root

# chroot into the new system and run the chroot-script.sh script passing in the
# BLOCK_DEVICE
arch-chroot /mnt ./chroot-script.sh "${BLOCK_DEVICE}"

# unmount partitions
umount /mnt/boot
umount /mnt
