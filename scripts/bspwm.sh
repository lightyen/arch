#!/bin/sh

pacman -S sddm-kcm xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller
mkdir -p ~/.config/sxhkd
mkdir -p ~/.config/bspwm
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sxhkdrc -o ~/.config/sxhkd/sxhkdrc
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/bspwmrc -o ~/.config/bspwm/bspwmrc
chmod 755 ~/.config/sxhkd/sxhkdrc
chmod 644 ~/.config/bspwm/bspwmrc