#!/bin/bash

export WAN_INTERFACE=enp0s3
export LAN_INTERFACE=enp0s8
export LAN_SUBNET=192.168.10.0
export LAN_NETMASK=255.255.255.0
export LAN_BROADCAST=192.168.10.255
export LAN_SUBNET_CIDR=192.168.10.0/24
export LAN_SERVER_IP=192.168.10.1
export LAN_DHCP_RANGE_START=192.168.10.100
export LAN_DHCP_RANGE_END=192.168.10.200

export DNS_UPSTREAM_1=1.1.1.1
export DNS_UPSTREAM_2=1.0.0.1

export TFTP_DIRECTORY=/srv/tftp
export NFS_DIRECTORY=/srv/nfs

echo "Exporting file system"
bash ./scripts/copyfs.sh

echo "Setting up network"
bash ./scripts/network.sh

echo "Setting up DNS server"
bash ./scripts/dns.sh

echo "Installing DHCP server"
bash ./scripts/dhcp.sh

echo "Installing TFTP server"
bash ./scripts/tftp.sh

echo "Installing NFS server"
bash ./scripts/nfs.sh

echo "Install script finished!"
