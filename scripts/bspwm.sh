#!/bin/sh

mkdir -p $HOME/.config/alacritty
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/alacritty.yml -o $HOME/.config/alacritty/alacritty.yml

mkdir -p $HOME/.config/sxhkd
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sxhkdrc -o $HOME/.config/sxhkd/sxhkdrc
chmod 644 $HOME/.config/sxhkd/sxhkdrc

mkdir -p $HOME/.config/bspwm
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/bspwmrc -o $HOME/.config/bspwm/bspwmrc
chmod 755 $HOME/.config/bspwm/bspwmrc

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.xprofile -o $HOME/.xprofile