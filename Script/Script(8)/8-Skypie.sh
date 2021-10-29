#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install wget -y
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
apt-get install unzip
cp backup/no8/franky.E12.com.conf /etc/apache2/sites-available/franky.E12.com.conf
a2ensite franky.E12.com.conf
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/franky.zip
unzip franky.zip
mv franky /var/www/franky.E12.com
service apache2 restart