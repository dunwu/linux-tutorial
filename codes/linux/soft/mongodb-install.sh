#!/usr/bin/env bash

###################################################################################
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
###################################################################################

printf "${BLUE}"
cat << EOF

###################################################################################
# 安装 mongodb 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install mongodb begin.${RESET}\n"

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t sh mongodb-install.sh [version] [path]\n"
	printf "\t Example: sh mongodb-install.sh 4.0.9 /opt/mongodb\n"
	printf "${RESET}\n"
fi

version=4.0.9
if [[ -n $1 ]]; then
	version=$1
fi

path=/opt/mongodb
if [[ -n $2 ]]; then
	path=$2
fi

# install info
printf "${PURPLE}[Info]\n"
printf "\t version = ${version}\n"
printf "\t path = ${path}\n"
printf "${RESET}\n"

# download and decompression
mkdir -p ${path}
curl -o ${path}/mongodb-linux-x86_64-${version}.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${version}.tgz
tar zxf ${path}/mongodb-linux-x86_64-${version}.tgz -C ${path}
mkdir -p /data/db

printf "${GREEN}<<<<<<<< install mongodb end.${RESET}\n"
