#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install bind9 -y
mkdir /etc/bind/kaizoku
cp backup/no2/name.conf.local /etc/bind/name.conf.local
cp backup/no2/franky.E12.com /etc/bind/kaizoku/franky.E12.com
service bind9 restart