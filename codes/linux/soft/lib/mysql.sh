#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# 数据库操作脚本
# 支持操作：
#   备份 Mysql
#   恢复 Mysql
# @author: Zhang Peng
# -----------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ env

# Regular Color
export ENV_COLOR_BLACK="\033[0;30m"
export ENV_COLOR_RED="\033[0;31m"
export ENV_COLOR_GREEN="\033[0;32m"
export ENV_COLOR_YELLOW="\033[0;33m"
export ENV_COLOR_BLUE="\033[0;34m"
export ENV_COLOR_MAGENTA="\033[0;35m"
export ENV_COLOR_CYAN="\033[0;36m"
export ENV_COLOR_WHITE="\033[0;37m"
# Bold Color
export ENV_COLOR_B_BLACK="\033[1;30m"
export ENV_COLOR_B_RED="\033[1;31m"
export ENV_COLOR_B_GREEN="\033[1;32m"
export ENV_COLOR_B_YELLOW="\033[1;33m"
export ENV_COLOR_B_BLUE="\033[1;34m"
export ENV_COLOR_B_MAGENTA="\033[1;35m"
export ENV_COLOR_B_CYAN="\033[1;36m"
export ENV_COLOR_B_WHITE="\033[1;37m"
# Reset Color
export ENV_COLOR_RESET="$(tput sgr0)"

# status
export ENV_YES=0
export ENV_NO=1
export ENV_SUCCEED=0
export ENV_FAILED=1

# ------------------------------------------------------------------------------ functions

# 显示打印日志的时间
SHELL_LOG_TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
# 那个用户在操作
USER=$(whoami)

redOutput() {
    echo -e "${ENV_COLOR_RED} $@${ENV_COLOR_RESET}"
}
greenOutput() {
    echo -e "${ENV_COLOR_B_GREEN} $@${ENV_COLOR_RESET}"
}
yellowOutput() {
    echo -e "${ENV_COLOR_YELLOW} $@${ENV_COLOR_RESET}"
}
blueOutput() {
    echo -e "${ENV_COLOR_BLUE} $@${ENV_COLOR_RESET}"
}
magentaOutput() {
    echo -e "${ENV_COLOR_MAGENTA} $@${ENV_COLOR_RESET}"
}
cyanOutput() {
    echo -e "${ENV_COLOR_CYAN} $@${ENV_COLOR_RESET}"
}
whiteOutput() {
    echo -e "${ENV_COLOR_WHITE} $@${ENV_COLOR_RESET}"
}

printInfo() {
    echo -e "${ENV_COLOR_B_GREEN}[INFO] $@${ENV_COLOR_RESET}"
}
printWarn() {
    echo -e "${ENV_COLOR_B_YELLOW}[WARN] $@${ENV_COLOR_RESET}"
}
printError() {
    echo -e "${ENV_COLOR_B_RED}[ERROR] $@${ENV_COLOR_RESET}"
}

callAndLog () {
    $*
    if [[ $? -eq ${ENV_SUCCEED} ]]; then
        printInfo "$@"
        return ${ENV_SUCCEED}
    else
        printError "$@ EXECUTE FAILED"
        return ${ENV_FAILED}
    fi
}

# ------------------------------------------------------------------------------ env

# Mysql 操作的环境变量，使用方法：
# 可以在执行本脚本之前，export 以下环境变量，否则将按照默认配置执行

# Mysql HOST（默认为 127.0.0.1）
ENV_MYSQL_HOST="${ENV_MYSQL_HOST:-127.0.0.1}"
# Mysql 端口（默认为 3306）
ENV_MYSQL_PORT=${ENV_MYSQL_PORT:-3306}
# Mysql 用户名（默认为 root）
ENV_MYSQL_USERNAME=${ENV_MYSQL_USERNAME:-root}
# Mysql 密码（默认为 root）
ENV_MYSQL_PASSWORD=${ENV_MYSQL_PASSWORD:-root}
# Mysql 备份文件最大数量（默认为 7 天）
ENV_BACKUP_MAX_NUM=${ENV_BACKUP_MAX_NUM:-7}

# 备份模式：备份所有数据库（--all-databases）|备份指定数据库列表
ENV_MYSQL_DATABASES="${ENV_MYSQL_DATABASES:---all-databases}"
# 备份路径
ENV_MYSQL_BACKUP_DIR="${ENV_MYSQL_BACKUP_DIR:-/var/lib/mysql/backup}"
# 备份日志路径
ENV_MYSQL_BACKUP_LOG_PATH="${ENV_MYSQL_BACKUP_DIR}/mysql-backup.log"

magentaOutput "------------------------------------------------------------------------------"
magentaOutput "Mysql 脚本操作环境变量："
magentaOutput "ENV_MYSQL_HOST：${ENV_MYSQL_HOST}"
magentaOutput "ENV_MYSQL_PORT：${ENV_MYSQL_PORT}"
magentaOutput "ENV_MYSQL_USERNAME：${ENV_MYSQL_USERNAME}"
magentaOutput "ENV_MYSQL_PASSWORD：${ENV_MYSQL_PASSWORD}"
magentaOutput "ENV_BACKUP_MAX_NUM：${ENV_BACKUP_MAX_NUM}"
magentaOutput "ENV_MYSQL_DATABASES：${ENV_MYSQL_DATABASES}"
magentaOutput "ENV_MYSQL_BACKUP_DIR：${ENV_MYSQL_BACKUP_DIR}"
magentaOutput "ENV_MYSQL_BACKUP_LOG_PATH：${ENV_MYSQL_BACKUP_LOG_PATH}"
magentaOutput "------------------------------------------------------------------------------"


