#!/bin/sh

pacstrap -i /mnt base linux linux-firmware base-devel vim sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt