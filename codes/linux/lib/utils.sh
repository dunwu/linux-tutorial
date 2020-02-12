#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Shell Utils
# @author Zhang Peng
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ 颜色状态

# Regular Color
export C_BLACK="\033[0;30m"
export C_RED="\033[0;31m"
export C_GREEN="\033[0;32m"
export C_YELLOW="\033[0;33m"
export C_BLUE="\033[0;34m"
export C_MAGENTA="\033[0;35m"
export C_CYAN="\033[0;36m"
export C_WHITE="\033[0;37m"

# Bold Color
export C_B_BLACK="\033[1;30m"
export C_B_RED="\033[1;31m"
export C_B_GREEN="\033[1;32m"
export C_B_YELLOW="\033[1;33m"
export C_B_BLUE="\033[1;34m"
export C_B_MAGENTA="\033[1;35m"
export C_B_CYAN="\033[1;36m"
export C_B_WHITE="\033[1;37m"

# Underline Color
export C_U_BLACK="\033[4;30m"
export C_U_RED="\033[4;31m"
export C_U_GREEN="\033[4;32m"
export C_U_YELLOW="\033[4;33m"
export C_U_BLUE="\033[4;34m"
export C_U_MAGENTA="\033[4;35m"
export C_U_CYAN="\033[4;36m"
export C_U_WHITE="\033[4;37m"

# Background Color
export C_BG_BLACK="\033[40m"
export C_BG_RED="\033[41m"
export C_BG_GREEN="\033[42m"
export C_BG_YELLOW="\033[43m"
export C_BG_BLUE="\033[44m"
export C_BG_MAGENTA="\033[45m"
export C_BG_CYAN="\033[46m"
export C_BG_WHITE="\033[47m"

# Reset Color
export C_RESET="$(tput sgr0)"

# ------------------------------------------------------------------------------ 常用状态值

export YES=0
export NO=1
export SUCCEED=0
export FAILED=1

# ------------------------------------------------------------------------------ 常用状态值

# 显示打印日志的时间
DATE=$(date "+%Y-%m-%d %H:%M:%S")
# 那个用户在操作
USER=$(whoami)
# 日志路径
LOG_DIR=/var/log/dunwu
LOG_PATH=${LOG_DIR}/shell.log

createLogFileIfNotExists() {
    if [[ ! -f "${LOG_PATH}" ]]; then
    sudo mkdir -p "${LOG_DIR}"
    touch "${LOG_PATH}"
    fi
}

logInfo() {
    echo -e "${C_B_GREEN}[INFO] $@${C_RESET}"
    createLogFileIfNotExists
    echo "[${DATE}] [${USER}] [INFO] [$0] [$@] execute succeed." >> "${LOG_PATH}"
}

logWarn() {
    echo -e "${C_B_YELLOW}[WARN] $@${C_RESET}"
    createLogFileIfNotExists
    echo "[${DATE}] [${USER}] [WARN] [$0] [$@] execute succeed." >> "${LOG_PATH}"
}

logError() {
    echo -e "${C_B_RED}[ERROR] $@${C_RESET}"
    createLogFileIfNotExists
    echo "[${DATE}] [${USER}] [ERROR] [$0] [$@] execute failed." >> "${LOG_PATH}"
}

printInfo() {
    echo -e "${C_B_GREEN}[INFO] $@${C_RESET}"
}

printWarn() {
    echo -e "${C_B_YELLOW}[WARN] $@${C_RESET}"
}

printError() {
    echo -e "${C_B_RED}[ERROR] $@${C_RESET}"
}

callAndLog () {
    $*
    if [[ $? -eq ${SUCCEED} ]]; then
        logInfo "$@ succeed"
        echo -e "${C_B_GREEN}[INFO] [$0] [$@] execute succeed.${C_RESET}"
        return ${SUCCEED}
    else
        logError "$@ failed"
        echo -e "${C_B_RED}[ERROR] [$0] [$@] execute failed.${C_RESET}"
        return ${FAILED}
    fi
}
