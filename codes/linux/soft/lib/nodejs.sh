#!/usr/bin/env bash

# 装载其它库
ROOT=`dirname ${BASH_SOURCE[0]}`
source ${ROOT}/file.sh

# ------------------------------------------------------------------------------ nodejs 操作函数

# install Node Version Manager(nvm)
installNvm() {
    local nvmVersion=0.35.2
    if [[ $1 ]]; then
        local nvmVersion=$1
    fi

    recreateDir "~/.nvm"
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v${nvmVersion}/install.sh | bash
    source ~/.nvm/nvm.sh
    if [[ "$?" != "${YES}" ]]; then
        return ${FAILED}
    fi

    # Check
    nvm version
    if [[ "$?" != "${YES}" ]]; then
        return ${FAILED}
    fi
    return ${SUCCEED}
}

# Check nodejs version
checkNodejsVersion() {
    if [[ ! $1 ]]; then
        printf "${C_B_RED}<<<< please specified expect nodejs version.${C_RESET}\n"
        return ${FAILED}
    fi

    local expectVersion=$1

    source /root/.bashrc
    local nodeVersion=$(nvm version)
    if [[ "$?" != "${YES}" ]]; then
        printf "${C_B_YELLOW}>>>> nvm not installed.${C_RESET}\n"

        local nvmVersion=v0.35.2
        installNvm "${nvmVersion}"
        if [[ "$?" != "${SUCCEED}" ]]; then
            return ${FAILED}
        fi
        nodeVersion=$(nvm version)
    fi

    if [[ "${nodeVersion}" != "v${expectVersion}" ]]; then
        printf "${C_B_YELLOW}>>>> current nodejs version is ${nodeVersion}, not ${expectVersion}.${C_RESET}\n"
        nvm install ${expectVersion}
        nvm use ${expectVersion}
    fi

    return ${SUCCEED}
}

# build nodejs project
buildNodejsProject() {
    if [[ ! $1 ]]; then
        printf "${C_B_RED}<<<< please input nodejs project path.${C_RESET}\n"
        return ${FAILED}
    fi

    if [[ ! $2 ]]; then
        printf "${C_B_RED}<<<< please input nodejs version.${C_RESET}\n"
        return ${FAILED}
    fi

    isDirectory $1
    if [[ "$?" != "${YES}" ]]; then
        printf "${C_B_RED}<<<< $1 is not valid path.${C_RESET}\n"
        return ${FAILED}
    fi

    local project=$1
    local nodeVersion=$2
    printf "${C_B_BLUE}>>>> build nodejs project $1 begin.${C_RESET}\n"
    cd ${project} || (printf "${C_B_RED}<<<< ${project} is not exists.${C_RESET}\n" && exit 1)

    checkNodejsVersion ${nodeVersion}

    npm install
    if [[ "$?" != "${YES}" ]]; then
        printf "${C_B_RED}<<<< update dependencies failed.${C_RESET}\n"
        return ${FAILED}
    else
        printf "${C_B_GREEN}>>>> update dependencies succeed.${C_RESET}\n"
    fi

    npm run build
    if [[ "$?" != "${YES}" ]]; then
        printf "${C_B_RED}<<<< build failed.${C_RESET}\n"
        return ${FAILED}
    else
        printf "${C_B_GREEN}<<<< build succeed.${C_RESET}\n"
    fi
    return ${SUCCEED}
}

# package nodejs artifact dir (default is dist)
packageDist() {
    zip -o -r -q ${branch}.zip *
}
