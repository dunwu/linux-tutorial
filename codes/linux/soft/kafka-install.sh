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
# 安装 Kafka 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install kafka begin.${RESET}\n"

command -v java > /dev/null 2>&1 || {
	printf "${RED}Require java but it's not installed.${RESET}\n";
	exit 1;
}

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t sh kafka-install.sh [version] [path]\n"
	printf "\t Example: sh kafka-install.sh 2.2.0 /opt/kafka\n"
	printf "${RESET}\n"
fi

version=2.2.0
if [[ -n $1 ]]; then
	version=$1
fi

path=/opt/kafka
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
curl -o ${path}/kafka_2.12-${version}.tgz http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/${version}/kafka_2.12-${version}.tgz
tar zxf ${path}/kafka_2.12-${version}.tgz -C ${path}

printf "${GREEN}<<<<<<<< install kafka end.${RESET}\n"
