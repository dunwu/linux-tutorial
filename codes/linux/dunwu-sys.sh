#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# CentOS 环境初始化脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ env

# Regular Color
export ENV_COLOR_BLACK="\033[0;30m"
export ENV_COLOR_RED="\033[0;31m"
export ENV_COLOR_GREEN="\033[0;32m"
export ENV_COLOR_YELLOW="\033[0;33m"
export ENV_COLOR_BLUE="\033[0;34m"
export ENV_COLOR_MAGENTA="\033[0;35m"
export ENV_COLOR_CYAN="\033[0;36m"
export ENV_COLOR_WHITE="\033[0;37m"
# Bold Color
export ENV_COLOR_B_BLACK="\033[1;30m"
export ENV_COLOR_B_RED="\033[1;31m"
export ENV_COLOR_B_GREEN="\033[1;32m"
export ENV_COLOR_B_YELLOW="\033[1;33m"
export ENV_COLOR_B_BLUE="\033[1;34m"
export ENV_COLOR_B_MAGENTA="\033[1;35m"
export ENV_COLOR_B_CYAN="\033[1;36m"
export ENV_COLOR_B_WHITE="\033[1;37m"
# Underline Color
export ENV_COLOR_U_BLACK="\033[4;30m"
export ENV_COLOR_U_RED="\033[4;31m"
export ENV_COLOR_U_GREEN="\033[4;32m"
export ENV_COLOR_U_YELLOW="\033[4;33m"
export ENV_COLOR_U_BLUE="\033[4;34m"
export ENV_COLOR_U_MAGENTA="\033[4;35m"
export ENV_COLOR_U_CYAN="\033[4;36m"
export ENV_COLOR_U_WHITE="\033[4;37m"
# Background Color
export ENV_COLOR_BG_BLACK="\033[40m"
export ENV_COLOR_BG_RED="\033[41m"
export ENV_COLOR_BG_GREEN="\033[42m"
export ENV_COLOR_BG_YELLOW="\033[43m"
export ENV_COLOR_BG_BLUE="\033[44m"
export ENV_COLOR_BG_MAGENTA="\033[45m"
export ENV_COLOR_BG_CYAN="\033[46m"
export ENV_COLOR_BG_WHITE="\033[47m"
# Reset Color
export ENV_COLOR_RESET="$(tput sgr0)"

# status
export ENV_YES=0
export ENV_NO=1
export ENV_SUCCEED=0
export ENV_FAILED=1


# ------------------------------------------------------------------------------ functions

# 显示打印日志的时间
SHELL_LOG_TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
# 那个用户在操作
USER=$(whoami)
# 日志路径
LOG_PATH=${ENV_LOG_PATH:-/var/log/shell.log}
# 日志目录
LOG_DIR=${LOG_PATH%/*}

createLogFileIfNotExists() {
    if [[ ! -x "${LOG_PATH}" ]]; then
    mkdir -p "${LOG_DIR}"
    touch "${LOG_PATH}"
    fi
}

redOutput() {
    echo -e "${ENV_COLOR_RED} $@${ENV_COLOR_RESET}"
}
greenOutput() {
    echo -e "${ENV_COLOR_B_GREEN} $@${ENV_COLOR_RESET}"
}
yellowOutput() {
    echo -e "${ENV_COLOR_YELLOW} $@${ENV_COLOR_RESET}"
}
blueOutput() {
    echo -e "${ENV_COLOR_BLUE} $@${ENV_COLOR_RESET}"
}
magentaOutput() {
    echo -e "${ENV_COLOR_MAGENTA} $@${ENV_COLOR_RESET}"
}
cyanOutput() {
    echo -e "${ENV_COLOR_CYAN} $@${ENV_COLOR_RESET}"
}
whiteOutput() {
    echo -e "${ENV_COLOR_WHITE} $@${ENV_COLOR_RESET}"
}

logInfo() {
    echo -e "${ENV_COLOR_B_GREEN}[INFO] $@${ENV_COLOR_RESET}"
    createLogFileIfNotExists
    echo "[${SHELL_LOG_TIMESTAMP}] [${USER}] [INFO] [$0] $@" >> "${LOG_PATH}"
}
logWarn() {
    echo -e "${ENV_COLOR_B_YELLOW}[WARN] $@${ENV_COLOR_RESET}"
    createLogFileIfNotExists
    echo "[${SHELL_LOG_TIMESTAMP}] [${USER}] [WARN] [$0] $@" >> "${LOG_PATH}"
}
logError() {
    echo -e "${ENV_COLOR_B_RED}[ERROR] $@${ENV_COLOR_RESET}"
    createLogFileIfNotExists
    echo "[${SHELL_LOG_TIMESTAMP}] [${USER}] [ERROR] [$0] $@" >> "${LOG_PATH}"
}

printInfo() {
    echo -e "${ENV_COLOR_B_GREEN}[INFO] $@${ENV_COLOR_RESET}"
}
printWarn() {
    echo -e "${ENV_COLOR_B_YELLOW}[WARN] $@${ENV_COLOR_RESET}"
}
printError() {
    echo -e "${ENV_COLOR_B_RED}[ERROR] $@${ENV_COLOR_RESET}"
}

callAndLog () {
    $*
    if [[ $? -eq ${ENV_SUCCEED} ]]; then
        logInfo "$@"
        return ${ENV_SUCCEED}
    else
        logError "$@ EXECUTE FAILED"
        return ${ENV_FAILED}
    fi
}

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

LINUX_SCRIPTS_DIR=$(cd `dirname $0`; pwd)
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
