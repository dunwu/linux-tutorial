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
# 安装 ZooKeeper 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install zookeeper begin.${RESET}\n"

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t sh zookeeper-install.sh [version] [path]\n"
	printf "\t Example: sh zookeeper-install.sh 3.4.12 /opt/zookeeper\n"
	printf "${RESET}\n"
fi

version=3.4.12
if [[ -n $1 ]]; then
	version=$1
fi

path=/opt/zookeeper
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
curl -o ${path}/zookeeper-${version}.tar.gz http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-${version}/zookeeper-${version}.tar.gz
tar zxf ${path}/zookeeper-${version}.tar.gz -C ${path}

printf "${GREEN}<<<<<<<< install zookeeper end.${RESET}\n"
