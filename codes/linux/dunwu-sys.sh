#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# CentOS 环境初始化脚本
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
# 欢迎使用 Dunwu Shell 环境初始化脚本（设置环境配置、安装基本的命令工具）
# 适用于 Linux CentOS 环境
# @author: Zhang Peng
###################################################################################
EOF
printf "${C_RESET}\n"
}

menus=( "替换yum镜像" "安装基本的命令工具" "安装常用libs" "系统配置" "全部执行" "退出" )
main() {
	PS3="请输入命令编号："
	select item in "${menus[@]}"
	do
	case ${item} in
		"替换yum镜像")
			sh ${LINUX_SCRIPTS_DIR}/sys/change-yum-repo.sh
			main ;;
		"安装基本的命令工具")
			sh ${LINUX_SCRIPTS_DIR}/sys/install-tools.sh
			main ;;
		"安装常用libs")
			sh ${LINUX_SCRIPTS_DIR}/sys/install-libs.sh
			main ;;
		"系统配置")
			sh ${LINUX_SCRIPTS_DIR}/sys/sys-settings.sh ${LINUX_SCRIPTS_DIR}/sys
			main ;;
		"全部执行")
			sh ${LINUX_SCRIPTS_DIR}/sys/change-yum-repo.sh
			sh ${LINUX_SCRIPTS_DIR}/sys/install-tools.sh
			sh ${LINUX_SCRIPTS_DIR}/sys/install-libs.sh
			sh ${LINUX_SCRIPTS_DIR}/sys/sys-settings.sh ${LINUX_SCRIPTS_DIR}/sys
			logInfo "执行完毕，退出" ;;
		"退出")
			exit 0 ;;
		*)
			logWarn "输入项不支持！"
			main ;;
	esac
	break
	done
}

# ------------------------------------------------------------------------------ main

printHeadInfo
main
