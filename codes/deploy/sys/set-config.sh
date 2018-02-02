#!/usr/bin/env bash

###################################################################################
# Linux Centos 设置环境配置脚本
# Author: Zhang Peng
#
# 不了解脚本中配置意图的情况下，不要贸然执行此脚本
###################################################################################

# 获取当前机器 IP
ip=""
getDeviceIp() {
  ip=`ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`
  if [ "$ip" ==  "" ]
  then
      ip=`ifconfig ens32 | grep "inet"|grep "broadcast" | awk '{ print $2}' | awk -F: '{print $1}'`
  fi

  if [ "$ip" ==  "" ]
  then
      ip=`echo $1`
  fi

  if [ "${ip}" ==  "" ]
    then
      echo "无法获取IP地址"
    exit 0
  fi
}

host=`hostname`

#set the file limit
cat >> /etc/security/limits.conf << EOF
 *  -  nofile  65535
 *  -  nproc   65535
EOF

#set system language utf8
cat > /etc/sysconfig/i18n << EOF
LANG="zh_CN.UTF-8"
EOF

#set DNS
cat >> /etc/hosts << EOF
${ip} ${host}
EOF

#set the control-alt-delete to guard against the miSUSE
sed -i 's#exec /sbin/shutdown -r now#\#exec /sbin/shutdown -r now#' /etc/init/control-alt-delete.conf

#disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#Full multiuser mode
sed -i 's/id:5:initdefault:/id:3:initdefault:/' /etc/inittab

#tune kernel parametres
cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 16384
net.core.netdev_max_backlog =  16384
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 0
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.ip_local_port_range = 2000  65535
net.ipv4.tcp_max_tw_buckets = 5000
vm.swappiness=10
EOF

#disable the ipv6
cat > /etc/modprobe.d/ipv6.conf << EOF
alias net-pf-10 off
options ipv6 disable=1
EOF
echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network
