#!/bin/bash

CONFIGURATION_FILE=/etc/bind/named.conf.options

# Install bind9 DNS server
apt-get -y install bind9

# Remove old configuration file
mv $CONFIGURATION_FILE $CONFIGURATION_FILE.old

# Write new configuration file
echo -e "acl clients {" >> $CONFIGURATION_FILE
echo -e "\tlocalhost;" >> $CONFIGURATION_FILE
echo -e "\t$LAN_SUBNET_CIDR;" >> $CONFIGURATION_FILE
echo -e "};" >> $CONFIGURATION_FILE
echo -e "options {" >> $CONFIGURATION_FILE
echo -e "\tdirectory \"/var/cache/bind\";" >> $CONFIGURATION_FILE
echo -e "\tforwarders {" >> $CONFIGURATION_FILE
echo -e "\t\t$DNS_UPSTREAM_1;" >> $CONFIGURATION_FILE
echo -e "\t\t$DNS_UPSTREAM_2;" >> $CONFIGURATION_FILE
echo -e "\t};" >> $CONFIGURATION_FILE
echo -e "\trecursion yes;" >> $CONFIGURATION_FILE
echo -e "\tallow-query { clients; };" >> $CONFIGURATION_FILE
echo -e "\tforward only;" >> $CONFIGURATION_FILE
echo -e "};" >> $CONFIGURATION_FILE

# Restart DNS server to apply changes
service restart bind9
