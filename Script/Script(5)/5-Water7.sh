#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get intall nano
apt-get install bind9 -y
cp backup/no5/named.conf.local /etc/bind/named.conf.local
service bind9 restart