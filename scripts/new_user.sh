#!/bin/sh

username=$1
useradd -m $username
runuser -l $username -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/user.sh)"
chsh --shell $(which zsh) $username
passwd $username
