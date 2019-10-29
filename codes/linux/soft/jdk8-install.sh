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
# 安装 JDK8 脚本
# JDK 会被安装到 /usr/lib/jvm/java 路径。
# @system: 适用于 CentOS
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install jdk8 begin.${RESET}\n"

command -v yum > /dev/null 2>&1 || {
	printf "${RED}Require yum but it's not installed.${RESET}\n";
	exit 1;
}

yum -y install java-1.8.0-openjdk-devel.x86_64
java -version

printf "${GREEN}<<<<<<<< install jdk8 end.${RESET}\n"
