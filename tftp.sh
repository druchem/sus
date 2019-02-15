#!/bin/bash

NETBOOT_FILENAME=nb.tar.gz

# Install TFTP server
apt-get -y install tftpd-hpa

# Download Debian netboot files
wget -O $NETBOOT_FILENAME http://ftp.cz.debian.org/debian/dists/stretch/main/installer-amd64/current/images/netboot/netboot.tar.gz

# Extract netboot files
tar xzf $NETBOOT_FILENAME -C $TFTP_DIRECTORY

# Cleanup downloaded files
rm $NETBOOT_FILENAME
