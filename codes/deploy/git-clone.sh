#!/bin/bash

#
# 检查脚本参数，如必要参数未传入，退出脚本。
#
checkInput() {
  if [ "${repository}" == "" ] || [ "${branch}" == "" ]; then
    echo "请输入脚本参数：repository branch [source] [target]"
    echo "    repository: git 仓储（必填）。"
    echo "    branch: git 分支（必填）。如 master/develop"
    echo "    source: 代码存放目录。默认为/home/zp/source。"
    echo "    target: 代码存放目录。默认为脚本所在目录。"
    exit 0
  fi
}

#
# 判断 git 版本库是否存在。根据实际结果修改 ${gitok} 值。
#
gitok=false
isGitExist() {
  cd ${SOURCE_PATH}
  if [ -d "${SOURCE_PATH}/${repository}/${target}" ]; then
    cd ${SOURCE_PATH}/${repository}/${target}
    #(1)删除git状态零时文件
    if [ -f "gitstatus.tmp" ]; then
      rm -rf gitstatus.tmp
    fi

    #(2) 判断是否存在.git目录
    if [ -d "./.git" ]; then
      #(3) 判断git是否可用
      git status &> gitstatus.tmp
      grep -iwq 'not a git repository' gitstatus.tmp && gitok=false || gitok=true
    fi

    #返回到主目录
    cd ${SOURCE_PATH}
  fi
}

#
# 如果 git 版本库存在（根据 ${gitok} 值），执行 fetch 操作；反之，执行 clone 操作。
#
doFetchOrClone() {
  if [ ! -d "${SOURCE_PATH}" ]; then
    mkdir -p ${SOURCE_PATH}
  fi
  if ${gitok}; then
    cd ${SOURCE_PATH}/${repository}/${target}
    git reset --hard
    git clean -ffdx
    git fetch
    echo "git fetch ${repository} remote repository 到本地成功"
  else
    #删除所有内容,便于重新进行git clone
    rm -rf ${repository}
    git clone --no-checkout git@github.com:${ACCOUNT}/${repository}.git ${SOURCE_PATH}/${repository}/${target}
    echo "git clone ${repository} remote repository 到本地成功"
    cd ${SOURCE_PATH}/${repository}/${target}
  fi
}

#
# 切换到 ${branch} 分支
#
doCheckout() {
  echo "检出 ${repository} ${branch} 分支代码"
  isRemoteBranch=false
  gitRemoteBranch=`git branch -r`
  echo -e "$gitRemoteBranch" | grep -iwq ${branch} && isRemoteBranch=true || isRemoteBranch=false
  if ${isRemoteBranch}; then
    echo "找到 ${branch} 对应的远端分支"
    git checkout -f 'origin/'${branch}
  else
    git checkout -f ${branch}
  fi
  echo "更新子模块代码"
  git submodule update --init --recursive --force
}

##############################__MAIN__########################################
export LANG="zh_CN.UTF-8"
ACCOUNT=dunwu
SOURCE_PATH=/home/zp/source

# 必填输入参数
repository=`echo $1`
branch=`echo $2`

# 可选输入参数
source=`echo $3`
target=`echo $4`
if [ "${source}" != "" ]; then
  SOURCE_PATH=${source}
fi

# 0. 检查传入的参数
checkInput

# 1. 判断本地是否已存在 Git 仓库
isGitExist

# 2. 如果本地已有代码，执行 fetch；反之，从远程 clone
doFetchOrClone

# 3. 切换到指定分支
doCheckout

echo "代码检出完成！"
