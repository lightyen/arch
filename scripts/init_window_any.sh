#!/bin/sh

yes "" | pacman -S sddm-kcm xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller p7zip unzip imagemagick plasma
yes "" | pacman -S noto-fonts-cjk noto-fonts-emoji ttf-cascadia-code ttf-sarasa-gothic fcitx5 fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-nord fcitx5-chewing fcitx5-mozc

mkdir -p /usr/local/share/fonts
fc-cache -fv

echo "GTK_IM_MODULE=fcitx" >> /etc/environment
echo "QT_IM_MODULE=fcitx" >> /etc/environment
echo "XMODIFIERS=@im=fcitx" >> /etc/environment
echo "GTK_THEME=Breeze-Dark:dark" >> /etc/environment

sed -i 's/^Current=$/Current=breeze/' /usr/lib/sddm/sddm.conf.d/default.conf
sed -i 's/^Numlock=none/Numlock=on/' /usr/lib/sddm/sddm.conf.d/default.conf
systemctl enable sddm

curl -fsSL "https://raw.githubusercontent.com/lightyen/arch/main/scripts/aur_helper.sh" -o aur_helper
chmod +x aur_helper
./aur_helper microsoft-edge-beta-bin
./aur_helper visual-studio-code-bin
rm -f aur_helper

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/mimeapps.list -o /etc/xdg/mimeapps.list
