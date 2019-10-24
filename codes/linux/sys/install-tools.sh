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

printf "${BLUE}\n"
cat << EOF
###################################################################################
# 安装常用命令工具
# 命令工具清单如下：
# 核心工具：df、du、chkconfig
# 网络工具：ifconfig、netstat、route、iptables
# IP工具：ip、ss、ping、tracepath、traceroute
# DNS工具：dig、host、nslookup、whois
# 端口工具：lsof、nc、telnet
# 下载工具：curl、wget
# 编辑工具：emacs、vim
# 流量工具：iftop、nethogs
# 抓包工具：tcpdump
# 压缩工具：unzip、zip
# 版本控制工具：git、subversion
#
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

printf "\n${GREEN}>>>>>>>>> 安装常用命令工具开始${RESET}\n"

# 核心工具
printf "\n${CYAN}>>>> install coreutils(df、du)${RESET}\n"
yum install -y coreutils
printf "\n${CYAN}>>>> install chkconfig${RESET}\n"
yum install -y chkconfig

# 网络工具
printf "\n${CYAN}>>>> install net-tools(ifconfig、netstat、route)${RESET}\n"
yum install -y net-tools
printf "\n${CYAN}>>>> install iptables${RESET}\n"
yum install -y iptables

# IP工具
printf "\n${CYAN}>>>> install iputils(ping、tracepath)${RESET}\n"
yum install -y iputils
printf "\n${CYAN}>>>> install traceroute${RESET}\n"
yum install -y traceroute
printf "\n${CYAN}>>>> install iproute(ip、ss)${RESET}\n"
yum install -y iproute

# 端口工具
printf "\n${CYAN}>>>> install lsof${RESET}\n"
yum install -y lsof
printf "\n${CYAN}>>>> install nc${RESET}\n"
yum install -y nc
printf "\n${CYAN}>>>> install netstat${RESET}\n"
yum install -y netstat

# DNS工具
printf "\n${CYAN}>>>> install bind-utils(dig、host、nslookup)${RESET}\n"
yum install -y bind-utils
printf "\n${CYAN}>>>> install whois${RESET}\n"
yum install -y whois

# 下载工具
printf "\n${CYAN}>>>> install curl${RESET}\n"
yum install -y curl
printf "\n${CYAN}>>>> install wget${RESET}\n"
yum install -y wget

# 编辑工具
printf "\n${CYAN}>>>> install emacs${RESET}\n"
yum install -y emacs
printf "\n${CYAN}>>>> install vim${RESET}\n"
yum install -y vim

# 流量工具
printf "\n${CYAN}>>>> install iftop${RESET}\n"
yum install -y iftop
printf "\n${CYAN}>>>> install nethogs${RESET}\n"
yum install -y nethogs

# 抓包工具
printf "\n${CYAN}>>>> install tcpdump${RESET}\n"
yum install -y tcpdump

# 压缩工具
printf "\n${CYAN}>>>> install unzip${RESET}\n"
yum install -y unzip

# 版本控制工具
printf "\n${CYAN}>>>> install git${RESET}\n"
yum install -y git
printf "\n${CYAN}>>>> install subversion${RESET}\n"
yum install -y subversion

printf "\n${GREEN}<<<<<<<< 安装常用命令工具结束${RESET}\n"
