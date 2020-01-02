#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# console color
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"

# 常量
YES=0
NO=1
SUCCEED=0
FAILED=1
# ------------------------------------------------------------------------------

printf "$BLUE"
cat << EOF
################################################################################
# 项目初始化脚本
################################################################################
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

cloneOrFetchGit() {
    root=$1
    group=$2
    project=$3
    branch=$4

    if [[ ! -d "${root}" ]]; then
        printf "${YELLOW}>>>> ${root} is not directory.${RESET}\n"
        return ${FAILED}
    fi

    if [[ ! ${group} ]] || [[ ! ${project} ]] || [[ ! ${branch} ]]; then
        printf "${YELLOW}>>>> group, project, branch must not be empty.${RESET}\n"
        return ${FAILED}
    fi

    source=${root}/${group}/${project}
    printf "${CYAN}>>>> project directory is ${source}.${RESET}\n"
    printf "${CYAN}>>>> git url is ${REPOSITORY}:${group}/${project}.git.${RESET}\n"
    mkdir -p ${root}/${group}

    checkGit ${source}
    if [[ "${YES}" == "$?" ]]; then
        # 如果 ${source} 是 git 项目，执行 pull 操作
        cd ${source} || return ${FAILED}

        git checkout -f ${branch}
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${RED}>>>> git checkout ${branch} failed.${RESET}\n"
            return ${FAILED}
        fi
        printf "${GREEN}>>>> git checkout ${branch} succeed.${RESET}\n"

        git reset --hard
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${RED}>>>> git reset --hard failed.${RESET}\n"
            return ${FAILED}
        fi
        printf "${GREEN}>>>> git reset --hard succeed.${RESET}\n"

        git pull
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${RED}>>>> git pull failed.${RESET}\n"
            return ${FAILED}
        fi
        printf "${GREEN}>>>> git pull succeed.${RESET}\n"
    else
        # 如果 ${source} 不是 git 项目，执行 clone 操作

        git clone "${REPOSITORY}:${group}/${project}.git" ${source}
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${RED}>>>> git clone ${project} failed.${RESET}\n"
            return ${FAILED}
        fi
        printf "${GREEN}>>>> git clone ${project} succeed.${RESET}\n"

        cd ${source} || return ${FAILED}

        git checkout -f ${branch}
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${RED}>>>> git checkout ${branch} failed.${RESET}\n"
            return ${FAILED}
        fi
        printf "${GREEN}>>>> git checkout ${branch} succeed.${RESET}\n"
    fi

    return ${SUCCEED}
}

doCloneOrFetchGit() {
    cloneOrFetchGit $1 $2 $3 $4
    if [[ "$?" == "${SUCCEED}" ]]; then
        printf "\n${GREEN}>>>> Update git project [$2/$3] succeed.${RESET}\n"
        return ${SUCCEED}
    else
        printf "\n${RED}>>>> Update git project [$2/$3] failed.${RESET}\n"
        return ${FAILED}
    fi
}

##################################### MAIN #####################################
ROOT=$(pwd)

# 这里需要根据实际情况替换 Git 仓库、项目组、项目、代码分支
REPOSITORY="git@gitee.com"

printf "${CYAN}Current path is ${ROOT}.${RESET}\n"

doCloneOrFetchGit ${ROOT} turnon linux-tutorial master
r1=$?
doCloneOrFetchGit ${ROOT} turnon nginx-tutorial master
r2=$?

if [[ "${r1}" == "${SUCCEED}" && "${r2}" == "${SUCCEED}" ]]; then
    printf "\n${GREEN}Succeed.${RESET}\n"
    exit ${SUCCEED}
else
    printf "\n${RED}Failed.${RESET}\n"
    exit ${FAILED}
fi

