#!/usr/bin/env bash

source ../lib/utils.sh
source ../lib/git.sh

doCloneOrPullGit() {
    cloneOrPullGit $1 $2 $3 $4 $5
    if [[ "$?" == "${SUCCEED}" ]]; then
        printf "\n${C_GREEN}>>>> Update git project [$2/$3] succeed.${C_RESET}\n"
        return ${SUCCEED}
    else
        printf "\n${C_RED}>>>> Update git project [$2/$3] failed.${C_RESET}\n"
        return ${FAILED}
    fi
}

##################################### MAIN #####################################
ROOT=$(dirname ${BASH_SOURCE[0]})

# 这里需要根据实际情况替换 Git 仓库、项目组、项目、代码分支
REPOSITORY="git@gitee.com"

printf "${C_CYAN}Current path is ${ROOT}.${C_RESET}\n"

doCloneOrPullGit ${REPOSITORY} turnon linux-tutorial master ${ROOT}
r1=$?
doCloneOrPullGit ${REPOSITORY} turnon nginx-tutorial master ${ROOT}
r2=$?

if [[ "${r1}" == "${SUCCEED}" && "${r2}" == "${SUCCEED}" ]]; then
    printf "\n${C_B_GREEN}<<<< Init workspace Succeed.${C_RESET}\n\n"
    exit ${SUCCEED}
else
    printf "\n${C_B_RED}<<<< Init workspace Failed.${C_RESET}\n\n"
    exit ${FAILED}
fi
