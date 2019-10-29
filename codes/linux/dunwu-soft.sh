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
# 欢迎使用 Dunwu Shell 软件安装脚本
# 适用于 Linux CentOS 环境
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

# print menu
printMenu() {
	printf "${PURPLE}"
	menus=( docker fastdfs gitlab jdk8 jenkins kafka maven mongodb mysql nacos nexus nginx nodejs redis rocketmq tomcat8 zookeeper zsh exit )
	for i in "${!menus[@]}"; do
		index=`expr ${i} + 1`
		val=`expr ${index} % 2`
		printf "[%02d] %-20s" "${index}" "${menus[$i]}"
		if [[ ${val} -eq 0 ]]; then
			printf "\n"
		fi
	done

	printf "\n\n${BLUE}请选择需要安装的软件：${RESET}"
}

# exec shell to install soft
main() {
	printMenu
	read -t 30 index
	if [[ -n ${index} ]]; then
		no=`expr ${index} - 1`
		len=${#menus[*]}
		if [[ ${index} -gt ${len} ]]; then
			printf "${RED}输入项不支持！\n${RESET}"
			exit -1
		fi
		key=${menus[$no]}
		if [[ ${key} == 'exit' ]]; then
			printf "${GREEN}退出 Dunwu 软件安装脚本。\n${RESET}"
			exit 0
		fi
		sh soft/${key}-install.sh
		printf "\n"
		main
	else
		printf "${RED}输入项不支持！\n${RESET}"
		exit -1
	fi
}

######################################## MAIN ########################################
main
