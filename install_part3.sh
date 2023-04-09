# set -x
sudo pacman --noconfirm -S xf86-video-amdgpu xorg xorg-xinit webkit2gtk base-devel \
	alsa-utils pulseaudio pavucontrol \
	bluez bluez-utils pulseaudio-bluetooth blueman \
	firefox thunar \
	nitrogen xournalpp discord \
	neofetch ranger git neovim \
	flatpak unzip \
	fuse2 \
	imagemagick


systemctl enable bluetooth.service
systemctl --user enable pulseaudio

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

# Spotify
sudo yay -S ncspot


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

# wallpapers
mkdir -p ~/Pictures/Wallpapers
cd ~/Pictures/Wallpapers
curl https://raw.githubusercontent.com/dxnst/nord-wallpapers/master/operating-systems/archlinux.png > archlinux.png

# fonts
sudo mkdir -p /usr/share/fonts/ttf
curl https://fonts.google.com/download?family=Ubuntu%20Mono > ~/Downloads/UbuntuMono.zip
sudo mv ~/Downloads/UbuntuMono.zip /usr/share/fonts/ttf
cd /usr/share/fonts/ttf
sudo unzip /usr/share/fonts/ttf/UbuntuMono.zip
sudo rm UbuntuMono.zip
sudo rm UFL.txt

# nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# create remove script
cd
touch ~/remove.sh
echo "sudo rm /install_part2.sh" >> ~/remove.sh
echo "cd" >> ~/remove.sh
echo "sudo rm install_part3.sh" >> ~/remove.sh
chmod +x ~/remove.sh

echo "Remember: Install Synergy"
