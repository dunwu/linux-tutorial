#!/usr/bin/env bash

source ../lib/utils.sh
source ../lib/git.sh

##################################### MAIN #####################################
if [[ $1 ]]; then
    DIR=$1
else
    DIR=$(pwd)
fi

printInfo "Current path is: ${DIR}."

# 判断是否为 git 项目
checkGit ${DIR}
if [[ "${YES}" == "$?" ]]; then
    printInfo "${DIR} is git project."
else
    printError "${DIR} is not git project."
fi

# 获取 git 分支
getGitLocalBranch
printInfo "git local branch: ${GIT_LOCAL_BRANCH}"
getGitOriginBranch
printInfo "git origin branch: ${GIT_ORIGIN_BRANCH}"
