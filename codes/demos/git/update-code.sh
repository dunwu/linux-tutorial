#!/bin/bash

# xyz 下载代码通用脚本
# 需要指定参数：仓库名、分支名

# xyz 源码根目录
SOURCE_PATH=/home/zp
GITHUB_HOST=https://github.com/dunwu

gitok=false
isGitExist() {
  cd ${SOURCE_PATH}
  if [ -d "./${target}" ]; then
    cd ./${target}
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

doFetchOrClone() {
  if ${gitok}; then
    cd ./${target}
    git reset --hard
    git clean -ffdx
    git fetch
    echo "git fetch ${repository} remote repository 到本地成功"
  else
    #删除所有内容,便于重新进行git clone
    rm -rf ${repository}
    git clone --no-checkout ${GITHUB_HOST}/${repository} ./${target}
    echo "git clone ${repository} remote repository 到本地成功"
    cd ./${target}
  fi
}

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

# 0. 检查传入的参数
repository=`echo $1`
branch=`echo $2`
target=`echo $3`
if [ "${repository}" == "" ] || [ "${branch}" == "" ];
then
  echo "用法：repository branch target"
  echo "      repository: git仓储。"
  echo "      branch: git分支。"
  echo "      target: 代码存放目录。可选参数，默认为脚本所在目录。"
  exit 0
fi

# 1. 判断本地是否已存在 Git 仓库
isGitExist

# 2. 如果本地已有代码，执行 fetch；反之，从远程 clone
doFetchOrClone

# 3. 切换到指定分支
doCheckout

echo "代码检出完成！"
