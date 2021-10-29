#!/bin/bash

cp backup/no6/named.conf.options /etc/bind/named.conf.options
cp backup/no6/named.conf.local /etc/bind/named.conf.local
mkdir /etc/bind/sunnygo
cp backup/no6/mecha.franky.E12.com /etc/bind/sunnygo/mecha.franky.E12.com 
service bind9 restart