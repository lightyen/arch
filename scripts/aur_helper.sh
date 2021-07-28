#!/bin/sh
cd /tmp
git clone https://aur.archlinux.org/$1

if [ -e $1/PKGBUILD ]; then
	chown -R nobody $1
	cd $1
	if sudo -u nobody makepkg; then
	else
		sudo -u nobody makepkg -d
	fi
	target=$(compgen -G "*.pkg.tar.*")
	if [ -z target ]; then
		echo ERROR: Package is not found. 1>&2
		exit 1
	fi
	yes "" | pacman -U --asdeps $target
	cd -
else
	echo ERROR: Not a valid package.
fi
