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
# XXX 脚本
# @author: Zhang Peng
# ----------------------------------------------------------------------------------
EOF
printf "${RESET}"

printf "${BLUE}>>>>>>>> begin.\n${RESET}"

printf "${GREEN}[OK]\n${RESET}"
printf "${RED}[ERROR]\n${RESET}"

printf "${BLUE}<<<<<<<< end.\n${RESET}"

IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/'`
