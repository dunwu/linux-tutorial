#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 zsh、oh-my-zsh 脚本
# @system: 适用于 CentOS
# @author: Zhang Peng
# See: https://github.com/robbyrussell/oh-my-zsh
###################################################################################

EOF

command -v yum >/dev/null 2>&1 || { echo >&2 "Require yum but it's not installed.  Aborting."; exit 1; }

echo -e "\n>>>>>>>>> install zsh"
yum install -y zsh

echo -e "\n>>>>>>>>> install oh-my-zsh"
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# 替换 oh-my-zsh 主题
sed -i "s#^ZSH_THEME=.*#ZSH_THEME=\"ys\"#g" ~/.zshrc
# 下载 incr.zsh 补全插件
wget http://mimosa-pudica.net/src/incr-0.2cd.zsh
mkdir ~/.oh-my-zsh/plugins/incr/
mv incr-0.2.zsh ~/.oh-my-zsh/plugins/incr/
echo "source ~/.oh-my-zsh/plugins/incr/incr*.zsh" >> ~/.zshrc

# 更新配置
source ~/.zshrc
