#!/usr/bin/env bash

###################################################################################
# 在 /etc/resolv.conf 中设置 DNS 服务器
# 在 /etc/hosts 中设置本机域名
# Author: Zhang Peng
###################################################################################
ip='127.0.0.1'
function getDeviceIp() {
  ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
}

function setDNSServer() {
echo -e "设置DNS服务器"
cat >> /etc/resolv.conf << EOF
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF
}

function setHosts() {
getDeviceIp
host=`hostname`
cat >> /etc/hosts << EOF
${ip} ${host}
EOF
}

######################################## MAIN ########################################
echo -e "\n>>>>>>>>> 配置系统环境"
setDNSServer
setHosts
