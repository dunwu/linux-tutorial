#!/usr/bin/env bash

# ----------------------------------------------------------------------------------
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
# ----------------------------------------------------------------------------------

printf "${PURPLE}"
cat << EOF
# ----------------------------------------------------------------------------------
# Arthas 安装脚本
# @author: Zhang Peng
# ----------------------------------------------------------------------------------
EOF
printf "${RESET}"

printf "${BLUE}>>>>>>>> begin.\n${RESET}"

root=/opt/arthas
if [[ -n $1 ]]; then
	root=$1
fi

mkdir -p ${root}
curl -o ${root}/arthas-boot.jar https://alibaba.github.io/arthas/arthas-boot.jar

printf "${GREEN}[OK]\n${RESET}"
printf "${BLUE}<<<<<<<< end.\n${RESET}"
