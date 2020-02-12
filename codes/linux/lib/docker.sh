#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# 构建 Docker 镜像 脚本
# @author Zhang Peng
# @since 2020/1/14
# ------------------------------------------------------------------------------

# 装载其它库
LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`
source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh

dockerBuild() {
    if [[ ! $1 ]] || [[ ! $2 ]] || [[ ! $3 ]]; then
        logError "you must input following params in order:"
        echo -e "${C_B_RED}"
        echo "    (1) source"
        echo "    (2) repository"
        echo "    (3) tag"
        echo -e "\nEg. dockerBuild /home/workspace dunwu/dockerApp 0.0.1"
        echo -e "${C_RESET}"
        return ${FAILED}
    fi

    local source=$1
    local repository=$2
    local tag=$3

    dockerCheck ${source}
    if [[ "${SUCCEED}" != "$?" ]]; then
        return ${FAILED}
    fi

    cd ${source}
    callAndLog docker build -t ${repository}:${tag} .
    if [[ "${SUCCEED}" != "$?" ]]; then
        logError "docker build -t ${repository}:${tag} failed"
        return ${FAILED}
    fi

    cd -
}

dockerPush() {
    if [[ ! $1 ]] || [[ ! $2 ]]; then
        logError "you must input following params in order:"
        echo -e "${C_B_RED}"
        echo "    (1) repository"
        echo "    (2) tag"
        echo -e "\nEg. dockerBuild dunwu/dockerApp 0.0.1"
        echo -e "${C_RESET}"
        return ${FAILED}
    fi

    local repository=$1
    local tag=$2

    # 如果 docker 镜像已存在，则删除镜像
    local dockerHashId=$(docker image ls | grep ${repository} | grep ${tag} | awk '{print $3}')
    if [[ ! ${dockerHashId} ]]; then
        logInfo "try to delete existed image: ${repository}:${tag}"
        callAndLog docker rmi ${dockerHashId}
    fi

    logInfo "try to push new image: ${repository}:${tag}"
    callAndLog docker push ${repository}:${tag}
}

# 判断指定路径下是否为 docker 工程
# @param $1: 第一个参数为 docker 项目路径
dockerCheck() {
    local source=$1
    if [[ -d "${source}" ]]; then
        cd ${source}
        if [[ -f "${source}/Dockerfile" ]]; then
            return ${YES}
        else
            logError "Dockerfile is not exists"
            return ${NO}
        fi
        cd -
        return ${YES}
    else
        logError "${source} is not valid docker project"
        return ${NO}
    fi
}