# ------------------------------------------------------------------------------ functions

# 备份所有 database(schema)
backupAllDatabase() {

    #时间戳
    local timestamp=$(date +"%Y%m%d")

    #备份所有数据库
    printInfo ">>>> 备份所有数据库开始"
    mysqldump -h ${ENV_MYSQL_HOST} -P${ENV_MYSQL_PORT} -u${ENV_MYSQL_USERNAME} -p${ENV_MYSQL_PASSWORD} --all-databases > "${ENV_MYSQL_BACKUP_DIR}/all-${timestamp}.sql" 2>> ${ENV_MYSQL_BACKUP_LOG_PATH};

    #检查备份结果是否成功
    if [[ "$?" != ${ENV_SUCCEED} ]]; then
        printError "<<<< 备份所有数据库失败"
        return ${ENV_FAILED}
    fi

    # 压缩备份sql文件，删除旧的备份文件
    cd "${ENV_MYSQL_BACKUP_DIR}"
    if [[ ! -f "${ENV_MYSQL_BACKUP_DIR}/all-${timestamp}.sql" ]]; then
        printError "备份文件 ${ENV_MYSQL_BACKUP_DIR}/all-${timestamp}.sql 不存在"
        return ${ENV_FAILED}
    fi
    #为节约硬盘空间，将数据库压缩
    tar zcf "all-${timestamp}.tar.gz" "all-${timestamp}.sql" > /dev/null
    #删除原始文件，只留压缩后文件
    rm -f "all-${timestamp}.sql"
    #只保存期限内的备份文件，其余删除
    find "${ENV_MYSQL_BACKUP_DIR} -name all-*.tar.gz -type f -mtime +${ENV_BACKUP_MAX_NUM} -exec rm -rf {} \;" > /dev/null 2>&1

    printInfo "<<<< 备份所有数据库成功\n"
    return ${ENV_SUCCEED}
}

# 备份指定的 database(schema)
backupSelectedDatabase() {

    #时间戳
    local timestamp=$(date +"%Y%m%d")

    #数据库,如有多个库用空格分开
    databaseList="${ENV_MYSQL_DATABASES}"

    #备份指定数据库列表
    printInfo ">>>> 备份指定数据库开始"
    for database in ${databaseList}; do

        printInfo "正在备份数据库：${database}"
        mysqldump -h ${ENV_MYSQL_HOST} -P${ENV_MYSQL_PORT} -u${ENV_MYSQL_USERNAME} -p${ENV_MYSQL_PASSWORD} "${database}" > "${ENV_MYSQL_BACKUP_DIR}/${database}-${timestamp}.sql" 2>> ${ENV_MYSQL_BACKUP_LOG_PATH};
        if [[ "$?" != 0 ]]; then
            printError "<<<< 备份 ${database} 失败"
            return ${ENV_FAILED}
        fi

        # 压缩备份sql文件，删除旧的备份文件
        cd "${ENV_MYSQL_BACKUP_DIR}"
        if [[ ! -f "${ENV_MYSQL_BACKUP_DIR}/${database}-${timestamp}.sql" ]]; then
            printError "备份文件 ${ENV_MYSQL_BACKUP_DIR}/${database}-${timestamp}.sql 不存在"
            return ${ENV_FAILED}
        fi
        #为节约硬盘空间，将数据库压缩
        tar zcf "${database}-${timestamp}.tar.gz" "${database}-${timestamp}.sql" > /dev/null
        #删除原始文件，只留压缩后文件
        rm -f "${database}-${timestamp}.sql"
        #只保存期限内的备份文件，其余删除
        find "${ENV_MYSQL_BACKUP_DIR} -name ${database}-*.tar.gz -type f -mtime +${ENV_BACKUP_MAX_NUM} -exec rm -rf {} \;" > /dev/null 2>&1
    done

    printInfo "<<<< 备份数据库 ${ENV_MYSQL_DATABASES} 成功\n"
    return ${ENV_SUCCEED}
}

# 备份 Mysql
backupMysql() {
    #创建备份目录及日志文件
    mkdir -p ${ENV_MYSQL_BACKUP_DIR}
    if [[ ! -f ${ENV_MYSQL_BACKUP_LOG_PATH} ]]; then
         touch ${ENV_MYSQL_BACKUP_LOG_PATH}
    fi

    #正式备份数据库
    if [[ ${ENV_MYSQL_DATABASES} == "--all-databases" ]]; then
        backupAllDatabase
    else
        backupSelectedDatabase
    fi
}

# 恢复 Mysql
recoveryMysql() {
    #创建备份目录及日志文件
    mkdir -p ${ENV_MYSQL_BACKUP_DIR}
    if [[ ! -f ${ENV_MYSQL_BACKUP_LOG_PATH} ]]; then
         touch ${ENV_MYSQL_BACKUP_LOG_PATH}
    fi

    printInfo ">>>> 恢复数据库开始"

    mysql -h ${ENV_MYSQL_HOST} -P${ENV_MYSQL_PORT} -u${ENV_MYSQL_USERNAME} -p${ENV_MYSQL_PASSWORD} < ${ENV_MYSQL_BACKUP_LOG_PATH}
    if [[ "$?" != 0 ]]; then
        printError "<<<< 恢复数据库失败"
        return ${ENV_FAILED}
    fi

    printInfo "<<<< 恢复数据库成功\n"
    return ${ENV_SUCCEED}
}
