#!/bin/sh

echo "setup $USER..."
username=$1
password=$2
useradd -m $username
runuser -l $username -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/user.sh)"
chsh --shell $(which zsh) $username
echo "$password\n$password\n" | passwd $username
