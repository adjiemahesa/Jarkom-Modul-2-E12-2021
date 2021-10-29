#!/bin/bash

cp backup/no4/named.conf.local /etc/bind/named.conf.local
cp backup/no4/2.35.10.in-addr.arpa /etc/bind/kaizoku/2.35.10.in-addr.arpa
service bind9 restart