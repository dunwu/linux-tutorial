#!/usr/bin/env bash

###################################################################################
# 使用 NTP 进行时间同步
# 参考：https://www.cnblogs.com/quchunhui/p/7658853.html
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> 设置 ntp"

echo -e "先安装时钟同步工具 ntp"
yum -y install ntp

ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
/sbin/iptables -A INPUT -p UDP -i eth0 -s ${ip}/24 --dport 123 -j ACCEPT

echo -e "启动 NTP 服务"
systemctl start ntpd.service

echo -e "立即执行时间同步"
/usr/sbin/ntpdate ntp.sjtu.edu.cn

echo -e "自动定时同步时间"
echo "* 3 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn" >> /etc/crontab
systemctl restart crond.service

echo -e "同步后系统时间："
date
