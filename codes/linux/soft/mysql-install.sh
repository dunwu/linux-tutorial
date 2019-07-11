#!/usr/bin/env bash

wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm

sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
sudo yum install mysql-community-server
