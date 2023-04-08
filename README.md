# arch-setup

loadkeys de-latin1
curl https://raw.githubusercontent.com/d3ltaaa/arch-setup/main/install_part1.sh > install_part1.sh && chmod +x install_part1.sh
./install_part1.sh

./install_part2.sh

exit
umount -R /mnt
reboot
# pull out disk

./install_part3.sh

reboot

./remove.sh
