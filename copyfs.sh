#!/bin/bash

# Install nfs common package to allow /home mount
apt-get -y install nfs-common

# Create NFS export directory
mkdir $NFS_DIRECTORY

# Copy current filesystem
cp -R /bin $NFS_DIRECTORY/bin
cp -R /boot $NFS_DIRECTORY/boot
cp -R /dev $NFS_DIRECTORY/dev
cp -R /etc $NFS_DIRECTORY/etc
cp -R /lib $NFS_DIRECTORY/lib
cp -R /lib64 $NFS_DIRECTORY/lib64
cp -R /opt $NFS_DIRECTORY/opt
cp -R /root $NFS_DIRECTORY/root
cp -R /run $NFS_DIRECTORY/run
cp -R /sbin $NFS_DIRECTORY/sbin
cp -R /usr $NFS_DIRECTORY/usr
cp -R /var $NFS_DIRECTORY/var

# Add mount points to client fstab
rm $NFS_DIRECTORY/etc/fstab
echo -e "/dev/nfs\t/\tdefaults\t1\t1" >> $NFS_DIRECTORY/etc/fstab
echo -e "$LAN_SERVER_IP:/home\t/home\tnfs\tnfsvers=3,hard,intr,auto\t0\t0" >> $NFS_DIRECTORY/etc/fstab

# Fix network interfaces (by removing it)
rm $NFS_DIRECTORY/etc/network/interfaces
