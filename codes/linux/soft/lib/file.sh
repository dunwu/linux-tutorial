#!/usr/bin/env bash

# 装载其它库
ROOT=`dirname ${BASH_SOURCE[0]}`
source ${ROOT}/utils.sh

# ------------------------------------------------------------------------------ 文件操作函数

# 文件是否存在
isFileExists() {
	if [[ -e $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

isFile() {
	if [[ -f $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

isDirectory() {
	if [[ -d $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

isFileReadable() {
    if [[ -r $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

isFileWritable() {
    if [[ -w $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

isFileExecutable() {
    if [[ -x $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

# 检查文件夹是否存在，不存在则创建
createFolderIfNotExist() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}

# 重建目录，如果目录已存在，则删除后重建；如果不存在，直接新建
recreateDir() {
    if [[ ! $1 ]]; then
       printf "${C_B_RED}<<<< Please input dir path.${C_RESET}\n"
       return ${FAILED}
    fi

    rm -rf $1
    mkdir -p $1

    isDirectory $1
    if [[ "$?" != "${SUCCEED}" ]]; then
        printf "${C_B_RED}<<<< create $1 failed.${C_RESET}\n"
        return ${FAILED}
    fi

    return ${SUCCEED}
}
