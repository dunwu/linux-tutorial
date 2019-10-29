#!/usr/bin/env bash

# ---------------------------------------------------------------------------------
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
# ---------------------------------------------------------------------------------

printf "${BLUE}\n"
cat << EOF
###################################################################################
# linux-tutorial 运维脚本工具集下载脚本
# 下载 https://github.com/dunwu/linux-tutorial 中的所有脚本到当前服务器的
# /home/scripts/linux-tutorial 目录下
# @system: 适用于 CentOS
# @author: Zhang Peng
# See: https://github.com/dunwu/linux-tutorial
###################################################################################
EOF
printf "${RESET}\n"

root=/home/scripts/linux-tutorial
printf "\n${GREEN}>>>>>>>> Download linux-tutorial to ${root} begin.${RESET}\n"
command -v yum > /dev/null 2>&1 || {
	printf "\n${RED}Not detected yum.${RESET}";
	exit 1;
}

command -v git > /dev/null 2>&1 || {
	printf "\n${YELLOW}Not detected git. Install git.${RESET}\n";
	yum install -y git;
}

if [[ -d ${root} ]]; then
	cd ${root}
	git pull
else
	mkdir -p ${root}
	git clone https://gitee.com/turnon/linux-tutorial.git ${root}
fi
chmod +x -R ${root}
printf "\n${GREEN}<<<<<<<< Download linux-tutorial to ${root} end.${RESET}\n"
