#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install lynx -y
echo 'nameserver 10.35.2.2
nameserver 10.35.2.3
nameserver 10.35.2.4'> /etc/resolv.conf