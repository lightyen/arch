#!/bin/sh

# curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/install.sh | sh -

set -e

init_root() {
	dev=$(lsblk -o path,partlabel | grep root | awk '{print $1}')
	if [ -z $dev ]; then
		echo "Error: partition is not found, please set the name 'root' on the specific partition."
		return 1
	fi

	if [ -z "$(blkid -s TYPE -o value $dev)" ]; then
		mkfs.ext4 $dev
	fi

	if [ -z "$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')" ]; then
		mount $dev /mnt
	fi
}

init_boot() {
	dev=$(lsblk -o path,partlabel | grep boot | awk '{print $1}')
	if [ -z $dev ]; then
		echo "Error: partition is not found, please set the name 'boot' on the EFI partition."
		return 1
	fi

	if [ -z "$(blkid -s TYPE -o value $dev)" ]; then
		echo "mkfs.fat $dev"
		mkfs.fat $dev
	fi

	if [ -z "$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')" ]; then
		if mkdir /mnt/boot; then
			mount $dev /mnt/boot
		fi
	fi
}

init_home() {
	dev=$(lsblk -o path,partlabel | grep home | awk '{print $1}')
	if [ -z $dev ]; then
		return
	fi

	if [ -z "$(blkid -s TYPE -o value $dev)" ]; then
		mkfs.ext4 $dev
	fi

	if [ -z "$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')" ]; then
		mkdir /mnt/home
		mount $dev /mnt/home
	fi
}

others() {
	i=1
	lsblk -o path,parttypename,fstype | grep "Linux filesystem" | while read line; do
		dev=$(echo $line | awk '{print $1}')

		if [ -z "$(echo $line | awk '{print $4}')" ]; then
			mkfs.ext4 $dev
		fi

		if [ -z "$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')" ]; then
			mkdir /mnt/data$i
			mount $dev /mnt/data$i
			i=$(($i + 1))
			echo "data: /mnt/data$i"
		fi

	done
}

mirrorlist() {
	pacman -Syy --noconfirm --noprogressbar --quiet
	pacman -S --noconfirm --needed --noprogressbar --quiet reflector

	echo "reflector rating..."
	list=$(reflector -c Taiwan --protocol http --threads 6 --protocol https --sort rate --age 24)
	count=$(echo -e "$list" | grep -E "^Server =" | wc -l)

	if [ $count -gt 0 ]; then
		echo -e "$list" > /etc/pacman.d/mirrorlist
	else
		echo "no suitable mirror sites."
		return
	fi

	sed -E -i 's/^#ParallelDownloads.*/ParallelDownloads = 10/' /etc/pacman.conf
	pacman -Sy
}

init_root
init_boot
init_home
others
genfstab -U /mnt >/mnt/etc/fstab
# mirrorlist
yes "" | pacstrap -i /mnt base base-devel linux linux-firmware efibootmgr zsh vim git
arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/scripts/init.sh)"
