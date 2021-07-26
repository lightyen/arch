#!/bin/sh

pacman -S sddm-kcm xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller

cat /usr/lib/sddm/sddm.conf.d/default.conf


curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/picom.conf -o /etc/xdg/picom.conf

pacman -S fcitx-im fcitx-chewing fcitx-

echo "GTK_IM_MODULE=fcitx" >> /etc/environment
echo "QT_IM_MODULE=fcitx" >> /etc/environment
echo "XMODIFIERS=@im=fcitx" >> /etc/environment

mkdir -p /usr/local/share/fonts
pacman -S p7zip
curl -fsSL https://github.com/be5invis/Sarasa-Gothic/releases/download/v0.32.14/sarasa-gothic-ttf-0.32.14.7z -o ./sarasa-gothic-ttf-0.32.14.7z
mkdir -p /usr/local/share/fonts/ttf
7z x -o/usr/local/share/fonts/ttf/sarasa sarasa-gothic-ttf-0.32.14.7z

curl -fsSL https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKtc-hinted.zip -o NotoSansCJKtc-hinted.zip
unzip NotoSansCJKtc-hinted.zip -d Noto
mkdir -p /usr/share/fonts/otf/NotoSansCJKtc
mv Noto/*.otf /usr/share/fonts/otf/NotoSansCJKtc
rm -rf Noto NotoSansCJKtc-hinted.zip
fc-cache