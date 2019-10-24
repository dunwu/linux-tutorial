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
# 在 /etc/resolv.conf 中配置 DNS 服务器
# 在 /etc/hosts 中配置本机域名
# @author: Zhang Peng
###################################################################################

printf "\n${GREEN}>>>>>>>>> 配置 DNS 开始${RESET}\n"

printf "\n${CYAN}>>>> 配置 DNS 解析服务器${RESET}\n"
cat >> /etc/resolv.conf << EOF
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF

printf "\n${CYAN}>>>> 配置本机域名和IP映射${RESET}\n"
ip=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
host=`hostname`
cat >> /etc/hosts << EOF
${ip} ${host}
EOF

printf "\n${GREEN}<<<<<<<< 配置 DNS 结束${RESET}\n"
