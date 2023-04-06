#############################
# == Arch-install-script == #
#############################
# 06.04.23
# Version 1
# EFI/SWAP/HOME

echo delta_arch_install_script
sleep 1

########## Part 1 ###########
# Partitioning

loadkeys de-latin1

# enabling parallel downloads
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

timedatectl set-ntp true

# display drives
fdisk -l

# installing except
pacman --noconfirm --Sy expect

curl https://raw.githubusercontent.com/d3ltaaa/arch-setup/main/partition_disk.exp > partition_disk.exp
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

sed '1,/^/########## Part 2 ###########$/d' `basename $0` > /mnt/delta_arch_install2.sh
chmod +x /mnt/delta_arch_install2.sh
arch-chroot /mnt ./delta_arch_install2.sh
exit


########## Part 2 ###########
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
pacman -S sudo
sed -i '/%wheel\s\+ALL=(ALL)\s\+ALL/s/^#//' /etc/sudoers


pacman -S grub efibootmgr dosfstools os-prober mtools

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

# creating script of part 3
part3_path=/home/$username/delta_arch_install3.sh
sed '1,/^########### Part 3 ##########$/d' arch_install2.sh > $part3_path
chown $username:$username $part3_path
chmod +x $part3_path
su -c $part3_path -s /bin/sh $username

exit

########### Part 3 ##########

# creating direcotries
mkdir ~/.scripts
mkdir ~/.yay

# yay
cd ~/.yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


# Download remnote appimage and rename it
curl -L -o remnote https://www.remnote.com/desktop/linux
chmod +x remnote
sudo mv remnote /opt
cd ~/.scripts
touch remnote
echo "/opt/./remnote" > remnote

# Spotify
yay -S ncspot
cd ~/.scripts
touch spotify
echo "st -e ncspot" > spotify




