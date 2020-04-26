#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# Gitlab 操作脚本
# 支持操作：
#   备份 Gitlab
#   恢复 Gitlab
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

# Gilab 操作的环境变量，使用方法：
# 可以在执行本脚本之前，export 以下环境变量，否则将按照默认配置执行

# Gitlab 备份文件最大数量（默认为 7 天）
ENV_BACKUP_MAX_NUM=${ENV_BACKUP_MAX_NUM:-2}
# 备份路径
ENV_GITLAB_BACKUP_DIR="${ENV_GITLAB_BACKUP_DIR:-/var/opt/gitlab/backups}"
# 备份日志路径
ENV_LOG_PATH="${ENV_GITLAB_BACKUP_DIR}/gitlab-backup.log"

magentaOutput "------------------------------------------------------------------------------"
magentaOutput "Gitlab 脚本操作环境变量："
magentaOutput "ENV_BACKUP_MAX_NUM：${ENV_BACKUP_MAX_NUM}"
magentaOutput "ENV_GITLAB_BACKUP_DIR：${ENV_GITLAB_BACKUP_DIR}"
magentaOutput "ENV_LOG_PATH：${ENV_LOG_PATH}"
magentaOutput "------------------------------------------------------------------------------"


# ------------------------------------------------------------------------------ functions

# 安装 Gitlab
installGitlab() {
    # 官方安裝參考：https://about.gitlab.com/install/#centos-7
    printInfo ">>>> install gitlab on Centos7"
    printInfo ">>>> Install and configure the necessary dependencies"
    yum install -y curl policycoreutils-python openssh-server
    systemctl enable sshd
    systemctl start sshd
    printInfo ">>>> open http, https and ssh access in the system firewall"
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo systemctl reload firewalld
    printInfo ">>>> install postfix"
    yum install postfix
    systemctl enable postfix
    systemctl start postfix
    printInfo ">>>> Add the GitLab package repository and install the package"
    curl -o- https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash
    EXTERNAL_URL="http://gitlab.transwarp.io" yum install -y gitlab-ce
}

# 备份 Gitlab
backupGitlab() {

    #时间戳
    local beginTime=$(date +'%Y-%m-%d %H:%M:%S')

    #备份所有数据库
    printInfo ">>>> 备份 Gitlab 开始"
    gitlab-rake gitlab:backup:create >> ${ENV_LOG_PATH};

    #检查备份结果是否成功
    if [[ "$?" != ${ENV_SUCCEED} ]]; then
        printError "<<<< 备份 Gitlab 失败"
        return ${ENV_FAILED}
    fi

    # 压缩备份sql文件，删除旧的备份文件
    cd "${ENV_GITLAB_BACKUP_DIR}"

    #只保存期限内的备份文件，其余删除
    find "${ENV_GITLAB_BACKUP_DIR} -name *_gitlab_backup.tar -type f -mtime +${ENV_BACKUP_MAX_NUM} -exec rm -rf {} \;" > /dev/null 2>&1

    local endTime=$(date +'%Y-%m-%d %H:%M:%S')
    local beginSeconds=$(date --date="${beginTime}" +%s)
    local endSeconds=$(date --date="${endTime}" +%s)
    printInfo "本次备份执行时间：$((endSeconds-beginSeconds)) s"
    printInfo "<<<< 备份 Gitlab 成功\n"
    return ${ENV_SUCCEED}
}

# 恢复 Mysql
recoveryGitlab() {

    local version=$1
    if [[ !version ]]; then
        printError "<<<< 未指定恢复版本"
        return ${ENV_FAILED}
    fi

    #创建备份目录及日志文件
    mkdir -p ${ENV_GITLAB_BACKUP_DIR}
    if [[ ! -f ${ENV_LOG_PATH} ]]; then
         touch ${ENV_LOG_PATH}
    fi

    printInfo ">>>> 恢复 Gitlab 开始"

    gitlab-ctl stop unicorn
    gitlab-ctl stop sidekiq

    gitlab-rake gitlab:backup:restore BACKUP=${version}
    if [[ "$?" != 0 ]]; then
        printError "<<<< 恢复 Gitlab 失败"
        return ${ENV_FAILED}
    fi

    printInfo "<<<< 恢复 Gitlab 成功\n"
    return ${ENV_SUCCEED}
}
