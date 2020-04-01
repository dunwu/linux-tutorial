#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# myapp 启动脚本，用于【虚拟机环境】
# @author Zhang Peng
# -----------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------ libs

SCRIPTS_DIR=$(dirname ${BASH_SOURCE[0]})
if [[ ! -x ${SCRIPTS_DIR}/lifecycle.sh ]]; then
    logError "${SCRIPTS_DIR}/lifecycle.sh not exists!"
    exit 1
fi
source ${SCRIPTS_DIR}/lifecycle.sh


# ------------------------------------------------------------------------------ main

APP_DIR=$(cd `dirname $0`/..; pwd)

export LANG="zh_CN.UTF-8"
APP=myapp
JAR_PATH=${APP_DIR}/myapp.jar
LIB_PATH=${APP_DIR}/lib
CONF_PATH=${APP_DIR}/config
LOG_DIR=/var/log/dunwu
PORT=8888
PROFILE=prod
DEBUG=off

declare -a serial
serial=(on off)
echo -n "是否启动 debug 模式（可选值：on|off）："
read DEBUG
if ! echo ${serial[@]} | grep -q ${DEBUG}; then
  echo "是否启动 debug 模式（可选值：on|off）"
  exit 1
fi

startServer ${JAR_PATH} ${LIB_PATH} ${CONF_PATH} ${LOG_DIR} ${APP} ${PORT} ${PROFILE} ${DEBUG}
