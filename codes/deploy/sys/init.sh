#!/usr/bin/env bash

###################################################################################
# Linux Centos 环境初始化脚本（设置环境配置、安装基本的命令工具）
# Author: Zhang Peng
###################################################################################

cat << EOF
***********************************************************************************
* The initialization of linux environment is begin.
***********************************************************************************
EOF

filepath=$(cd "$(dirname "$0")"; pwd)

# 设置环境配置，不了解具体修改内容的情况下，请勿执行
# ${filepath}/set-config.sh

# 替换 yum 镜像
${filepath}/yum/change-yum-repo.sh

# 安装命令行工具
${filepath}/install-cmd-tool.sh

# 时钟同步工具
yum -y install ntp
# 同步上海交通大学网络中心NTP服务器
echo "* 4 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn > /dev/null 2>&1" >> /var/spool/cron/root
# 以一个服务器时间为标准定时更新时间（有时需要以公司中的服务器作为标准）
#echo "*/30 * * * * /usr/local/bin/ntpdate 192.168.16.182" >> /var/spool/cron/root

cat << EOF
***********************************************************************************
* The initialization of linux environment is over.
***********************************************************************************
EOF
