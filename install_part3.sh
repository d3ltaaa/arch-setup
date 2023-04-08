# set -x
sudo pacman --noconfirm -S xf86-video-amdgpu xorg xorg-xinit webkit2gtk base-devel \
	alsa-utils pulseaudio pavucontrol \
	bluez bluez-utils pulseaudio-bluetooth blueman \
	firefox thunar \
	nitrogen xournalpp discord \
	neofetch ranger git vim \
	flatpak \
	fuse2

systemctl enable bluetooth.service
systemctl --user enable pulseaudio

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
sudo yay -S ncspot
cd ~/.scripts
touch spotify
echo "st -e ncspot" > spotify

# .setup
cd ~/
git clone https://github.com/d3ltaaa/.setup.git

# setup symlinks
mkdir -p ~/.config
ln -s ~/.setup/config/suckless ~/.config
ln -s ~/.setup/config/neofetch ~/.config

ln -s ~/.setup/system/.dwm ~/
sudo rm -r ~/.scripts
ln -s ~/.setup/system/.scripts ~/
ln -s ~/.setup/system/.xinitrc ~/
rm ~/.bash_profile
ln -s ~/.setup/system/.bash_profile ~/
rm ~/.bashrc
ln -s ~/.setup/system/.bashrc ~/

# building suckless software
cd ~/.config/suckless/dwm
make 
sudo make install
cd ~/.config/suckless/st
make 
sudo make install
cd ~/.config/suckless/dmenu
make 
sudo make install

# create remove script

touch ~/remove.sh
echo "rm /install_part2.sh" >> ~/remove.sh
echo "rm ~/install_part3.sh" >> ~/remove.sh
chmod +x ~/remove.sh

echo "Remember: Install Synergy"
