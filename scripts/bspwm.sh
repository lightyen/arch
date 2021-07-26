#!/bin/sh

mkdir -p $HOME/.config/sxhkd
mkdir -p $HOME/.config/bspwm
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/sxhkdrc -o $HOME/.config/sxhkd/sxhkdrc
curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/bspwmrc -o $HOME/.config/bspwm/bspwmrc
chmod 644 $HOME/.config/sxhkd/sxhkdrc
chmod 755 $HOME/.config/bspwm/bspwmrc

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.xprofile -o $HOME/.xprofile