#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# CentOS 常用软件一键安装脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ libs
# 装载其它库
LINUX_SCRIPTS_DIR=$(cd `dirname $0`; pwd)

if [[ ! -x ${LINUX_SCRIPTS_DIR}/lib/utils.sh ]]; then
    logError "必要脚本库 ${LINUX_SCRIPTS_DIR}/lib/utils.sh 不存在！"
    exit 1
fi

source ${LINUX_SCRIPTS_DIR}/lib/utils.sh

# ------------------------------------------------------------------------------ functions
# 打印头部信息
printHeadInfo() {
printf "${C_B_BLUE}\n"
cat << EOF
###################################################################################
# 欢迎使用 CentOS 常用软件一键安装脚本
# 适用于 Linux CentOS 环境
# @author: Zhang Peng
###################################################################################
EOF
printf "${C_RESET}\n"
}

# print menu
printMenu() {
	printf "${C_B_MAGENTA}"
	menus=( docker fastdfs gitlab jdk8 jenkins kafka maven mongodb mysql nacos nexus nginx nodejs redis rocketmq tomcat8 zookeeper zsh exit )
	for i in "${!menus[@]}"; do
		index=`expr ${i} + 1`
		val=`expr ${index} % 2`
		printf "[%02d] %-20s" "${index}" "${menus[$i]}"
		if [[ ${val} -eq 0 ]]; then
			printf "\n"
		fi
	done

	printf "\n\n${C_B_BLUE}请选择需要安装的软件：${C_RESET}"
}

# exec shell to install soft
main() {
	printMenu
	read -t 30 index
	if [[ -n ${index} ]]; then
		no=`expr ${index} - 1`
		len=${#menus[*]}
		if [[ ${index} -gt ${len} ]]; then
			logWarn "输入项不支持！"
			exit 1
		fi
		key=${menus[$no]}
		if [[ ${key} == 'exit' ]]; then
			logInfo "退出软件安装脚本。"
			exit 0
		fi
		sh soft/${key}-install.sh
		printf "\n"
		main
	else
		logWarn "输入项不支持！"
		exit 1
	fi
}

# ------------------------------------------------------------------------------ main

printHeadInfo
main
