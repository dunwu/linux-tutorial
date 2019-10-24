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
# 安装常见 lib
# 如果不知道命令在哪个 lib，可以使用 yum search xxx 来查找
# lib 清单如下：
# gcc gcc-c++ kernel-devel libtool
# openssl openssl-devel
# zlib zlib-devel
# pcre
#
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

printf "\n${GREEN}>>>>>>>>> 安装常见 lib 开始${RESET}\n"

printf "\n${CYAN}>>>> install gcc gcc-c++ kernel-devel libtool${RESET}\n"
yum -y install make gcc gcc-c++ kernel-devel libtool

printf "\n${CYAN}>>>> install openssl openssl-devel${RESET}\n"
yum -y install make openssl openssl-devel

printf "\n${CYAN}>>>> install zlib zlib-devel${RESET}\n"
yum -y install make zlib zlib-devel

printf "\n${CYAN}>>>> install pcre${RESET}\n"
yum -y install pcre

printf "\n${GREEN}<<<<<<<< 安装常见 lib 结束${RESET}\n"
