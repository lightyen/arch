#!/bin/sh

setfacl -m u:sddm:x ~/

if [ -e ~/.face ]; then
	setfacl -m u:sddm:r ~/.face
fi

if [ -e ~/.face.icon ]; then
	setfacl -m u:sddm:r ~/.face.icon
fi
