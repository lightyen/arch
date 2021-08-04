#!/bin/sh
cd /tmp
git clone https://aur.archlinux.org/$1

if [ -e $1/PKGBUILD ]; then
	set -e
	chown -R nobody $1
	cd $1
	if ! sudo -u nobody makepkg; then
		sudo -u nobody makepkg -d
	fi
	target=$(compgen -G "*.pkg.tar.*")
	if [ -z target ]; then
		echo ERROR: Package is not found. 1>&2
		exit 1
	fi
	if [ -e $target ]; then
		if ! pacman -U --noconfirm --needed $target; then
			pacman -U --asdeps --noconfirm --needed $target
		fi
	fi
	cd -
else
	echo ERROR: Not a valid package.
fi
