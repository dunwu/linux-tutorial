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
# 欢迎使用 Dunwu Shell 环境初始化脚本（设置环境配置、安装基本的命令工具）
# 适用于 Linux CentOS 环境
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

menus=( "替换yum镜像" "安装基本的命令工具" "安装常用libs" "系统配置" "全部执行" "退出" )
main() {
    PS3="请输入命令编号："
    select item in "${menus[@]}"
    do
    case ${item} in
	"替换yum镜像")
		sh ${root}/sys/change-yum-repo.sh
		main ;;
	"安装基本的命令工具")
		sh ${root}/sys/install-tools.sh
		main ;;
	"安装常用libs")
		sh ${root}/sys/install-libs.sh
		main ;;
	"系统配置")
		sh ${root}/sys/sys-settings.sh ${root}/sys
		main ;;
	"全部执行")
		sh ${root}/sys/change-yum-repo.sh
		sh ${root}/sys/install-tools.sh
		sh ${root}/sys/install-libs.sh
		sh ${root}/sys/sys-settings.sh ${root}/sys
		printf "${GREEN}执行完毕，退出。${RESET}\n" ;;
	"退出")
		exit 0 ;;
	*)
		printf "${RED}输入项不支持！${RESET}\n"
		main ;;
    esac
    break
    done
}

######################################## MAIN ########################################
root=$(pwd)
main
