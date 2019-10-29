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
# 安装 rocketmq 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install tomcat begin.${RESET}\n"

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t sh rocketmq-install.sh [version] [path]\n"
	printf "\t Example: sh rocketmq-install.sh 4.5.0 /opt/rocketmq\n"
	printf "${RESET}\n"
fi

version=4.5.0
if [[ -n $1 ]]; then
	version=$1
fi

path=/opt/rocketmq
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
curl -o ${path}/rocketmq-all-${version}-bin-release.zip http://mirrors.tuna.tsinghua.edu.cn/apache/rocketmq/${version}/rocketmq-all-${version}-bin-release.zip
unzip -o ${path}/rocketmq-all-${version}-bin-release.zip -d ${path}/rocketmq-all-${version}/
mv ${path}/rocketmq-all-${version}/rocketmq-all-${version}-bin-release/* ${path}/rocketmq-all-${version}
rm -rf ${path}/rocketmq-all-${version}/rocketmq-all-${version}-bin-release

printf "${GREEN}<<<<<<<< install rocketmq end.${RESET}\n"
