#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get install dnsutils -y
echo nameserver 10.35.2.2 > /etc/resolv.conf
host -t PTR 10.35.2.2