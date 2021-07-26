#!/bin/sh

cd /tmp
if git clone "https://aur.archlinux.org/$1.git" -o $1; then
	chown -R nobody $1
	cd $1
	sudo -u nobody makepkg 
	yes "" | pacman -U *.pkg.tar.zst
	cd -
	rm -rf $1
fi
cd -
