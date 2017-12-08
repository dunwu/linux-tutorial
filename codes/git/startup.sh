#!/bin/bash

export LANG="zh_CN.UTF-8"
export JAVA_HOME=/opt/software/jdk1.8.0_121

##############################__MAIN__########################################
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

# 1. 更新代码
sh update-code.sh ${repository} ${branch} ${target}

# 2. 编译
cd ${target}/codes
echo "编译开始"
mvn clean package -Dmaven.test.skip=true
echo "编译结束"
