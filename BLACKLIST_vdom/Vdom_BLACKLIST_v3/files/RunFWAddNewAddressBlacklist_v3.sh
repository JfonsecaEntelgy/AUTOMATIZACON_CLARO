#!/bin/bash

ruta="/tmp"
script="FWAddNewAddressBlacklist_v3.sh"
host=$1
address=$2
login=$3
password=$4
vdom=$5

echo $address > /tmp/address
ipS=$(cat /tmp/address | tr "," "\n")
echo $ipS > /tmp/address2
for IP in `cat /tmp/address2`
do
/usr/bin/expect $ruta/$script $host $login $password $IP $vdom
done
rm -rf /tmp/address
#rm -rf /tmp/address2
