pacman -Sy --noconfirm sed
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
pacman -S sudo
sed -i '/%wheel\s\+ALL=(ALL)\s\+ALL/s/^#//' /etc/sudoers


pacman -S --noconfirm grub efibootmgr dosfstools os-prober mtools

# EFI
mkdir /boot/EFI
echo "Enter EFI partition (1) (e.g.: /dev/nvme0n1p1): "
read efi_part
mount $efi_part /mnt/boot/EFI
# GRUB
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# installing packages
pacman --noconfirm -S xf86-video-amdgpu xorg xorg-xinit webkit2gtk base-devel \
	networkmanager \
	alsa-utils pulseaudio pavucontrol \
	bluez bluez-utils pulseaudio-bluetooth blueman \
	firefox thunar \
	nitrogen xournalpp discord \
	neofetch ranger git \
	flatpak \
	fuse2



# enabling services
systemctl enable NetworkManager
systemctl enable bluetooth.service
systemctl --user enable pulseaudio