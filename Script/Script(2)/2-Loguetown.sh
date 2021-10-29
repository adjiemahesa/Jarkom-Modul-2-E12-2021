#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install nano
echo nameserver 10.35.2.2 > /etc/resolv.conf