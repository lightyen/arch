#!/bin/sh
# sudo pacman -S sddm-kcm xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller

mkdir -p ~/.config/sxhkd
mkdir -p ~/.config/bspwm
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sxhkdrc -o ~/.config/sxhkd/sxhkdrc
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/bspwmrc -o ~/.config/bspwm/bspwmrc
chmod 644 ~/.config/sxhkd/sxhkdrc
chmod 755 ~/.config/bspwm/bspwmrc