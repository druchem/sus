#!/bin/bash

# Allow remote root SSH
sed -i 's,#PermitRootLogin prohibit-password,PermitRootLogin yes,' /etc/ssh/sshd_config
systemctl restart ssh

# Fix WAN auto config
sed -i 's,allow-hotplug '"$WAN_INTERFACE"',auto '"$WAN_INTERFACE"'\nallow-hotplug '"$WAN_INTERFACE"',' /etc/network/interfaces

# Append LAN config
echo -e "\nauto $LAN_INTERFACE" >> /etc/network/interfaces
echo -e "allow-hotplug $LAN_INTERFACE" >> /etc/network/interfaces
echo -e "iface $LAN_INTERFACE inet static" >> /etc/network/interfaces
echo -e "\taddress $LAN_SERVER_IP" >> /etc/network/interfaces
echo -e "\tnetmask $LAN_NETMASK" >> /etc/network/interfaces

# Restart networking service to apply changes
systemctl restart networking

# Add iptables rules
echo -e "#!/bin/bash" >> /etc/rc.local
echo -e "iptables -t nat -A POSTROUTING -o $WAN_INTERFACE -j MASQUERADE" >> /etc/rc.local
echo -e "exit 0" >> /etc/rc.local
chmod +x /etc/rc.local
systemctl restart rc-local

# Enable IPv4 forwarding
sed -i 's,#net.ipv4.ip_forward=1,net.ipv4.ip_forward=1,' /etc/sysctl.conf
sysctl -p
