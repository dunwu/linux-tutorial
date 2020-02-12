#!/usr/bin/env bash

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
# 欢迎使用 Dunwu Shell 运维脚本
# 适用于 Linux CentOS 环境
# @author: Zhang Peng
###################################################################################
EOF
printf "${C_RESET}\n"
}

# 打印尾部信息
printFootInfo() {
printf "${C_B_BLUE}\n"
cat << EOF
###################################################################################
# 脚本执行结束，感谢使用！
###################################################################################
EOF
printf "${C_RESET}\n"
}

# 检查操作系统环境
checkOsVersion() {
	if (($1 == 1)); then
		platform=`uname -i`
		if [[ ${platform} != "x86_64" ]]; then
			logError "脚本仅支持 64 位操作系统！"
			exit 1
		fi

		version=`cat /etc/redhat-release | awk '{print substr($4,1,1)}'`
		if [[ ${version} != 7 ]]; then
			logError "脚本仅支持 CentOS 7！"
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
			logWarn "输入项不支持！"
			selectAndExecTask ;;
	esac
	break
	done
}


# ------------------------------------------------------------------------------ main

checkOsVersion 1
selectAndExecTask
