
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
