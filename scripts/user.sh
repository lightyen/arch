#!/bin/sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/user_any.sh)"

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.xprofile -o $HOME/.xprofile