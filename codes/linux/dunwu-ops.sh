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

# 打印头部信息
printHeadInfo() {
printf "${BLUE}\n"
cat << EOF
###################################################################################
# 欢迎使用 Dunwu Shell 运维脚本
# 适用于 Linux CentOS 环境
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"
}

# 打印尾部信息
printFootInfo() {
printf "${BLUE}\n"
cat << EOF
###################################################################################
# 脚本执行结束，感谢使用！
###################################################################################
EOF
printf "${RESET}\n"
}

# 检查操作系统环境
checkOsVersion() {
    if (($1 == 1)); then
        platform=`uname -i`
        if [[ ${platform} != "x86_64" ]]; then
            printf "\n${RED}脚本仅支持 64 位操作系统！${RESET}\n"
            exit 1
        fi

        version=`cat /etc/redhat-release | awk '{print substr($4,1,1)}'`
        if [[ ${version} != 7 ]]; then
            printf "\n${RED}脚本仅支持 CentOS 7！${RESET}\n"
            exit 1
        fi
    fi
}

menus=( "配置系统" "安装软件" "退出" )
selectAndExecTask() {
	printHeadInfo
    PS3="请输入命令编号："
    select item in "${menus[@]}"
    do
    case ${item} in
	"配置系统")
		./dunwu-sys.sh
		selectAndExecTask ;;
	"安装软件")
		./dunwu-soft.sh
		selectAndExecTask ;;
	"退出")
		printFootInfo
		exit 0 ;;
	*)
		printf "\n${RED}输入项不支持！${RESET}\n"
		selectAndExecTask ;;
    esac
    break
    done
}


######################################## MAIN ########################################
checkOsVersion 1
selectAndExecTask
