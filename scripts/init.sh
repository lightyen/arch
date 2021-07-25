#!/bin/sh

sed -E -i "s/^#(ParallelDownloads.*)/\1/" /etc/pacman.conf
pacstrap -i /mnt base linux linux-firmware base-devel vim sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt