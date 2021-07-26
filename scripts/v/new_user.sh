#!/bin/sh

username=$1
useradd -m $username
su $username
sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/v/user.sh)"
exit
chsh --shell $(which zsh) $username
passwd $username