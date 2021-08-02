#!/bin/sh

lsblk -o PATH,PARTTYPENAME,UUID | grep 'EFI System' | while read -r line
do
	path=$(echo $line | awk '{print $1}')
	uuid=$(echo $line | awk '{print $4}')

	if [ -z $uuid ]; then
		mkfs.fat $path
	fi
done

lsblk -o PATH,PARTTYPENAME,UUID | grep 'Linux filesystem' | while read -r line
do
	path=$(echo $line | awk '{print $1}')
	uuid=$(echo $line | awk '{print $4}')

	if [ -z $uuid ]; then
		mkfs.ext4 $path
	fi
done
