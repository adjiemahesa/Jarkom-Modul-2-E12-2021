#!/bin/bash

cp backup/no5/named.conf.local /etc/bind/named.conf.local
service bind9 restart
