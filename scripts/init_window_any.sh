#!/bin/sh

pacman -S sddm-kcm xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller p7zip unzip fcitx-im fcitx-chewing fcitx-configtool plasma

mkdir -p /usr/local/share/fonts

curl -fsSL https://github.com/be5invis/Sarasa-Gothic/releases/download/v0.32.14/sarasa-gothic-ttf-0.32.14.7z -o ./sarasa-gothic-ttf-0.32.14.7z
mkdir -p /usr/local/share/fonts/sarasa
7z x -o/usr/local/share/fonts/sarasa sarasa-gothic-ttf-0.32.14.7z

if curl -fsSL https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKtc-hinted.zip -o NotoSansCJKtc-hinted.zip; then
	unzip NotoSansCJKtc-hinted.zip -d NotoSansCJKtc
	mkdir -p /usr/local/share/fonts/NotoSansCJKtc
	mv NotoSansCJKtc/*.otf /usr/local/share/fonts/NotoSansCJKtc
	rm -rf NotoSansCJKtc NotoSansCJKtc-hinted.zip
fi

if curl -fsSL https://github.com/microsoft/cascadia-code/releases/download/v2106.17/CascadiaCode-2106.17.zip -o CascadiaCode-2106.17.zip; then
	unzip CascadiaCode-2106.17.zip -d CascadiaCode
	mv CascadiaCode/ttf /usr/local/share/fonts/CascadiaCode
	rm -rf CascadiaCode
fi

fc-cache -sf

echo "GTK_IM_MODULE=fcitx" >> /etc/environment
echo "QT_IM_MODULE=fcitx" >> /etc/environment
echo "XMODIFIERS=@im=fcitx" >> /etc/environment

sed -i 's/^Current=$/Current=breeze/' /usr/lib/sddm/sddm.conf.d/default.conf
systemctl enable sddm