#!/bin/zsh

#disks=`lsblk | grep 'disk' | cut -d" " -f1`

disk="sda"

if [ -d /sys/firmware/efi/efivars ] ; then
	echo "EFI detected"
	partition_table="./efi.sh"	
	echo ',,L' | sfdisk --wipe=always --label=gpt ${disk}
	efi_part="${disk}1"
	recovery_part="${disk}2"
	stateless_part="${disk}3"
	stateful_part="${disk}4"
else
	echo "System booted on BIOS"
	partition_table="./mbr.sh"
	echo ',,L' | sfdisk --wipe=always --label=dos ${disk}
	conf_part="${disk}1"
	recovery_part="${disk}2"
	stateless_part="${disk}3"
	stateful_part="${disk}4"
fi


#partition disk
sfdisk "/dev/$disk" <<< `$partition_table "$disk"`
#create btrfs partitions
mkfs.btrfs "/dev/$recovery_part"
mkfs.btrfs "/dev/$stateless_part"
mkfs.btrfs "/dev/$stateful_part"
#create and mount partitions
mkdir /mnt/recovery
mount "/dev/$efi_part" /mnt/recovery
mkdir /mnt/stateless
mount "/dev/$stateless_part" /mnt/stateless
mkdir /mnt/stateful
mount "/dev/$stateful_part" /mnt/stateful


if [ -d /sys/firmware/efi/efivars ] ; then
	#create EFI partition and mount
	mkfs.fat -F 32 "/dev/$efi_part"
	mkdir /mnt/boot
	mount "/dev/$efi_part" /mnt/boot
else
	#create legacy config partition
	mkfs.btrfs "/dev/$conf_part"
	mkdir /mnt/conf
	mount "/dev/$conf_part" /mnt/conf
fi
#sleep 1
#echo "Downloading Arch-Linux packages and base commands"
#pacstrap /mnt base linux linux-firmware vim man-db man-pages texinfo dhcpcd iproute2 grub efibootmgr lvm2
#sleep 1
#echo "Generate fstab"
#genfstab -U /mnt > /mnt/etc/fstab
#sleep 1
#echo "Chrooting into Arch-Linux installation using a script"
#cp ./chroot_script.sh /mnt/root/script.sh
#arch-chroot /mnt `/bin/bash ~/script.sh`
#rm /mnt/root/script.sh
#reboot
