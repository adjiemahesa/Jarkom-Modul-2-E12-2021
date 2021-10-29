#!/bin/bash

cp backup/no6/franky.E12.com /etc/bind/kaizoku/franky.E12.com
cp backup/no6/named.conf.options /etc/bind/named.conf.options
cp backup/no6/named.conf.local /etc/bind/named.conf.local
service bind9 restart