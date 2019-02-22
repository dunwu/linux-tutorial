#!/usr/bin/env bash

###################################################################################
# 安装 zsh、oh-my-zsh 脚本
# 适用于 Centos
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> install zsh"

# 安装 zsh
yum install -y zsh
# 安装 oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# 替换 oh-my-zsh 主题
sed -i "s#^ZSH_THEME=.*#ZSH_THEME=\"ys\"#g" ~/.zshrc
# 下载 incr.zsh 补全插件
wget http://mimosa-pudica.net/src/incr-0.2.zsh
cp incr-0.2.zsh ~/.oh-my-zsh/plugins/incr/
echo "source ~/.oh-my-zsh/plugins/incr/incr*.zsh" >> ~/.zshrc

# 更新配置
source ~/.zshrc
