#!/bin/sh
if [ "yes" == "$(xdg-settings check default-web-browser microsoft-edge-beta.desktop)" ]; then
	xdg-mime query default x-scheme-handler/https
else
	xdg-settings set default-web-browser microsoft-edge-beta.desktop
fi
