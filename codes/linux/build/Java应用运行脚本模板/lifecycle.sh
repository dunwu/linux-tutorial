#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# 应用终止脚本
# @author Zhang Peng
# -----------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------ libs

SCRIPTS_DIR=$(cd `dirname $0`; pwd)

if [[ ! -x ${SCRIPTS_DIR}/utils.sh ]]; then
    logError "${SCRIPTS_DIR}/utils.sh not exists!"
    exit 1
fi
source ${SCRIPTS_DIR}/utils.sh


# ------------------------------------------------------------------------------ functions

stopServer() {
    if [[ ! $1 ]]; then
        logError "please input java app name"
        return ${ENV_FAILED}
    fi

    local appName=$1
    local pid=`jps | grep ${appName} | awk '{print $1}'`
    if [[ -n "${pid}" ]]; then
        kill -9 ${pid}
        if [[ $? -eq ${ENV_SUCCEED} ]]; then
            printInfo "stop ${appName} succeed"
            return ${ENV_SUCCEED}
        else
            logError "stop ${appName} failed"
            return ${ENV_FAILED}
        fi
    else
        printWarn "${appName} is not running"
        return ${ENV_SUCCEED}
    fi
}

startServer() {

    # >>>> validate params
    if [[ ! $1 ]] || [[ ! $2 ]] || [[ ! $3 ]] || [[ ! $4 ]]; then
        logError "you must input following params in order:"
        echo -e "${ENV_COLOR_B_RED}"
        echo "    (1)jarPath"
        echo "    (2)libPath"
        echo "    (3)confPath"
        echo "    (4)logPath"
        echo "    (5)appName    [optional]"
        echo "    (6)port       [optional]"
        echo "    (7)profile    [optional]"
        echo "    (8)debug      [optional]"
        echo -e "\nEg. startServer /usr/lib/dunwu/app.jar /usr/lib/dunwu/lib /usr/lib/dunwu/conf /var/log/dunwu dunwu 8888 prod off"
        echo -e "${ENV_COLOR_RESET}"
        return ${ENV_FAILED}
    fi

    local jarPath=$1
    local libPath=$2
    local confPath=$3
    local logPath=$4
    local appName=${5:-myapp}
    local port=${6:-8888}
    local profile=${7:-prod}
    local debug=${8:-off}

    # >>>> 1. check java app is started or not
    # >>>> 1.1. exit script if the app is started
    local pid=`jps | grep ${appName} | awk '{print $1}'`
    if [[ -n "${pid}" ]]; then
        printInfo "${appName} is started, PID: ${pid}"
        return ${ENV_SUCCEED}
    fi

    # >>>> 2. package options
    # GC OPTS
    local javaOptions="-server -Xms1g -Xmx2g -Xss256k"
    javaOptions="${javaOptions} -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:NewRatio=4"

    # GC LOG OPTS
    javaOptions="${javaOptions} -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"
    javaOptions="${javaOptions} -verbose:gc -Xloggc:${logPath}/${appName}.gc.log"
    javaOptions="${javaOptions} -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"

    # Heap Dump OPTS
    javaOptions="${javaOptions} -XX:-OmitStackTraceInFastThrow -XX:+HeapDumpOnOutOfMemoryError"
    javaOptions="${javaOptions} -XX:HeapDumpPath=${logPath}/${appName}.heapdump.hprof"

    # APP OPTS
    javaOptions="${javaOptions} -Dsun.net.inetaddr.ttl=60 -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"
    if [[ ${profile} ]]; then
        javaOptions="${javaOptions} -Dspring.profiles.active=${profile}"
    fi

    # DEBUG OPTS
    if [[ "${debug}" == "on" ]]; then
        # JMX OPTS
        local ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/')
        local jmxPort=$(expr 10000 + ${port})
        javaOptions="${javaOptions} -Dcom.sun.management.jmxremote=true"
        javaOptions="${javaOptions} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
        javaOptions="${javaOptions} -Djava.rmi.server.hostname=${ip} -Dcom.sun.management.jmxremote.port=${jmxPort}"

        # Remote Debug
        local debugPort=$(expr 20000 + ${port})
        javaOptions="${javaOptions} -Xdebug -Xnoagent -Djava.compiler=NONE"
        javaOptions="${javaOptions} -Xrunjdwp:transport=dt_socket,address=${debugPort},server=y,suspend=n"
    fi

    # CLASSPATH
    local appOptions="-classpath ${libPath}/* -Dlogging.config=file:${confPath}/logback.${profile}.xml"
    local springConfigFiles="classpath:/,classpath:/config/"
    local springConfigFiles="${springConfigFiles},file:${confPath}/,file:${confPath}/application.properties"
    appOptions="${appOptions} --spring.config.location=${springConfigFiles}"
    appOptions="${appOptions} --spring.cache.ehcache.config=file:${confPath}/config/ehcache.xml"
    if [[ ${port} ]]; then
        appOptions="${appOptions} --server.port=${port}"
    fi

    # >>>> 3. create log dir and console log file
    local consoleLogPath=${logPath}/${appName}.console.log
    mkdir -p ${logPath}
    if [[ ! -x ${consoleLogPath} ]]; then
        touch ${consoleLogPath}
    fi

    # >>>> 4. start java app
    # print bootstrap info
    printInfo "starting ${appName}"
    echo -e "${ENV_COLOR_B_GREEN}"
    echo -e "${ENV_COLOR_B_CYAN}\nBOOT PARAMS:${ENV_COLOR_B_GREEN}\n\n"
    echo "appName=${appName}"
    echo "jarPath=${jarPath}"
    echo "libPath=${libPath}"
    echo "confPath=${confPath}"
    echo "logPath=${logPath}"
    echo "port=${port}"
    echo "profile=${profile}"
    echo "debug=${debug}"
    echo -e "${ENV_COLOR_B_CYAN}\nEXEC CLI:${ENV_COLOR_B_GREEN}\n\n"
    echo "nohup java ${javaOptions} -jar ${jarPath} ${appOptions} >> ${consoleLogPath} 2>&1 &"
    echo -e "${ENV_COLOR_RESET}"

    # exec boot cli
    nohup java ${javaOptions} -jar ${jarPath} ${appOptions} >> ${consoleLogPath} 2>&1 &

    # >>>> 5. check java app is started or not
    local pid=`jps | grep ${appName} | awk '{print $1}'`
    if [[ -n "${pid}" ]]; then
        printInfo "start ${appName} succeed, PID: ${pid}"
        return ${ENV_SUCCEED}
    else
        logError "start ${appName} failed"
        return ${ENV_FAILED}
    fi
}
