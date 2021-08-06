#!/bin/sh

set -e

username=$1
password=$2

if useradd -m $username -p $password; then
	echo new user: $username
fi

init_user=$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)
runuser -l $username -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)" -c "ohmyzsh"'
runuser -l $username -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)" -c "vim"'

if pacman -Q xorg-server 1>/dev/null 2>&1; then
	runuser -l $username -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)" -c "window"'
	if dmesg | grep 'Hypervisor detected' 1>/dev/null; then
		runuser -l $username -c "curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/vbox/.xprofile -o $HOME/.xprofile"
	else
		runuser -l $username -c "curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.xprofile -o $HOME/.xprofile"
	fi
fi

chsh --shell $(which zsh) $username
