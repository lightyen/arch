#!/bin/sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/window_any.sh)"

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/v/picom.conf -o /etc/xdg/picom.conf