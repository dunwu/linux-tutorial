#!/usr/bin/env bash

###################################################################################
# 安装基本的命令工具
# Author: Zhang Peng
#
# 如果不知道某个命令工具是由哪个包提供的，使用 yum provides xxx
# 或 yum whatprovides xxx 来查找
###################################################################################

###################################################################################
# 执行本脚本后支持的命令工具
# 核心工具：df、du、chkconfig
# 网络工具：ifconfig、netstat、route
# IP工具：ip、ss、ping、tracepath、traceroute
# DNS工具：dig、host、nslookup、whois
# 端口工具：lsof、nc、telnet
# 下载工具：curl、wget
# 防火墙工具：iptables
# 编辑工具：emacs、vim
# 流量工具：iftop、nethogs
# 抓包工具：tcpdump
###################################################################################
# 核心工具
echo -e "\n>>>>>>>>> install coreutils(df、du)"
yum install -y coreutils
echo -e "\n>>>>>>>>> install chkconfig"
yum install -y chkconfig

# 网络工具
echo -e "\n>>>>>>>>> install net-tools(ifconfig、netstat、route)"
yum install -y net-tools

# IP工具
echo -e "\n>>>>>>>>> install iputils(ping、tracepath)"
yum install -y iputils
echo -e "\n>>>>>>>>> install traceroute"
yum install -y traceroute
echo -e "\n>>>>>>>>> install iproute(ip、ss)"
yum install -y iproute

# 端口工具
echo -e "\n>>>>>>>>> install lsof"
yum install -y lsof
echo -e "\n>>>>>>>>> install nc"
yum install -y nc
echo -e "\n>>>>>>>>> install netstat"
yum install -y netstat

# DNS工具
echo -e "\n>>>>>>>>> install bind-utils(dig、host、nslookup)"
yum install -y bind-utils
echo -e "\n>>>>>>>>> install whois"
yum install -y whois

# 下载工具
echo -e "\n>>>>>>>>> install curl"
yum install -y curl
echo -e "\n>>>>>>>>> install wget"
yum install -y wget

# 防火墙工具
echo -e "\n>>>>>>>>> install iptables"
yum install -y iptables

# 编辑工具
echo -e "\n>>>>>>>>> install emacs"
yum install -y emacs
echo -e "\n>>>>>>>>> install vim"
yum install -y vim

# 流量工具
echo -e "\n>>>>>>>>> install iftop"
yum install -y iftop
echo -e "\n>>>>>>>>> install nethogs"
yum install -y nethogs

# 抓包工具
echo -e "\n>>>>>>>>> install tcpdump"
yum install -y tcpdump
