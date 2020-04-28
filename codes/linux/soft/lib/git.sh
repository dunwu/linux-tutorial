#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# Shell Utils
# @author Zhang Peng
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
# Underline Color
export ENV_COLOR_U_BLACK="\033[4;30m"
export ENV_COLOR_U_RED="\033[4;31m"
export ENV_COLOR_U_GREEN="\033[4;32m"
export ENV_COLOR_U_YELLOW="\033[4;33m"
export ENV_COLOR_U_BLUE="\033[4;34m"
export ENV_COLOR_U_MAGENTA="\033[4;35m"
export ENV_COLOR_U_CYAN="\033[4;36m"
export ENV_COLOR_U_WHITE="\033[4;37m"
# Background Color
export ENV_COLOR_BG_BLACK="\033[40m"
export ENV_COLOR_BG_RED="\033[41m"
export ENV_COLOR_BG_GREEN="\033[42m"
export ENV_COLOR_BG_YELLOW="\033[43m"
export ENV_COLOR_BG_BLUE="\033[44m"
export ENV_COLOR_BG_MAGENTA="\033[45m"
export ENV_COLOR_BG_CYAN="\033[46m"
export ENV_COLOR_BG_WHITE="\033[47m"
# Reset Color
export ENV_COLOR_RESET="$(tput sgr0)"

# status
export ENV_YES=0
export ENV_NO=1
export ENV_SUCCEED=0
export ENV_FAILED=1


# ------------------------------------------------------------------------------ util functions

# 显示打印日志的时间
SHELL_LOG_TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
# 那个用户在操作
USER=$(whoami)
# 日志路径
LOG_PATH=${ENV_LOG_PATH:-/var/log/shell.log}
# 日志目录
LOG_DIR=${LOG_PATH%/*}

createLogFileIfNotExists() {
    if [[ ! -x "${LOG_PATH}" ]]; then
    mkdir -p "${LOG_DIR}"
    touch "${LOG_PATH}"
    fi
}

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

logInfo() {
    echo -e "${ENV_COLOR_B_GREEN}[INFO] $@${ENV_COLOR_RESET}"
    createLogFileIfNotExists
    echo "[${SHELL_LOG_TIMESTAMP}] [${USER}] [INFO] [$0] $@" >> "${LOG_PATH}"
}
logWarn() {
    echo -e "${ENV_COLOR_B_YELLOW}[WARN] $@${ENV_COLOR_RESET}"
    createLogFileIfNotExists
    echo "[${SHELL_LOG_TIMESTAMP}] [${USER}] [WARN] [$0] $@" >> "${LOG_PATH}"
}
logError() {
    echo -e "${ENV_COLOR_B_RED}[ERROR] $@${ENV_COLOR_RESET}"
    createLogFileIfNotExists
    echo "[${SHELL_LOG_TIMESTAMP}] [${USER}] [ERROR] [$0] $@" >> "${LOG_PATH}"
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
        logInfo "$@"
        return ${ENV_SUCCEED}
    else
        logError "$@ EXECUTE FAILED"
        return ${ENV_FAILED}
    fi
}

# ------------------------------------------------------------------------------ git functions

getGitLocalBranch() {
    export GIT_LOCAL_BRANCH=$(git symbolic-ref -q --short HEAD)
}

getGitOriginBranch() {
    export GIT_ORIGIN_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}")
}

# check specified path is git project or not
IS_GIT=false
checkGit() {
    local source=$1
    if [[ -d "${source}" ]]; then
        cd ${source}
        # (1) delete gitstatus.tmp
        if [[ -f "gitstatus.tmp" ]]; then
            rm -rf gitstatus.tmp
        fi

        # (2) check git status
        git status &> gitstatus.tmp
        local gitStatus=false
        grep -iwq 'not a git repository' gitstatus.tmp && gitStatus=false || gitStatus=true
        rm -rf gitstatus.tmp
        if [[ ${gitStatus} == true ]]; then
            export IS_GIT=true
            return
        fi
    fi

    logWarn "${source} is not exists."
    export IS_GIT=false
}

# execute git clone or fetch
# params: Git repository, git group, git project, git branch, local path
cloneOrPullGit() {

    local repository=$1
    local group=$2
    local project=$3
    local branch=$4
    local root=$5

    if [[ ! ${repository} || ! ${group} || ! ${project} || ! ${branch} || ! ${root} ]]; then
        logError "Please input root, group, project, branch."
        return ${ENV_FAILED}
    fi

    if [[ ! -d "${root}" ]]; then
        logError "${root} is not directory."
        return ${ENV_FAILED}
    fi

    local source=${root}/${group}/${project}
    logInfo "project directory is ${source}."
    logInfo "git url is ${repository}:${group}/${project}.git."

    checkGit ${source}
    if [[ "${IS_GIT}" == "true" ]]; then
        cd ${source} || return ${ENV_FAILED}

        git checkout ${branch}
        logInfo "git checkout ${branch} succeed."

        git fetch --all
        git reset --hard ${GIT_ORIGIN_BRANCH}
        logInfo "git reset --hard ${GIT_ORIGIN_BRANCH} succeed."

        git pull
        logInfo "git pull succeed."
    else
        git clone "${repository}:${group}/${project}.git" ${source}
        logInfo "git clone ${project} succeed."

        cd ${source} || return ${ENV_FAILED}

        git checkout ${branch}
        logInfo "git checkout ${branch} succeed."
    fi

    logInfo "Clone or pull git project [$2/$3:$4] succeed."
    cd ${SOURCE_DIR}
    return ${ENV_SUCCEED}
}
