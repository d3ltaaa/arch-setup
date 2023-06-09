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


echo "Enter the EFI partition (1) (e.g.: /dev/nvme0n1p1): "
read efi_part
echo "Enter the SWAP partition (2) (e.g.: /dev/nvme0n1p2): "
read swap_part
echo "Enter the LINUX partition (3) (e.g.: /dev/nvme0n1p3): "
read linux_part

mkfs.fat -F32 $efi_part
mkswap $swap_part
swapon $swap_part
mkfs.ext4 $linux_part
mount $linux_part /mnt
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

curl https://raw.githubusercontent.com/d3ltaaa/arch-setup/main/install_part2.sh > /mnt/install_part2.sh && chmod +x /mnt/install_part2.sh

arch-chroot /mnt
