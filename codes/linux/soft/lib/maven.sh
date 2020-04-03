#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# maven operation utils
# @author Zhang Peng
# -----------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ load libs

LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`

if [[ ! -x ${LINUX_SCRIPTS_LIB_DIR}/utils.sh ]]; then
    echo "${LINUX_SCRIPTS_LIB_DIR}/utils.sh not exists!"
    exit 1
fi

source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh


# ------------------------------------------------------------------------------ functions

# execute maven lifecycle operation
# @param $1: maven project path
# @param $2: maven lifecycle, eg. package、install、deploy
# @param $3: maven profile [optional]
mavenOperation() {
	local source=$1
	local lifecycle=$2
	local profile=$3

	mavenCheck ${source}
    if [[ "${ENV_SUCCEED}" != "$?" ]]; then
        return ${ENV_FAILED}
    fi

    if [[ ! "${lifecycle}" ]]; then
        logError "please input maven lifecycle"
        return ${ENV_FAILED}
    fi

    local mvnCli="mvn clean ${lifecycle} -DskipTests=true -B -U"

    if [[ ${profile} ]]; then
        mvnCli="${mvnCli} -P${profile}"
    fi

    cd ${source}
    if [[ -f "${source}/settings.xml" ]]; then
        mvnCli="${mvnCli} -s ${source}/settings.xml"
    fi

    callAndLog "${mvnCli}"
    cd -
    return ${ENV_SUCCEED}
}

# check specified path is maven project or not
# @param $1: maven project path
mavenCheck() {
    local source=$1
    if [[ -d "${source}" ]]; then
		cd ${source}
		if [[ -f "${source}/pom.xml" ]]; then
			return ${ENV_YES}
		else
			logError "pom.xml is not exists"
			return ${ENV_NO}
		fi
		cd -
		return ${ENV_YES}
	else
		logError "please input valid maven project path"
		return ${ENV_NO}
	fi
}
