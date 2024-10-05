#!/bin/bash

set -euo pipefail

# check if boot type is UEFI
ls /sys/firmware/efi/efivars || { echo "Boot Type Is Not UEFI!; "exit 1; }

# check if internet connection exists
ping -q -c 1 archlinux.org >/dev/null || { echo "No Internet Connection!; "exit 1; }

# Set font for HiDPI screens
setfont ter-132b

# update system clock
timedatectl set-ntp true

# read the block device path you want to install Arch on
echo -n "Enter the block device path you want to install Arch on: "
read -r BLOCK_DEVICE

# ask if the user wants default partitioning or wants to do partitioning manually with cfdisk?
echo -n "Do you want to do partitioning manually with cfdisk? [y/N]: "
read -r PARTITIONING

# if the user wants to create [one] LUKS partition manually with cfdisk (in case there are already other OS's installed)
if [ "${PARTITIONING}" == "y" ]; then
    # partition the block device with cfdisk
    cfdisk "${BLOCK_DEVICE}"
else
    # make a 550 MB EFI partition along with a 170GB LUKS partition, leave the rest of the space unallocated
    sgdisk --clear -n 1:0:+550M -t 1:ef00 -n 2:0:+170G -t 2:8e00 "${BLOCK_DEVICE}"
    sgdisk --clear --new=1:0:+1G --typecode=1:ef00 --new=2:0:+4G --typecode=2:8200 --new=3:0:0 --typecode=3:8300

    # format EFI partition
    mkfs.fat -F32 "${BLOCK_DEVICE}p1"
    # make the swap
    mkswap "${BLOCK_DEVICE}p2"
    # format root partition with ext4 filesystem
    mkfs.ext4 "${BLOCK_DEVICE}p3"
fi

# show partitions
lsblk

# mount the root partition
mount "${BLOCK_DEVICE}p3" /mnt

# create boot directory
mkdir -p /mnt/boot

# mount the EFI partiton
mount "${BLOCK_DEVICE}p1" /mnt/boot

# activate the swap
swapon "${BLOCK_DEVICE}p2"

# show the mounted partitions
lsblk

# install necessary packages
pacstrap -K /mnt base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware lvm2 vim git networkmanager refind os-prober efibootmgr iwd intel-ucode

# Generate an fstab config
genfstab -U /mnt >>/mnt/etc/fstab

# copy chroot-script.sh to /mnt
cp chroot-script.sh /mnt

# chroot into the new system and run the chroot-script.sh script
arch-chroot /mnt ./chroot-script.sh

# unmount partitions
umount /mnt/home
umount /mnt/boot
umount /mnt
