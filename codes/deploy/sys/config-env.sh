#!/usr/bin/env bash

###################################################################################
# Linux Centos7 设置环境配置脚本（根据需要选择）
# 注：不了解脚本中配置意图的情况下，不要贸然执行此脚本
# Author: Zhang Peng
###################################################################################

# 获取当前机器 IP
ip=""
function getDeviceIp() {
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

function setDNS() {
getDeviceIp
host=`hostname`
cat >> /etc/hosts << EOF
${ip} ${host}
EOF
}

function setNameServer() {
  echo "添加域名服务器"
  echo "nameserver 218.2.135.1" >> /etc/resolv.conf
}

function setNtp() {
# 时钟同步工具
yum -y install ntp
# 同步上海交通大学网络中心NTP服务器
echo "* 4 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn > /dev/null 2>&1" >> /var/spool/cron/root
# 以一个服务器时间为标准定时更新时间（有时需要以公司中的服务器作为标准）
#echo "*/30 * * * * /usr/local/bin/ntpdate 192.168.16.182" >> /var/spool/cron/root
}

function setLimit() {
cat >> /etc/security/limits.conf << EOF
 *  -  nofile  65535
 *  -  nproc   65535
EOF
}

function setLang() {
cat > /etc/sysconfig/i18n << EOF
LANG="zh_CN.UTF-8"
EOF
}

function closeShutdownShortkey() {
  echo "关闭 Ctrl+Alt+Del 快捷键防止重新启动"
  sed -i 's#exec /sbin/shutdown -r now#\#exec /sbin/shutdown -r now#' /etc/init/control-alt-delete.conf
}

function closeSelinux() {
  echo "关闭 selinux"

  # see http://blog.51cto.com/13570193/2093299
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
}

function closeFirewall() {
  echo "关闭防火墙"

  # see https://www.cnblogs.com/moxiaoan/p/5683743.html
  systemctl stop firewalld
  systemctl disable firewalld
}

function setBootMode() {
  # 1. 停机(记得不要把 initdefault 配置为 0，因为这样会使 Linux 不能启动)
  # 2. 单用户模式，就像 Win9X 下的安全模式
  # 3. 多用户，但是没有 NFS
  # 4. 完全多用户模式，准则的运行级
  # 5. 通常不用，在一些特殊情况下可以用它来做一些事情
  # 6. X11，即进到 X-Window 系统
  # 7. 重新启动 (记得不要把 initdefault 配置为 6，因为这样会使 Linux 不断地重新启动)
  echo "设置 Linux 启动模式"
  sed -i 's/id:5:initdefault:/id:3:initdefault:/' /etc/inittab
}

function configIpv4(){
echo "配置 ipv4"

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
}

function closeIpv6() {
echo "关闭 ipv6"

cat > /etc/modprobe.d/ipv6.conf << EOF
alias net-pf-10 off
options ipv6 disable=1
EOF

echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network
}

######################################## MAIN ########################################
echo -e "\n>>>>>>>>> 配置系统环境"

# 关闭 selinux
closeSelinux

# 关闭防火墙
closeFirewall

# 设置 DNS 服务器和本机 Host
setNameServer
setDNS

# 设置时间同步
setNtp

echo -e "\n>>>>>>>>> 配置系统环境结束"
