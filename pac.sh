
# base xorg
pacman -S xf86-video-fbdev xorg xorg-xinit webkit2gtk
# wm
pacman -S awesome

# packages - rice
pacman -S nitrogen polybar rofi

# packages - apps
pacman -S firefox alacritty git xournalpp  flatpak

# yay
pacman -S base-devel
exit
mkdir /home/falk/.yay
cd /home/falk/.yay
git clone https://aur.archlinux.org/yay.git
cd /home/falk/.yay/yay
makepkg -si

# packages - rice (yay)
yay -S picom-jonaburg-fix
yay -S font-manager-git

# set up nitrogen
mkdir /home/falk/Pictures/Wallpapers


# set up synergy
# flatpak install synergy_1.14.6-snapshot.88fdd263.flatpak

# set up remnote
mkdir -p ~/Downloads
cd ~/Downloads
curl -L -o Remnote.AppImage https://www.remnote.com/desktop/linux/latest
chmod +x Remnote.AppImage
mkdir -p /opt/Remnote
sudo mv Remnote.AppImage /opt/Remnote
# Create a desktop file for the Remnote app
sudo tee /usr/share/applications/remnote.desktop > /dev/null <<EOF
[Desktop Entry]
Name=Remnote
Comment=Note-taking and spaced repetition software
Exec=/opt/Remnote.AppImage
Icon=remnote
Terminal=false
Type=Application
Categories=Utility;TextEditor;
EOF
# Make the desktop file executable
sudo chmod +x /usr/share/applications/remnote.desktop
# Update your application list
sudo update-desktop-database

# set up awesome
# set up picom
# set up polybar
# set up menu
# set up audio
sudo pacman -S alsa-utils pulseaudio pavucontrol
systemctl --user enable pulseaudio && systemctl --user start pulseaudio

echo 
"[multilib]
Include = /etc/pacman.d/mirrorlist"
/etc/pacman.conf

# set up spotify
# https://github.com/Rigellute/spotify-tui
# https://www.youtube.com/watch?v=TaPWqXFtce8
# 
