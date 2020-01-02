#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ASCII 颜色变量
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="\033[0m"

# 常量
YES=0
NO=1
# ------------------------------------------------------------------------------

printf "$BLUE"
cat << EOF
# ------------------------------------------------------------------------------
# 检查当前目录是否为 git 工程
# ------------------------------------------------------------------------------
EOF
printf "$RESET"

# 检查指定的路径是不是一个 git 项目
checkGit() {
  source=$1
  if [[ -d "${source}" ]]; then
      cd ${source} || return ${NO}
      # （1）删除git状态零时文件
      if [[ -f "gitstatus.tmp" ]]; then
        rm -rf gitstatus.tmp
      fi

      # （2）判断是否存在 .git 目录
      if [[ -d "./.git" ]]; then
        # （3）判断git是否可用
        git status &> gitstatus.tmp
        gitStatus=false
        grep -iwq 'not a git repository' gitstatus.tmp && gitStatus=false || gitStatus=true
        rm -rf gitstatus.tmp
        if [[ ${gitStatus} == true ]]; then
            return ${YES}
        else
            return ${NO}
        fi
      fi
  fi
  return ${NO}
}

##################################### MAIN #####################################
ROOT=$(pwd)
printf "${BLUE}当前目录为：${ROOT} ${RESET}\n"

checkGit ${ROOT}
if [[ "${YES}" == "$?" ]]; then
    printf "${GREEN}${ROOT} 是 git 工程。${RESET}\n"
    exit ${YES}
else
    printf "${RED}${ROOT} 不是 git 工程。${RESET}\n"
    exit ${NO}
fi
