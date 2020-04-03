#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# git operation utils
# @author Zhang Peng
# -----------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ load libs

LINUX_SCRIPTS_LIB_DIR=`dirname ${BASH_SOURCE[0]}`

if [[ ! -x ${LINUX_SCRIPTS_LIB_DIR}/utils.sh ]]; then
    logError "${LINUX_SCRIPTS_LIB_DIR}/utils.sh not exists!"
    exit 1
fi

source ${LINUX_SCRIPTS_LIB_DIR}/utils.sh


# ------------------------------------------------------------------------------ functions

GIT_LOCAL_BRANCH=
getGitLocalBranch() {
    GIT_LOCAL_BRANCH=$(git symbolic-ref -q --short HEAD)
}

GIT_ORIGIN_BRANCH=
getGitOriginBranch() {
    GIT_ORIGIN_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}")
}

# check specified path is git project or not
checkGit() {
    local source=$1
    if [[ -d "${source}" ]]; then
        cd ${source} || return ${ENV_NO}
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
            return ${ENV_YES}
        else
            return ${ENV_NO}
        fi

        return ${ENV_NO}
    fi

    logWarn "${source} is not exists."
    return ${ENV_NO}
}

# execute git clone or fetch
# params: Git repository, git group, git project, git branch, local path
cloneOrPullGit() {

    local repository=$1
    local group=$2
    local project=$3
    local branch=$4
    local root=$5

    if [[ ! ${repository} ]] || [[ ! ${group} ]] || [[ ! ${project} ]] || [[ ! ${branch} ]] || [[ ! ${root} ]]; then
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
    mkdir -p ${root}/${group}

    checkGit ${source}
    if [[ "${ENV_YES}" == "$?" ]]; then
        cd ${source} || return ${ENV_FAILED}

        git fetch --all
        git checkout -f ${branch}
        if [[ "${ENV_SUCCEED}" != "$?" ]]; then
            logError "<<<< git checkout ${branch} failed."
            return ${ENV_FAILED}
        fi
        logInfo "git checkout ${branch} succeed."

        getGitOriginBranch
        git reset --hard ${GIT_ORIGIN_BRANCH}
        if [[ "${ENV_SUCCEED}" != "$?" ]]; then
            logError "<<<< git reset --hard ${GIT_ORIGIN_BRANCH} failed."
            return ${ENV_FAILED}
        fi
        logInfo "git reset --hard ${GIT_ORIGIN_BRANCH} succeed."

        git pull
        if [[ "${ENV_SUCCEED}" != "$?" ]]; then
            logError "<<<< git pull failed."
            return ${ENV_FAILED}
        fi
        logInfo "git pull succeed."
    else
        git clone "${repository}:${group}/${project}.git" ${source}
        if [[ "${ENV_SUCCEED}" != "$?" ]]; then
            logError "<<<< git clone ${project} failed."
            return ${ENV_FAILED}
        fi
        logInfo "git clone ${project} succeed."

        cd ${source} || return ${ENV_FAILED}

        git checkout -f ${branch}
        if [[ "${ENV_SUCCEED}" != "$?" ]]; then
            logError "<<<< git checkout ${branch} failed."
            return ${ENV_FAILED}
        fi
        logInfo "git checkout ${branch} succeed."
    fi

    logInfo "Clone or pull git project [$2/$3:$4] succeed."
    return ${ENV_SUCCEED}
}
