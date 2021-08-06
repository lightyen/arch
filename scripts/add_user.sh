#!/bin/sh

set -e

username=$1
password=$2

useradd -m $username

init_user=$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)
runuser -l $username -c "$init_user ohmyzsh"
runuser -l $username -c "$init_user vim"

if pacman -Q xorg-server 1>/dev/null 2>&1; then
	runuser -l $username -c "$init_user window"
	if dmesg | grep 'Hypervisor detected' 1>/dev/null; then
		runuser -l $username -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/vbox/.xprofile -o $HOME/.xprofile)"
	else
		runuser -l $username -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.xprofile -o $HOME/.xprofile)"
	fi
fi

chsh --shell $(which zsh) $username

echo -e "$password\n$password" | passwd $username 1>/dev/null
