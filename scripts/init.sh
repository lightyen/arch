#!/bin/sh

network() {
	openssh=$(read -r -p "Install openssh? [y/n] ")
	if [ "$openssh" != n ] && [ "$openssh" != N ]; then
		pacman -S --noconfirm --needed openssh
		systemctl enable sshd
	fi
	pacman -S --noconfirm --needed dhcpcd networkmanager
	systemctl enable dhcpcd
	systemctl enable NetworkManager
}

setLocaltime() {
	region_city="Asia/Taipei"
	while read -r -p "Enter Region/City ($region_city): " timezone; do
		if [ -z "$timezone" ] || [ "$locale" == y ]; then
			ln -sf /usr/share/zoneinfo/$region_city /etc/localtime
			hwclock --systohc
			break
		elif [ -e "/usr/share/zoneinfo/$timezone" ]; then
			ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
			hwclock --systohc
			break
		else
			echo -e "Not found: /usr/share/zoneinfo/${timezone}"
		fi
	done
}

setLocale() {
	locale_list[0]="en_US"
	i=1
	while read -r -p "Enter Locale (${locale_list[*]}): " locale; do
		locale=$(echo ${locale} | tr '-' '_')
		if [ -z "$locale" ] || [ "$locale" == y ]; then
			break
		elif [ -z "$(grep -E $(echo "^#?${locale}\.UTF-8") /etc/locale.gen)" ]; then
			echo -e "Not found: ${locale}.UTF-8"
		else
			locale_list[$i]=${locale}
			i=$(expr $i + 1)
		fi
	done

	sed -E -i 's/^([^#].*)/#\1/' /etc/locale.gen
	for ((i = 0; i < ${#locale_list[@]}; i++)); do
		sed -E -i "s/^#?(${locale_list[i]}\.UTF-8.*)/\1/" /etc/locale.gen
	done

	locale-gen
	echo LANG=en_US.UTF-8 >/etc/locale.conf
}

setHostname() {
	default_hostname=archlinux
	read -r -p "Enter hostname ($default_hostname): " name
	name=${name:-$default_hostname}
	if [ $name == y ]; then
		name=$default_hostname
	fi
	echo -e $name >/etc/hostname
	echo -e "127.0.0.1\tlocalhost" >/etc/hosts
	echo -e "::1\t\tlocalhost" >>/etc/hosts
	echo -e "127.0.1.1\t$name.localdomain\t$name" >>/etc/hosts
}

cpuinfo() {
	if [ -n "$(lscpu | grep -i intel)" ]; then
		echo intel
	elif [ -n "$(lscpu | grep -i amd)" ]; then
		echo amd
	fi
}

bootcfg() {
	bootctl install
	model=$(cpuinfo)
	root=$(df | awk '$6 == "/" {print $1}')
	cfg=/boot/loader/entries/arch.conf
	echo default arch >/boot/loader/loader.conf
	echo title Arch Linux >$cfg
	echo linux /vmlinuz-linux >>$cfg
	if [ $model == "intel" ]; then
		pacman -S --noconfirm --needed intel-ucode
		echo initrd /intel-ucode.img >>$cfg
	elif [ $model == "amd" ]; then
		pacman -S --noconfirm --needed amd-ucode
		echo initrd /amd-ucode.img >>$cfg
	fi
	echo initrd /initramfs-linux.img >>$cfg
	echo options root=PARTUUID=$(blkid -s PARTUUID -o value $root) rw >>$cfg
	bootctl update
}

others() {
	pacman -S --noconfirm --needed sudo git base-devel

	HOME=/root

	pacman -S --noconfirm --needed zsh
	echo "y" | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/1' $HOME/.zshrc
	sed -i 's/plugins=(git)/plugins=(zsh-completions zsh-autosuggestions)/1' $HOME/.zshrc
	echo "autoload -U compinit && compinit" | zsh

	pacman -S --noconfirm --needed vim
	echo "vim vundle..."
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim 1>/dev/null 2>&1
	curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.vimrc -o $HOME/.vimrc
	echo "y" | vim +PluginInstall +qa! 1>/dev/null 2>&1

	chsh -s /bin/zsh
}

case "$1" in
"bootcfg")
	bootcfg
	;;
"locale")
	setLocale
	;;
"localtime")
	setLocaltime
	;;
"hostname")
	setHostname
	;;
"network")
	network
	;;
"others")
	others
	;;
*)
	bootcfg
	setLocale
	setLocaltime
	setHostname
	network
	others
	echo "Root password:"
	passwd
	;;
esac
