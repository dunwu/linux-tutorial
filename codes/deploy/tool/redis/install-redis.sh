#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install redis"

mkdir -p /opt/software/redis
cd /opt/software/redis

version=4.0.8
wget http://download.redis.io/releases/redis-${version}.tar.gz
tar -zxvf redis-${version}.tar.gz
cd redis-${version}
make
