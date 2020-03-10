#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Java 应用运维脚本
# @author Zhang Peng
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ env preparation
# load libs
CURRENT_PATH=`dirname ${BASH_SOURCE[0]}`
source ${CURRENT_PATH}/utils.sh

# ------------------------------------------------------------------------------ functions

stopServer() {
    if [[ ! $1 ]]; then
        printError "please input java app name"
        return ${FAILED}
    fi

    local javaAppName=$1
    local pid=`jps | grep ${javaAppName} | awk '{print $1}'`
    if [[ -n "${pid}" ]]; then
        kill -9 ${pid}
        if [[ $? -eq ${SUCCEED} ]]; then
            printInfo "stop ${javaAppName} succeed"
            return ${SUCCEED}
        else
            printError "stop ${javaAppName} failed"
            return ${FAILED}
        fi
    else
        printWarn "${javaAppName} is not running"
        return ${SUCCEED}
    fi
}

startServer() {
    if [[ ! $1 ]]; then
        printError "please input java app name"
        return ${FAILED}
    fi

    # >>>> 1. check java app is started or not
    # >>>> 1.1. exit script if the app is started
    local javaAppName=$1
    local pid=`jps | grep ${javaAppName} | awk '{print $1}'`
    if [[ -n "${pid}" ]]; then
        printInfo "${javaAppName} is started, PID: ${pid}"
        return ${SUCCEED}
    fi

    # >>>> 2. package options
    # GC OPTS
    local javaOptions="-server -Xms1g -Xmx2g -Xss256k"
    javaOptions="${javaOptions} -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:NewRatio=4"

    # GC LOG OPTS
    javaOptions="${javaOptions} -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"
    javaOptions="${javaOptions} -verbose:gc -Xloggc:${LOG_PATH}/${javaAppName}.gc.log"
    javaOptions="${javaOptions} -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"

    # Heap Dump OPTS
    javaOptions="${javaOptions} -XX:-OmitStackTraceInFastThrow -XX:+HeapDumpOnOutOfMemoryError"
    javaOptions="${javaOptions} -XX:HeapDumpPath=${LOG_PATH}/${javaAppName}.heapdump.hprof"

    # APP OPTS
    javaOptions="${javaOptions} -Dsun.net.inetaddr.ttl=60 -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"
    if [[ ${PROFILE} ]]; then
        javaOptions="${javaOptions} -Dspring.profiles.active=${PROFILE}"
    fi

    # DEBUG OPTS
    if [[ "${DEBUG}" == "on" ]]; then
      # JMX OPTS
      local ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/')
      local jmxPort=$(expr 10000 + ${PORT})
      javaOptions="${javaOptions} -Dcom.sun.management.jmxremote=true"
      javaOptions="${javaOptions} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
      javaOptions="${javaOptions} -Djava.rmi.server.hostname=${ip} -Dcom.sun.management.jmxremote.port=${jmxPort}"

      # Remote Debug
      local debugPort=$(expr 20000 + ${PORT})
      javaOptions="${javaOptions} -Xdebug -Xnoagent -Djava.compiler=NONE"
      javaOptions="${javaOptions} -Xrunjdwp:transport=dt_socket,address=${debugPort},server=y,suspend=n"
    fi

    # CLASSPATH
    local appOptions="-classpath ${ROOT_PATH}/lib/* -Dlogging.config=file:${ROOT_PATH}/config/logback.dev.xml"
    appOptions="${appOptions} --spring.config.location=classpath:/,classpath:/config/,file:${ROOT_PATH},file:${ROOT_PATH}/config/"
    if [[ ${PORT} ]]; then
        appOptions="${appOptions} --server.port=${PORT}"
    fi

    # >>>> 3. create log dir and console log file
    mkdir -p ${LOG_PATH}
    if [[ ! -x ${CONSOLE_LOG} ]]; then
        touch ${CONSOLE_LOG}
    fi

    # >>>> 4. start java app
    printInfo "starting ${javaAppName}, execute cli: "
    printInfo "nohup java ${javaOptions} -jar ${ROOT_PATH}/${javaAppName}.jar ${appOptions} >> ${CONSOLE_LOG} 2>&1 &"
    nohup java ${javaOptions} -jar ${ROOT_PATH}/${javaAppName}.jar ${appOptions} >> ${CONSOLE_LOG} 2>&1 &

    # >>>> 5. check java app is started or not
    local pid=`jps | grep ${javaAppName} | awk '{print $1}'`
    if [[ -n "${pid}" ]]; then
        printInfo "start ${javaAppName} succeed, PID: ${pid}"
        return ${SUCCEED}
    else
        printError "start ${javaAppName} failed"
        return ${FAILED}
    fi
}

# ------------------------------------------------------------------------------ main
export LANG="zh_CN.UTF-8"
ROOT_PATH=$(cd ${CURRENT_PATH}/..; pwd)

APP_NAME=java-app
LOG_PATH=/var/log/myapp
CONSOLE_LOG=${LOG_PATH}/${APP_NAME}.console.log

PORT=8888
PROFILE=dev
DEBUG=off

startServer ${APP_NAME}
#stopServer ${APP_NAME}
if [[ $? -eq ${SUCCEED} ]]; then
    exit ${SUCCEED}
else
    exit ${FAILED}
fi
