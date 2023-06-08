#!/bin/bash

# set -x
echo part-1
loadkeys de-latin1
timedatectl set-ntp true

pacman -Sy

# sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

pacman --noconfirm -S expect
curl https://raw.githubusercontent.com/d3ltaaa/arch-setup/main/partition_disk.exp > partition_disk.exp
fdisk -l
chmod +x partition_disk.exp
./partition_disk.exp
rm partition_disk.exp


read -p "Which disk would you like to partition?: " disk_to_partition
read -p "What is the EFI partition called?: " efi_partition
read -p "What is the SWAP partition called?: " swap_partition
read -p "What is the LINUX FILE SYSTEM partition called?: " fs_partition
read -p "What size should the EFI partition be?: " size_of_efi
read -p "What size should the swap partition be?: " size_of_swap

parted -s $disk_to_partition mklabel gpt
parted -s $disk_to_partition mkpart primary fat32 1MiB ${size_of_efi}GiB 
parted -s $disk_to_partition set 1 esp on
parted -s $disk_to_partition mkpart primary linux-swap ${size_of_efi}GiB $((size_of_efi + size_of_swap))GiB
parted -s $disk_to_partition mkpart primary ext4 $((size_of_efi + size_of_swap))GiB 100%

# Format partitions
mkfs.fat -F32 $efi_partition
mkswap $swap_partition
mkfs.ext4 $fs_partition

# Mount partitions
mkdir -p /mnt/boot/EFI
mount $efi_partition /mnt/boot/EFI
swapon $swap_partition
mount $fs_partition /mnt

# misscellaneous
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/d3ltaaa/arch-setup/main/install_part2.sh > /mnt/install_part2.sh && chmod +x /mnt/install_part2.sh

arch-chroot /mnt
