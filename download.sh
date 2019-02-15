#!/bin/bash

HOST=<YOUR_SERVER_HOST>

mkdir scripts

wget -q -P ./scripts $HOST/install.sh
wget -q -P ./scripts $HOST/copyfs.sh
wget -q -P ./scripts $HOST/network.sh
wget -q -P ./scripts $HOST/dns.sh
wget -q -P ./scripts $HOST/dhcp.sh
wget -q -P ./scripts $HOST/tftp.sh
wget -q -P ./scripts $HOST/nfs.sh

chmod +x ./scripts/install.sh

echo "Successfuly downloaded scripts!"
