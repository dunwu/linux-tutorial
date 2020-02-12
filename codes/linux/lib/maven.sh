#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# maven 项目操作脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# 装载其它库
LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`

if [[ ! -x ${LINUX_SCRIPTS_LIB_DIR}/utils.sh ]]; then
    echo "必要脚本库 ${LINUX_SCRIPTS_LIB_DIR}/utils.sh 不存在！"
    exit 1
fi

source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh

# 执行 maven 操作
# @param $1: 第一个参数为 maven 项目路径
# @param $2: 第二个参数为 maven 操作，如 package、install、deploy
# @param $3: 第三个参数为 maven profile 【非必填】
mavenOperation() {
	local source=$1
	local lifecycle=$2
	local profile=$3

	mavenCheck ${source}
    if [[ "${SUCCEED}" != "$?" ]]; then
        return ${FAILED}
    fi

    if [[ ! "${lifecycle}" ]]; then
        logError "please input maven lifecycle"
        return ${FAILED}
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
    return ${SUCCEED}
}

# 判断指定路径下是否为 maven 工程
# @param $1: 第一个参数为 maven 项目路径
mavenCheck() {
    local source=$1
    if [[ -d "${source}" ]]; then
		cd ${source}
		if [[ -f "${source}/pom.xml" ]]; then
			return ${YES}
		else
			logError "pom.xml is not exists"
			return ${NO}
		fi
		cd -
		return ${YES}
	else
		logError "please input valid maven project path"
		return ${NO}
	fi
}
