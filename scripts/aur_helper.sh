#!/bin/sh

cd /tmp
git clone "https://aur.archlinux.org/$1.git" -o $1
chown -R nobody $1
cd $1
sudo -u nobody makepkg 
pacman -U *.pkg.tar.zst
cd -
rm -rf $1
cd -