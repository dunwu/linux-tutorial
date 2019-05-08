#!/usr/bin/env bash

path=/tmp/dunwu-ops
mkdir -p ${path}

printf "\n>>>>>>>>> download scripts to ${path}"
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/dunwu-ops.sh -O ${path}/dunwu-ops.sh
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/dunwu-soft.sh -O ${path}/dunwu-soft.sh
wget -N https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/dunwu-sys.sh -O ${path}/dunwu-sys.sh

chmod +x ${path}/dunwu-ops.sh
chmod +x ${path}/dunwu-soft.sh
chmod +x ${path}/dunwu-sys.sh
