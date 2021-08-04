#!/bin/sh

init_root() {
	dev=$(lsblk -o path,partlabel | grep root | awk '{print $1}')
	if [ -z $dev ]; then
		echo "Waring: 'root' is not found."
		return
	fi

	fs_type="$(blkid -s TYPE -o value $dev)"
	if [ -z $fs_type ]; then
		mkfs.ext4 $dev
	fi

	mountpoint=$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')

	if [ -z $mountpoint ]; then
		mount $dev /mnt
		mountpoint=/mnt
	fi

	echo "root: $mountpoint"
}

init_boot() {
	dev=$(lsblk -o path,partlabel | grep boot | awk '{print $1}')

	fs_type="$(blkid -s TYPE -o value $dev)"
	if [ -z $fs_type ]; then
		mkfs.fat $dev
	fi

	mountpoint=$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')

	if [ -z $mountpoint ]; then
		mkdir /mnt/boot
		mount $dev /mnt/boot
		mountpoint=/mnt/boot
	fi

	echo "boot: $mountpoint"

}

init_home() {
	dev=$(lsblk -o path,partlabel | grep home | awk '{print $1}')
	if [ -z $dev ]; then
		return
	fi

	fs_type="$(blkid -s TYPE -o value $dev)"
	if [ -z $fs_type ]; then
		mkfs.ext4 $dev
	fi

	mountpoint=$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')

	if [ -z $mountpoint ]; then
		mkdir /mnt/home
		mount $dev /mnt/home
		mountpoint=/mnt/home
	fi

	echo "home: $mountpoint"
}

others() {
	i=1
	lsblk -o path,parttypename,fstype | grep "Linux filesystem" | while read line; do
		dev=$(echo $line | awk '{print $1}')
		fs_type=$(echo $line | awk '{print $4}')

		if [ $fs_type ]; then
			continue
		fi

		mkfs.ext4 $dev
		mountpoint=$(lsblk -o mountpoint $dev | awk 'BEGIN{FS="\n";RS=""}{print $2}')

		if [ -z $mountpoint ]; then
			mkdir /mnt/data$i
			mount $dev /mnt/data$i
			mountpoint=/mnt/data$i
			i=$(expr $i + 1)
		fi

		echo "data: $mountpoint"
	done
}

mirrorlist() {
	mirrorlist=/etc/pacman.d/mirrorlist
	pacman -Sy --noconfirm --needed reflector

	echo "creating mirrorlist..."
	list=$(reflector -c Taiwan -c Japan -p https -a 12 --sort rate)

	count=$(echo -e "$list" | grep -E "^Server =" | wc -l)

	if [ $count -gt 0 ]; then
		echo -e "$list" >$mirrorlist
	fi
	sed -E -i 's/^#ParallelDownloads.*/ParallelDownloads = 10/' /etc/pacman.conf
	pacman -Sy
}

init_root
init_boot
init_home
others
mirrorlist
yes "" | pacstrap -i /mnt base linux linux-firmware
genfstab -U /mnt >/mnt/etc/fstab
arch-chroot /mnt
