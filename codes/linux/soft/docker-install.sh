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
# 安装 Jenkins 脚本
# 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF
printf "${RESET}"

printf "${BLUE}>>>>>>>> install jenkins${RESET}\n"

# 下载并解压 jenkins
mkdir -p /opt/jenkins
curl -o /opt/jenkins/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war

printf "${GREEN}<<<<<<<< install jenkins${RESET}\n"
