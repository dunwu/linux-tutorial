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

command -v wget > /dev/null 2>&1 || {
	printf "${RED}Require wget but it's not installed.${RESET}\n";
	exit 1;
}
command -v rpm > /dev/null 2>&1 || {
	printf "${RED}Require rpm but it's not installed.${RESET}\n";
	exit 1;
}
command -v yum > /dev/null 2>&1 || {
	printf "${RED}Require yum but it's not installed.${RESET}\n";
	exit 1;
}

# 使用 rpm 安装 mysql
printf "${CYAN}>>>> yum install mysql${RESET}\n"
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo rpm -Uvh mysql80-community-release-el7-3.noarch.rpm
sudo yum install mysql-community-server

printf "${CYAN}>>>> replace settings${RESET}\n"
cp /etc/my.cnf /etc/my.cnf.bak
wget -N https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/config/mysql/my.cnf -O /etc/my.cnf
# 创建空的慢查询日志文件
mkdir -p /var/log/mysql
touch /var/log/mysql/mysql-slow.log
chmod 777 /var/log/mysql/mysql-slow.log
chown -R mysql:mysql /var/log/mysql

# 设置开机启动
printf "${CYAN}>>>> start mysqld${RESET}\n"
systemctl enable mysqld
systemctl start mysqld
systemctl daemon-reload

cat >> /etc/security/limits.conf << EOF
mysql soft nofile 65536
mysql hard nofile 65536
EOF

password=$(grep "password" /var/log/mysqld.log | awk '{print $NF}')
printf "临时密码为：${PURPLE}${password}${RESET}，请登录 mysql 后重置新密码\n"

printf "${GREEN}<<<<<<<< install mysql end.${RESET}\n"
