#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# maven 项目操作脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# 装载其它库
ROOT=`dirname ${BASH_SOURCE[0]}`
source ${ROOT}/env.sh

mavenBuild() {
	local source=$1
	mavenCheck $1
    if [[ "${SUCCEED}" != "$?" ]]; then
        return ${FAILED}
    fi

	if [[ -d "${source}" ]]; then
		cd ${source}
		if [[ -f "${source}/settings.xml" ]]; then
			callAndLog "mvn clean install -B -U -s ${source}/settings.xml -Dmaven.test.skip=true"
		else
			callAndLog "mvn clean install -DskipTests=true -B -U"
		fi
		cd -
		return ${SUCCEED}
	else
		printf "${C_B_RED}please input valid maven project path.${C_RESET}\n"
		return ${FAILED}
	fi
}

mavenCheck() {
    local source=$1
    if [[ -d "${source}" ]]; then
		cd ${source}
		if [[ -f "${source}/pom.xml" ]]; then
			return ${YES}
		else
			printf "${C_B_RED}pom.xml is not exists.${C_RESET}\n"
			return ${NO}
		fi
		cd -
		return ${YES}
	else
		printf "${C_B_RED}please input valid maven project path.${C_RESET}\n"
		return ${NO}
	fi
}

##################################### MAIN #####################################
printf "\n${C_B_GREEN}>>>> maven build begin.${C_RESET}\n\n"

printf "${C_B_MAGENTA}Current path is ${ROOT}.${C_RESET}\n"

mavenBuild ${ROOT}/..
r1=$?

if [[ "${r1}" == "${SUCCEED}" ]]; then
    printf "\n${C_B_GREEN}<<<< maven build succeed.${C_RESET}\n\n"
    exit ${SUCCEED}
else
    printf "\n${C_B_RED}<<<< maven build failed.${C_RESET}\n\n"
    exit ${FAILED}
fi
