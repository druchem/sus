#!/bin/bash

# Install bind9 DNS server
apt-get -y install bind9

echo -e "acl clients {" >> /etc/bind/named.conf.options
echo -e "\tlocalhost;" >> /etc/bind/named.conf.options
echo -e "\t$LAN_SUBNET_CIDR;" >> /etc/bind/named.conf.options
echo -e "};" >> /etc/bind/named.conf.options
echo -e "options {" >> /etc/bind/named.conf.options
echo -e "\tforwarders {" >> /etc/bind/named.conf.options
echo -e "\t\t$DNS_UPSTREAM_1;" >> /etc/bind/named.conf.options
echo -e "\t\t$DNS_UPSTREAM_2;" >> /etc/bind/named.conf.options
echo -e "\t};" >> /etc/bind/named.conf.options
echo -e "\trecursion yes;" >> /etc/bind/named.conf.options
echo -e "\allow-query { clients; };" >> /etc/bind/named.conf.options
echo -e "\tforward only;" >> /etc/bind/named.conf.options
echo -e "};" >> /etc/bind/named.conf.options

service restart bind9
