#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install Node.js"

# 安装 nvm
rm -rf ~/.nvm
git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm
source ~/.nvm/nvm.sh

# 使用 nvm 安装 Node 指定版本
nvm install 8.9.4
