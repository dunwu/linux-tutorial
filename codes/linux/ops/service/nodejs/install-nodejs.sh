#!/usr/bin/env bash

###################################################################################
# 安装 Nodejs 脚本
# 适用于所有 linux 发行版本。
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install node.js"

. ~/.nvm/nvm.sh
nvm --version
execode=$?
if [[ ${execode} != 0 ]]; then
  echo -e "\n未找到 nvm ，开始安装"
  echo -e "\n>>>>>>>>> install nvm"
  rm -rf ~/.nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  . ~/.nvm/nvm.sh
  nvm --version
fi

version=8.9.4
nvm install ${version}
nvm use ${version}
node --version
