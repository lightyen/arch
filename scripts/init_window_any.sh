#!/bin/sh

yes "" | pacman -S sddm-kcm xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller p7zip unzip plasma
yes "" | pacman -S fcitx5 fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-nord fcitx5-chewing fcitx5-mozc

mkdir -p /usr/local/share/fonts

curl -fsSL https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKtc-hinted.zip -o NotoSansCJKtc-hinted.zip
if [ -e NotoSansCJKtc-hinted.zip ]; then
	unzip NotoSansCJKtc-hinted.zip -d NotoSansCJKtc
	mkdir -p /usr/local/share/fonts/NotoSansCJKtc
	mv NotoSansCJKtc/*.otf /usr/local/share/fonts/NotoSansCJKtc
	chmod 644 /usr/local/share/fonts/NotoSansCJKtc/*.otf
	rm -rf NotoSansCJKtc NotoSansCJKtc-hinted.zip
fi

curl -fsSL https://github.com/microsoft/cascadia-code/releases/download/v2106.17/CascadiaCode-2106.17.zip
if [ -e CascadiaCode-2106.17.zip ]; then
	unzip CascadiaCode-2106.17.zip -d CascadiaCode
	mv CascadiaCode/ttf /usr/local/share/fonts/CascadiaCode
	chmod 644 /usr/local/share/fonts/CascadiaCode/*.ttf
	rm -rf CascadiaCode
fi

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
