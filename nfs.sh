#!/bin/bash

NETBOOT_FILENAME=networkboot.cfg

# Install NFS server
apt-get -y install nfs-kernel-server

# Backup initrd config
cp /etc/initramfs-tools/initramfs.conf /etc/initramfs-tools/initramfs.conf.bak

# Update initrd config
sed -i 's,MODULES=most,MODULES=netboot,' /etc/initramfs-tools/initramfs.conf
echo -e "BOOT=nfs" >> /etc/initramfs-tools/initramfs.conf

# Rebuild initrd image
mkinitramfs -o $TFTP_DIRECTORY/initrd.img

# Restore backed up initrd config
mv /etc/initramfs-tools/initramfs.conf.bak /etc/initramfs-tools/initramfs.conf

# Copy kernel
cp /boot/vmlinuz-`uname -r` $TFTP_DIRECTORY/vmlinuz

# Add network boot record
echo -e "label boot" >> $TFTP_DIRECTORY/$NETBOOT_FILENAME
echo -e "\tmenu label ^Boot" >> $TFTP_DIRECTORY/$NETBOOT_FILENAME
echo -e "\tkernel vmlinuz" >> $TFTP_DIRECTORY/$NETBOOT_FILENAME
echo -e "\tappend initrd=initrd.img root=/dev/nfs nfsroot=$LAN_SERVER_IP:$NFS_DIRECTORY ip=dhcp rw" >> $TFTP_DIRECTORY/$NETBOOT_FILENAME

# Modify boot record
sed -i 's,include debian-installer/amd64/boot-screens/gtk.cfg,include debian-installer/amd64/boot-screens/gtk.cfg\ninclude '"$NETBOOT_FILENAME"',' $TFTP_DIRECTORY/debian-installer/amd64/boot-screens/menu.cfg

# Create NFS export entry
echo -e "$NFS_DIRECTORY *(rw,sync,no_subtree_check,no_root_squash)\n" >> /etc/exports
echo -e "/home *(rw,sync,no_subtree_check,root_squash)\n" >> /etc/exports

# Apply NFS export entries
exportfs -a
