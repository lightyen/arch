#!/bin/sh

pacman -S --noconfirm --needed xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller spectacle p7zip unzip imagemagick plasma
pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-cascadia-code ttf-sarasa-gothic fcitx5 fcitx5-configtool fcitx5-qt fcitx5-gtk fcitx5-nord fcitx5-chewing fcitx5-mozc

mkdir -p /usr/local/share/fonts
fc-cache -fv

if [ -z $(printenv | grep GTK_IM_MODULE) ]; then
	echo "GTK_IM_MODULE=fcitx" >>/etc/environment
fi

if [ -z $(printenv | grep QT_IM_MODULE) ]; then
	echo "QT_IM_MODULE=fcitx" >>/etc/environment
fi

if [ -z $(printenv | grep XMODIFIERS) ]; then
	echo "XMODIFIERS=@im=fcitx" >>/etc/environment
fi

if [ -z $(printenv | grep GTK_THEME) ]; then
	echo "GTK_THEME=Breeze-Dark:dark" >>/etc/environment
fi

sed -i 's/^Current=$/Current=breeze/' /usr/lib/sddm/sddm.conf.d/default.conf
sed -i 's/^Numlock=none/Numlock=on/' /usr/lib/sddm/sddm.conf.d/default.conf
systemctl enable sddm

curl -fsSL "https://raw.githubusercontent.com/lightyen/arch/main/scripts/aur_helper.sh" -o aur_helper
chmod +x aur_helper
./aur_helper microsoft-edge-beta-bin
./aur_helper visual-studio-code-bin
rm -f aur_helper

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/mimeapps.list -o /etc/xdg/mimeapps.list
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sddm.service -o /usr/lib/systemd/system/sddm.service

isVirtual=$(dmesg | grep 'Hypervisor detected')
if [[ $isVirtual ]]; then
	curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/vbox/picom.conf -o /etc/xdg/picom.conf
else
	curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/picom.conf -o /etc/xdg/picom.conf
fi
