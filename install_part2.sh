set -x
pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

# Time
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Language and Keyboard
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# Hostname
echo "HOSTNAME: "
read hostname
echo $hostname > /etc/hostname

echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts

# USER
passwd
echo "USER: "
read user
useradd -m $user
echo "Password for $user: "
passwd $user
usermod -aG wheel,audio,video $user
pacman --noconfirm -S sudo
sed -i 's/^# %wheel ALL=(ALL) ALL$/ %wheel ALL=(ALL) ALL/' /etc/sudoers


pacman -S --noconfirm grub efibootmgr dosfstools os-prober mtools

# EFI
mkdir /boot/EFI
echo "Enter EFI partition (1) (e.g.: /dev/nvme0n1p1): "
read efi_part
mount $efi_part /boot/EFI
# GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader=GRUB --removable
# sed -i 's/quiet/pci=noaer/g' /etc/default/grub
# sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# installing packages
pacman --noconfirm -S networkmanager




# enabling services
systemctl enable NetworkManager


# exit

# umount -R /mnt

# reboot
