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
# 安装 mysql 脚本
# @system: 适用于 Centos7 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install mysql begin.${RESET}\n"

command -v wget > /dev/null 2>&1 || { printf "${RED}Require wget but it's not installed.${RESET}\n";
    exit 1; }
command -v rpm > /dev/null 2>&1 || { printf "${RED}Require rpm but it's not installed.${RESET}\n";
    exit 1; }
command -v yum > /dev/null 2>&1 || { printf "${RED}Require yum but it's not installed.${RESET}\n";
    exit 1; }

# 使用 rpm 安装 mysql
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
sudo yum install mysql-community-server

# 设置开机启动
systemctl enable mysqld
systemctl daemon-reload

password=$(grep "password" /var/log/mysqld.log | awk '{print $NF}')
printf "临时密码为：${PURPLE}${password}${RESET}，请登录 mysql 后重置新密码\n"

printf "${GREEN}<<<<<<<< install mysql end.${RESET}\n"
