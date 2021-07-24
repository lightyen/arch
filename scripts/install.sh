#!/bin/sh

setLocaltime() {
	region_city="Asia/Taipei"
	read -r -p "Enter Region/City ($region_city): " region_city
	region_city=Asia/Taipei
	if [ -e "/usr/share/zoneinfo/$region_city" ]; then
		ln -sf /usr/share/zoneinfo/$region_city /etc/localtime
		hwclock --systohc
	fi
}

setLocale() {
	locale_list[0]="en_US"
	i=1
	while read -r -p "Enter Locale (${locale_list[*]}): " locale
	do
		locale=$(echo ${locale} | tr '-' '_')
		if [ -z "$locale" ]; then
			break
		elif [ "" == "$(grep -E $(echo "^#?${locale}\.UTF-8") /etc/locale.gen)" ]; then
			echo -e "Not found: ${locale}.UTF-8"
		else
			locale_list[$i]=${locale}
			i=$(echo $i+1 | bc)
		fi
	done

	sed -E -i 's/^([^#].*)/#\1/' /etc/locale.gen
	for ((i = 0; i < ${#locale_list[@]}; i++))
	do
		sed -E -i "s/^#?(${locale_list[i]}\.UTF-8.*)/\1/" /etc/locale.gen
	done

	locale-gen
}

setHostname() {
	hostname="archlinux"
	read -r -p "Enter hostname ($hostname): " hostname
	echo -e $hostname > /etc/hostname
	echo -e "127.0.0.1\tlocalhost" > /etc/hosts
	echo -e "::1\t\tlocalhost" >> /etc/hosts
	echo -e "127.0.1.1\t$hostname.localdomain\t$hostname" >> /etc/hosts
}

setVim() {
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    curl -fsSL https://raw.githubusercontent.com/lightyen/arch/main/.vimrc -o ~/.vimrc
    vim -c 'PluginInstall' -c 'qa!'
}

init() {
	setLocaltime
	setLocale
	setHostname
}

case "$1" in
"locale")
    setLocale
	;;
"localtime")
    setLocaltime
	;;
"hostname")
    setHostname
	;;
"vim")
    setVim
    ;;
"start")
	init
	;;
*)
	echo "    start | localtime | localtime | hostname | vim"
esac

