#!/bin/sh

sed -E -i "s/^#(ParallelDownloads.*)/\1/" /etc/pacman.conf
yes "" | pacstrap -i /mnt base linux linux-firmware base-devel
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt