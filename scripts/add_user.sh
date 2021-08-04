#!/bin/sh

username=$1
password=$2
echo "add $username..."
useradd -m $username
runuser -l $username -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_user.sh)"
chsh --shell $(which zsh) $username
echo -e "$password\n$password" | passwd $username
