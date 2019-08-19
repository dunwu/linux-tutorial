#!/usr/bin/env bash

###################################################################################
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
###################################################################################

printf "${BLUE}"
cat << EOF

###################################################################################
# 安装 sonatype nexus(用于搭建 maven 私服) 脚本
# @system: 适用于所有 linux 发行版本。
# sonatype nexus 会被安装到 /opt/maven 路径。
# 注意：sonatype nexus 要求必须先安装 JDK
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install nexus begin.${RESET}\n"

mkdir -p /opt/maven
cd /opt/maven

version=3.13.0-01
curl -o /opt/maven/nexus-unix.tar.gz http://download.sonatype.com/nexus/3/nexus-${version}-unix.tar.gz
tar -zxf nexus-unix.tar.gz

printf "${GREEN}<<<<<<<< install nexus end.${RESET}\n"
