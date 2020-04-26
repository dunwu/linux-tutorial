#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# Gitlab 操作脚本
# 支持操作：
#   备份 Gitlab
#   恢复 Gitlab
# @author: Zhang Peng
# -----------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------ env

# Gilab 操作的环境变量，使用方法：
# 可以在执行本脚本之前，export 以下环境变量，否则将按照默认配置执行

# Gitlab 备份文件最大数量（默认为 7 天）
export ENV_BACKUP_MAX_NUM=7
# 备份路径
export ENV_GITLAB_BACKUP_DIR="/var/opt/gitlab/backups"
# 备份日志路径
export ENV_LOG_PATH="${ENV_GITLAB_BACKUP_DIR}/gitlab-backup.log"

ENV_REMOTE_USER=root
ENV_REMOTE_HOST=172.22.6.42

# ------------------------------------------------------------------------------ load libs

GIT_SCRIPTS_DIR=$(cd `dirname $0`; pwd)
if [[ ! -x ${GIT_SCRIPTS_DIR}/gitlab.sh ]]; then
    echo "${GIT_SCRIPTS_DIR}/gitlab.sh not exists!"
    exit 1
fi
source ${GIT_SCRIPTS_DIR}/gitlab.sh

# ------------------------------------------------------------------------------ functions

backupGitlab
if [[ "$?" != ${ENV_SUCCEED} ]]; then
    printError "退出"
    exit ${ENV_FAILED}
fi

#将备份文件传输到gitlab备份服务器
BACKUP_FILE=$(find "${ENV_GITLAB_BACKUP_DIR}" -type f -name "*gitlab_backup.tar" | xargs ls -t | head -1)
scp ${BACKUP_FILE} ${ENV_REMOTE_USER}@${ENV_REMOTE_HOST}:${ENV_GITLAB_BACKUP_DIR}
