#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# 应用启动脚本
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

export LANG="zh_CN.UTF-8"
stopServer myapp
