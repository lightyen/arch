#!/bin/sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/user_any.sh) $1"

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/v/.xprofile -o $HOME/.xprofile