#!/bin/sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init_window_any.sh)"

curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/picom.conf -o /etc/xdg/picom.conf
