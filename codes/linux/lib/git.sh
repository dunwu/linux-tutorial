#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Git 基本操作脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# 装载其它库
LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`

if [[ ! -x ${LINUX_SCRIPTS_LIB_DIR}/utils.sh ]]; then
    logError "必要脚本库 ${LINUX_SCRIPTS_LIB_DIR}/utils.sh 不存在！"
    exit 1
fi

source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh

# ------------------------------------------------------------------------------ git 操作函数

GIT_LOCAL_BRANCH=
getGitLocalBranch() {
    GIT_LOCAL_BRANCH=$(git symbolic-ref -q --short HEAD)
}

GIT_ORIGIN_BRANCH=
getGitOriginBranch() {
    GIT_ORIGIN_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}")
}

# 检查指定的路径是不是一个 git 项目
checkGit() {
    local source=$1
    if [[ -d "${source}" ]]; then
        cd ${source} || return ${NO}
        # （1）删除git状态零时文件
        if [[ -f "gitstatus.tmp" ]]; then
        rm -rf gitstatus.tmp
        fi

        # （2）判断git是否可用
        git status &> gitstatus.tmp
        local gitStatus=false
        grep -iwq 'not a git repository' gitstatus.tmp && gitStatus=false || gitStatus=true
        rm -rf gitstatus.tmp
        if [[ ${gitStatus} == true ]]; then
            return ${YES}
        else
            return ${NO}
        fi

        return ${NO}
    fi

    logError "${source} is invalid dir."
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
        logError "Please input root, group, project, branch."
        return ${FAILED}
    fi

    if [[ ! -d "${root}" ]]; then
        logError "${root} is not directory."
        return ${FAILED}
    fi

    local source=${root}/${group}/${project}
    logInfo "project directory is ${source}."
    logInfo "git url is ${repository}:${group}/${project}.git."
    mkdir -p ${root}/${group}

    checkGit ${source}
    if [[ "${YES}" == "$?" ]]; then
        # 如果 ${source} 是 git 项目，执行 pull 操作
        cd ${source} || return ${FAILED}

        git checkout -f ${branch}
        if [[ "${SUCCEED}" != "$?" ]]; then
            logError "<<<< git checkout ${branch} failed."
            return ${FAILED}
        fi
        logInfo "git checkout ${branch} succeed."

        getGitOriginBranch
        git fetch --all
        git reset --hard ${GIT_ORIGIN_BRANCH}
        if [[ "${SUCCEED}" != "$?" ]]; then
            logError "<<<< git reset --hard ${GIT_ORIGIN_BRANCH} failed."
            return ${FAILED}
        fi
        logInfo "git reset --hard ${GIT_ORIGIN_BRANCH} succeed."

        git pull
        if [[ "${SUCCEED}" != "$?" ]]; then
            logError "<<<< git pull failed."
            return ${FAILED}
        fi
        logInfo "git pull succeed."
    else
        # 如果 ${source} 不是 git 项目，执行 clone 操作

        git clone "${repository}:${group}/${project}.git" ${source}
        if [[ "${SUCCEED}" != "$?" ]]; then
            logError "<<<< git clone ${project} failed."
            return ${FAILED}
        fi
        logInfo "git clone ${project} succeed."

        cd ${source} || return ${FAILED}

        git checkout -f ${branch}
        if [[ "${SUCCEED}" != "$?" ]]; then
            logError "<<<< git checkout ${branch} failed."
            return ${FAILED}
        fi
        logInfo "git checkout ${branch} succeed."
    fi

    logInfo "Clone or pull git project [$2/$3:$4] succeed."
    return ${SUCCEED}
}
