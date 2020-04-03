#!/usr/bin/env bash

LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`
source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh

dockerBuild() {
    if [[ ! $1 ]] || [[ ! $2 ]] || [[ ! $3 ]]; then
        logError "you must input following params in order:"
        echo -e "${ENV_COLOR_B_RED}"
        echo "    (1) source"
        echo "    (2) repository"
        echo "    (3) tag"
        echo -e "\nEg. dockerBuild /home/workspace tdh60dev01:5000/fide/fide-processor fide-0.0.6-SNAPSHOT"
        echo -e "${ENV_COLOR_RESET}"
        return ${ENV_FAILED}
    fi

    local source=$1
    local repository=$2
    local tag=$3

    dockerCheck ${source}
    if [[ "${ENV_SUCCEED}" != "$?" ]]; then
        return ${ENV_FAILED}
    fi

    cd ${source}
    callAndLog docker build -t ${repository}:${tag} .
    if [[ "${ENV_SUCCEED}" != "$?" ]]; then
        logError "docker build -t ${repository}:${tag} failed"
        return ${ENV_FAILED}
    fi

    cd -
}

dockerPush() {
    if [[ ! $1 ]] || [[ ! $2 ]]; then
        logError "you must input following params in order:"
        echo -e "${ENV_COLOR_B_RED}"
        echo "    (1) repository"
        echo "    (2) tag"
        echo -e "\nEg. dockerBuild tdh60dev01:5000/fide/fide-processor fide-0.0.6-SNAPSHOT"
        echo -e "${ENV_COLOR_RESET}"
        return ${ENV_FAILED}
    fi

    local repository=$1
    local tag=$2

    local dockerHashId=$(docker image ls | grep ${repository} | grep ${tag} | awk '{print $3}')
    if [[ ! ${dockerHashId} ]]; then
        logInfo "try to delete existed image: ${repository}:${tag}"
        callAndLog docker rmi ${dockerHashId}
    fi

    logInfo "try to push new image: ${repository}:${tag}"
    callAndLog docker push ${repository}:${tag}
}

# check Dockerfile
# @param $1: project path
dockerCheck() {
    local source=$1
    if [[ -d "${source}" ]]; then
        cd ${source}
        if [[ -f "${source}/Dockerfile" ]]; then
            return ${ENV_YES}
        else
            logError "Dockerfile is not exists"
            return ${ENV_NO}
        fi
        cd -
        return ${ENV_YES}
    else
        logError "${source} is not valid docker project"
        return ${ENV_NO}
    fi
}
