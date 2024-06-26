#!/bin/sh

set -e

username=$1
password=$2

if useradd -m $username; then
	echo new user: $username
fi

init_user=$(curl -fsS https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)
runuser -l $username -c 'sh -c "$(curl -fsS https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)" -c "ohmyzsh"'
runuser -l $username -c 'sh -c "$(curl -fsS https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)" -c "vim"'

if pacman -Q xorg-server 1>/dev/null 2>&1; then
	echo "detect window environment"
	runuser -l $username -c 'sh -c "$(curl -fsS https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)" -c "window"'
	if dmesg | grep 'Hypervisor detected' 1>/dev/null; then
		echo "detect virtual machine"
		runuser -l $username -c "curl -fsS https://raw.githubusercontent.com/lightyen/arch/main/vbox/.xprofile -o ~/.xprofile"
	else
		runuser -l $username -c "curl -fsS https://raw.githubusercontent.com/lightyen/arch/main/.xprofile -o ~/.xprofile"
	fi
fi

chsh --shell $(which zsh) $username

if [[ "$password" ]]; then
	echo -e "$password\n$password" | passwd $username 1>/dev/null
fi
