#!/bin/bash

# Requires DNS

DHCPD_CONF_FILE=/etc/dhcp/dhcpd.conf

# Install ISC-DHCP server
apt-get -y install isc-dhcp-server

# Run DHCP server on LAN interface
sed -i 's,INTERFACESv4="",INTERFACESv4="'"$LAN_INTERFACE"'",' /etc/default/isc-dhcp-server

# Remove old configuration file
rm $DHCPD_CONF_FILE

echo -e "ddns-update-style none;" >> $DHCPD_CONF_FILE
echo -e "authoritative;" >> $DHCPD_CONF_FILE
echo -e "allow booting;" >> $DHCPD_CONF_FILE
echo -e "subnet $LAN_SUBNET netmask $LAN_NETMASK {" >> $DHCPD_CONF_FILE
echo -e "\trange $LAN_DHCP_RANGE_START $LAN_DHCP_RANGE_END;" >> $DHCPD_CONF_FILE
echo -e "\toption routers $LAN_SERVER_IP;" >> $DHCPD_CONF_FILE
echo -e "\toption broadcast-address $LAN_BROADCAST;" >> $DHCPD_CONF_FILE
echo -e "\toption domain-name-servers $LAN_SERVER_IP;" >> $DHCPD_CONF_FILE
echo -e "\tfilename \"pxelinux.0\";" >> $DHCPD_CONF_FILE
echo -e "}" >> $DHCPD_CONF_FILE

# Restart ISC-DHCP server
systemctl restart isc-dhcp-server
