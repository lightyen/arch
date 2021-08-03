#!/bin/sh

sgdisk -n 0:0:+100M -c 0:boot -t 0:ef00 /dev/sda

for i in {1..48}; do
	sgdisk -n 0:0:+1G /dev/sda
done

sgdisk -n 0:0:0 -c 0:root /dev/sda
