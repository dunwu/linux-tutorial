#!/usr/bin/env bash

###################################################################################
# 安装常见 lib
# @author: Zhang Peng
#
# 如果不知道某个命令工具是由哪个包提供的，使用 yum provides xxx
# 或 yum whatprovides xxx 来查找
###################################################################################

###################################################################################
# 执行本脚本后支持的 lib 清单：
# gcc gcc-c++ kernel-devel libtool
# openssl openssl-devel
# zlib zlib-devel
# pcre
###################################################################################

echo -e "\n>>>>>>>>> install gcc gcc-c++ kernel-devel libtool"
yum -y install make gcc gcc-c++ kernel-devel libtool

echo -e "\n>>>>>>>>> install openssl openssl-devel"
yum -y install make openssl openssl-devel

echo -e "\n>>>>>>>>> install zlib zlib-devel"
yum -y install make zlib zlib-devel

echo -e "\n>>>>>>>>> install pcre"
yum -y install pcre
