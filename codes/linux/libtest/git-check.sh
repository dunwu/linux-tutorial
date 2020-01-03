#!/usr/bin/env bash

source ../lib/git.sh

##################################### MAIN #####################################
if [[ $1 ]]; then
    DIR=$1
else
    DIR=$(pwd)
fi

printf "${C_B_BLUE}Current path is: ${DIR} ${C_RESET}\n"

checkGit ${DIR}
if [[ "${YES}" == "$?" ]]; then
    printf "${C_B_GREEN}${DIR} is git project.${C_RESET}\n"
    exit ${YES}
else
    printf "${C_B_RED}${DIR} is not git project.${C_RESET}\n"
    exit ${NO}
fi
