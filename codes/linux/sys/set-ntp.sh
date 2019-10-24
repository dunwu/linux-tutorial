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

###################################################################################
# 使用 NTP 进行时间同步
# 参考：https://www.cnblogs.com/quchunhui/p/7658853.html
# @author: Zhang Peng
###################################################################################

printf "\n${GREEN}>>>>>>>>> 设置 NTP 开始${RESET}\n"

printf "\n${CYAN}>>>> 安装 NTP 服务${RESET}\n"
yum -y install ntp

ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
/sbin/iptables -A INPUT -p UDP -i eth0 -s ${ip}/24 --dport 123 -j ACCEPT

printf "\n${CYAN}>>>> 启动 NTP 服务${RESET}\n"
systemctl start ntpd.service

printf "\n${CYAN}>>>> 立即执行时间同步${RESET}\n"
/usr/sbin/ntpdate ntp.sjtu.edu.cn

printf "\n${CYAN}>>>> 自动定时同步时间${RESET}\n"
echo "* 3 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn" >> /etc/crontab
systemctl restart crond.service

printf "\n${CYAN}>>>> 同步结束，当前系统时间：${RESET}\n"
date

printf "\n${GREEN}<<<<<<<< 设置 NTP 结束${RESET}\n"
