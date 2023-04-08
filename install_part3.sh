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

echo "it did go through !!!!!!!!!!!!!!!!!"
