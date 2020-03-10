#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# 数据库操作脚本
# @author Zhang Peng
# -----------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------ 1. env

## 数据库IP
#ENV_MYSQL_HOST="127.0.0.1"
## 数据库用户名
#ENV_MYSQL_USERNAME="root"
## 数据密码
#ENV_MYSQL_PASSWORD="Tw#123456"
if [[ ! ${ENV_MYSQL_HOST} ]] || [[ ! ${ENV_MYSQL_USERNAME} ]] || [[ ! ${ENV_MYSQL_PASSWORD} ]]; then
    logError "执行本脚本前必须先 export 环境变量: ENV_MYSQL_HOST, ENV_MYSQL_USERNAME, ENV_MYSQL_PASSWORD."
    exit ${ENV_FAILED}
fi

# 备份模式：备份所有数据库（--all-databases）|备份指定数据库列表
MYSQL_DATABASES="${ENV_MYSQL_DATABASES:---all-databases}"

#备份路径
MYSQL_BACKUP_DIR="${ENV_MYSQL_BACKUP_DIR:-/var/lib/mysql/backup}"
#备份日志路径
export ENV_LOG_PATH="${MYSQL_BACKUP_DIR}/mysql-backup.log"


# ------------------------------------------------------------------------------ 2. libs

# 装载其它库
LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`

if [[ ! -x ${LINUX_SCRIPTS_LIB_DIR}/utils.sh ]]; then
    logError "${LINUX_SCRIPTS_LIB_DIR}/utils.sh not exists!"
    exit 1
fi

source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh


# ------------------------------------------------------------------------------ 3. global var

# 备份文件最大数量
BACKUP_ARTIFACTS_MAX_NUM=7

# ------------------------------------------------------------------------------ 4. functions

backupAllDatabase() {

    #时间戳
    local timestamp=$(date +"%Y%m%d")

    #备份所有数据库
    logInfo "正在备份所有数据库"
    mysqldump -h ${ENV_MYSQL_HOST} -P${ENV_MYSQL_PORT} -u${ENV_MYSQL_USERNAME} -p${ENV_MYSQL_PASSWORD} --all-databases > "${MYSQL_BACKUP_DIR}/all-${timestamp}.sql" 2>> ${ENV_LOG_PATH};

    #检查备份结果是否成功
    if [[ "$?" != 0 ]]; then
        logError "<<<< 备份所有数据库失败"
        return ${ENV_FAILED}
    fi

    # 压缩备份sql文件，删除旧的备份文件
    cd "${MYSQL_BACKUP_DIR}"
    if [[ ! -f "${MYSQL_BACKUP_DIR}/all-${timestamp}.sql" ]]; then
        logError "备份文件 ${MYSQL_BACKUP_DIR}/all-${timestamp}.sql 不存在"
        return ${ENV_FAILED}
    fi
    #为节约硬盘空间，将数据库压缩
    sudo tar zcf "all-${timestamp}.tar.gz" "all-${timestamp}.sql" > /dev/null
    #删除原始文件，只留压缩后文件
    sudo rm -f "all-${timestamp}.sql"
    #删除七天前备份，也就是只保存7天内的备份
    find "${MYSQL_BACKUP_DIR} -name all-*.tar.gz -type f -mtime +${BACKUP_ARTIFACTS_MAX_NUM} -exec rm -rf {} \;" > /dev/null 2>&1

    logInfo "<<<< 备份所有数据库成功"
    return ${ENV_SUCCEED}
}

backupSelectedDatabase() {

    #时间戳
    local timestamp=$(date +"%Y%m%d")

    #数据库,如有多个库用空格分开
    databaseList="${MYSQL_DATABASES}"

    #备份指定数据库列表
    for database in ${databaseList}; do

        logInfo "正在备份数据库：${database}"
        mysqldump -h ${ENV_MYSQL_HOST} -P${ENV_MYSQL_PORT} -u${ENV_MYSQL_USERNAME} -p${ENV_MYSQL_PASSWORD} "${database}" > "${MYSQL_BACKUP_DIR}/${database}-${timestamp}.sql" 2>> ${ENV_LOG_PATH};
        if [[ "$?" != 0 ]]; then
            logError "<<<< 备份 ${database} 失败"
            return ${ENV_FAILED}
        fi

        # 压缩备份sql文件，删除旧的备份文件
        cd "${MYSQL_BACKUP_DIR}"
        if [[ ! -f "${MYSQL_BACKUP_DIR}/${database}-${timestamp}.sql" ]]; then
            logError "备份文件 ${MYSQL_BACKUP_DIR}/${database}-${timestamp}.sql 不存在"
            return ${ENV_FAILED}
        fi
        #为节约硬盘空间，将数据库压缩
        sudo tar zcf "${database}-${timestamp}.tar.gz" "${database}-${timestamp}.sql" > /dev/null
        #删除原始文件，只留压缩后文件
        sudo rm -f "${database}-${timestamp}.sql"
        #删除七天前备份，也就是只保存7天内的备份
        find "${MYSQL_BACKUP_DIR} -name ${database}-*.tar.gz -type f -mtime +${BACKUP_ARTIFACTS_MAX_NUM} -exec rm -rf {} \;" > /dev/null 2>&1
    done

    logInfo "<<<< 备份数据库 ${MYSQL_DATABASES} 成功"
    return ${ENV_SUCCEED}
}

backupMysql() {

    #日志记录头部
    sudo mkdir -p ${MYSQL_BACKUP_DIR}
    touch ${ENV_LOG_PATH}

    logInfo "------------------------------------------------------------------"
    logInfo ">>>> 备份数据库开始"

    #正式备份数据库
    if [[ ${MYSQL_DATABASES} == "--all-databases" ]]; then
        backupAllDatabase
    else
        backupSelectedDatabase
    fi
}

recoveryMysql() {

    logInfo "------------------------------------------------------------------"
    logInfo ">>>> 恢复数据库开始"

    if [[ ! -f ${ENV_SQL_FILE_PATH} ]]; then
        logError "sql 文件 ${ENV_SQL_FILE_PATH} 不存在"
        return ${ENV_FAILED}
    fi

    mysql -h ${ENV_MYSQL_HOST} -P${ENV_MYSQL_PORT} -u${ENV_MYSQL_USERNAME} -p${ENV_MYSQL_PASSWORD} < ${ENV_SQL_FILE_PATH}
    if [[ "$?" != 0 ]]; then
        logError "<<<< 恢复数据库失败"
        return ${ENV_FAILED}
    fi

    logInfo "<<<< 恢复数据库成功"
    return ${ENV_SUCCEED}
}
