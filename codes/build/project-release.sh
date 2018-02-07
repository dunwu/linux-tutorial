#!/usr/bin/env bash

###################################################################################
# 项目发布脚本模板
# Author: Zhang Peng
###################################################################################

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

function chooseAppName() {
cat << EOF
请选择应用名（数字或关键字均可）。
可选值如下：
    [0] all （所有应用）
    [1] APP1
    [2] APP2
EOF

while read app
do
  case ${app} in
    0 )
      app=all
      break ;;
    1 )
      app=APP1
      break ;;
    2 )
      app=APP2
      break ;;
    all | APP1 | APP2 )
      break ;;
    * ) echo "无法识别 ${app}" ;;
  esac
done
}

function chooseBranch() {
cat << EOF
请输入 git 分支。
如：develop、master、feature/xxx
EOF

read branch
if [[ "${branch}" =~ ^(feature/)([^ \f\n\r\t\v]+) ]] || [ "${branch}" == "develop" ] || [ "${branch}" == "master" ]; then
  echo "输入了 ${branch}"
else
  echo "无法识别 ${branch}"
  chooseBranch
fi
}

function chooseProfile() {
cat << EOF
请选择运行环境（数字或关键字均可）。
可选值：
    [1] develop (开发环境)
    [2] test (测试环境)
    [3] preview (预发布环境)
    [4] product (生产环境)
EOF

while read profile
do
  case ${profile} in
    1 )
      profile=develop
      break ;;
    2 )
      profile=test
      break ;;
    3 )
      profile=preview
      break ;;
    4 )
      profile=product
      break ;;
    develop | test | preview | product )
      break ;;
    * ) echo "无法识别 ${profile}" ;;
  esac
done
}

function inputParams() {
  chooseAppName
  chooseBranch
  chooseProfile

cat << EOF
===================================================
请确认您的选择：Y/N
    app: ${app}
    branch: ${branch}
    profile: ${profile}
===================================================
EOF

  while read confirm
  do
    case ${confirm} in
      y | Y )
        echo -e "\n\n>>>>>>>>>>>>>> 开始发布应用"
        break ;;
      n | N )
        echo -e "重新输入发布参数\n"
        inputParams ;;
      * )
        echo "无法识别 ${confirm}" ;;
    esac
  done
}

function printHeadInfo() {
cat << EOF
***********************************************************************************
* 欢迎使用项目引导式发布脚本。
* 输入任意键进入脚本操作。
***********************************************************************************
EOF
}

function printFootInfo() {
cat << EOF


***********************************************************************************
* 安装过程结束。
* 输入任意键进入脚本操作。
* 如果不想安装其他应用，输入 exit 回车或输入 <CTRL-C> 退出。
***********************************************************************************
EOF
}

function main() {
  # 输入执行参数
  app=""
  branch=""
  profile=""
  inputParams

  if [ "${app}" == "all" ]; then
    checkFileExist ${SCRIPT_DIR}/java-app-release.sh
    checkFileExist ${SCRIPT_DIR}/js-app-release.sh
    ${SCRIPT_DIR}/io-alch-release.sh ${branch} ${profile}
    ${SCRIPT_DIR}/ck-alch-release.sh ${branch} ${profile}
  else
    checkFileExist ${SCRIPT_DIR}/${app}-release.sh
    ${SCRIPT_DIR}/${app}-release.sh ${branch} ${profile}
  fi
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"

# 设置全局常量
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)
SOURCE_DIR=/home/zp/source/
# 如果源码存放目录不存在则创建
createFolderIfNotExist ${SOURCE_DIR}

printHeadInfo
while read sign
do
  case ${sign} in
    exit )
      exit 0 ;;
    * )
      main ;;
  esac

  printFootInfo
done
