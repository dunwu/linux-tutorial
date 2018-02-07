#!/usr/bin/env bash

#################################################################################
# 前端应用发布脚本
# Author: Zhang Peng
#################################################################################

# 检查脚本参数，如必要参数未传入，退出脚本。
function checkInput() {
  if [ "${branch}" == "" ]; then
    echo "请输入脚本参数：branch"
    echo "    branch: git分支（必填）。如 feature/1.1.16, master"
    echo "例：./js-app-release.sh feature/1.1.16"
    exit 0
  fi
}

# 检查文件是否存在，不存在则退出脚本
function checkFileExist() {
  if [ ! -f "$1" ]
  then
    echo "关键文件 $1 找不到，脚本执行结束"
    exit 0
  fi
}

# 检查文件夹是否存在，不存在则创建
function createFolderIfNotExist() {
  if [ ! -d "$1" ];then
    mkdir -p "$1"
  fi
}
##############################__MAIN__########################################
# 设置全局常量
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
SOURCE_DIR=/home/zp/source/
APP_NAME=XXX
UPDATE_CODE_SCRIPT_FILE=${SCRIPT_DIR}/update-code.sh

# 0. 获取传入参数并检查
branch=`echo $1`
profile=`echo $2`
checkInput
checkFileExist ${UPDATE_CODE_SCRIPT_FILE}
createFolderIfNotExist ${SOURCE_DIR}

echo ">>>>>>>>>>>>>> 1. 停止应用"
# 有则加，无则过

echo ">>>>>>>>>>>>>> 2. 更新代码"
${UPDATE_CODE_SCRIPT_FILE} ${APP_NAME} ${branch} ${SOURCE_DIR}
execode=$?
if [ "${execode}" == "0" ]; then
  echo "更新代码成功"
else
  echo "更新代码失败"
  exit 1
fi

echo ">>>>>>>>>>>>>> 3. 替换配置"
# 有则加，无则过

echo ">>>>>>>>>>>>>> 4. 构建启动"
cd ${SOURCE_DIR}/${APP_NAME}
source "${HOME}/.nvm/nvm.sh"
nvm use 8.9
npm install
npm run build
