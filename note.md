# Files or Directories

- `/etc/fstab`
- `/etc/pacman.d/mirrorlist`
- `/etc/pacman.conf`
- `/boot/loader/loader.conf`
- `/boot/loader/entries/arch.conf`
- `/etc/locale.conf`
- `/etc/locale.gen`
- `/etc/hostname`
- `/etc/hosts`
- `/etc/resolv.conf`
- `/etc/ssh/sshd_config`
- `/etc/NetworkManager/`
- `/etc/environment`
- `/etc/xdg/mimeapps.list`
- `/etc/xdg/picom.conf`
- `/usr/share/fonts/`
- `/usr/local/share/fonts/`
- `/usr/share/doc/`
- `/usr/share/xsessions/`
- `/usr/lib/systemd/system/sddm.service`
- `/usr/lib/sddm/sddm.conf.d/default.conf`

# Downgrade packages

```sh
cd /var/cache/pacman/pkg
# choose previous version
sudo pacman -U linux-6.5.9.arch2-1-x86_64.pkg.tar.zst
```

# DPI

Edit `~/.Xresources`:

```sh
Xft.dpi: 120
```

Edit `~/.xprofile`:

```sh
xsetroot -cursor_name left_ptr && xsetroot -xcf /usr/share/icons/breeze_cursors/cursors/left_ptr 32
```

KDE Settings -> appearance -> Fonts -> Force fonts DPI 120
