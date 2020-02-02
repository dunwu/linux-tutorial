#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Git 基本操作脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# 装载其它库
ROOT=`dirname ${BASH_SOURCE[0]}`
source ${ROOT}/env.sh

# ------------------------------------------------------------------------------ git 操作函数

# 检查指定的路径是不是一个 git 项目
checkGit() {
  local source=$1
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
        local gitStatus=false
        grep -iwq 'not a git repository' gitstatus.tmp && gitStatus=false || gitStatus=true
        rm -rf gitstatus.tmp
        if [[ ${gitStatus} == true ]]; then
            return ${YES}
        else
            return ${NO}
        fi
      fi

      return ${NO}
  fi

  printf "${C_B_YELLOW}${source} is invalid dir.${C_RESET}\n"
  return ${NO}
}

# clone 或 fetch 操作
# 如果本地代码目录已经是 git 仓库，执行 pull；若不是，则执行 clone
# 依次传入 Git 仓库、Git 项目组、Git 项目名、分支、本地代码目录
cloneOrPullGit() {

    local repository=$1
    local group=$2
    local project=$3
    local branch=$4
    local root=$5

    if [[ ! ${repository} ]] || [[ ! ${group} ]] || [[ ! ${project} ]] || [[ ! ${branch} ]] || [[ ! ${root} ]]; then
        printf "${C_B_YELLOW}Please input root, group, project, branch.${C_RESET}\n"
        return ${FAILED}
    fi

    if [[ ! -d "${root}" ]]; then
        printf "${C_B_YELLOW}${root} is not directory.${C_RESET}\n"
        return ${FAILED}
    fi

    local source=${root}/${group}/${project}
    printf "${C_B_MAGENTA}project directory is ${source}.${C_RESET}\n"
    printf "${C_B_MAGENTA}git url is ${repository}:${group}/${project}.git.${C_RESET}\n"
    mkdir -p ${root}/${group}

    checkGit ${source}
    if [[ "${YES}" == "$?" ]]; then
        # 如果 ${source} 是 git 项目，执行 pull 操作
        cd ${source} || return ${FAILED}

        git checkout -f ${branch}
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${C_B_RED}<<<< git checkout ${branch} failed.${C_RESET}\n"
            return ${FAILED}
        fi
        printf "${C_B_GREEN}git checkout ${branch} succeed.${C_RESET}\n"

        git reset --hard
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${C_B_RED}<<<< git reset --hard failed.${C_RESET}\n"
            return ${FAILED}
        fi
        printf "${C_B_GREEN}git reset --hard succeed.${C_RESET}\n"

        git pull
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${C_B_RED}<<<< git pull failed.${C_RESET}\n"
            return ${FAILED}
        fi
        printf "${C_B_GREEN}git pull succeed.${C_RESET}\n"
    else
        # 如果 ${source} 不是 git 项目，执行 clone 操作

        git clone "${repository}:${group}/${project}.git" ${source}
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${C_B_RED}<<<< git clone ${project} failed.${C_RESET}\n"
            return ${FAILED}
        fi
        printf "${C_B_GREEN}git clone ${project} succeed.${C_RESET}\n"

        cd ${source} || return ${FAILED}

        git checkout -f ${branch}
        if [[ "${SUCCEED}" != "$?" ]]; then
            printf "${C_B_RED}<<<< git checkout ${branch} failed.${C_RESET}\n"
            return ${FAILED}
        fi
        printf "${C_B_GREEN}git checkout ${branch} succeed.${C_RESET}\n"
    fi

    printf "${C_B_GREEN}Clone or pull git project [$2/$3:$4] succeed.${C_RESET}\n"
    return ${SUCCEED}
}
