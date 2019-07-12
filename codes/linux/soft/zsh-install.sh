#!/usr/bin/env bash

###################################################################################
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
###################################################################################

printf "${BLUE}"
cat << EOF

###################################################################################
# 安装 zsh、oh-my-zsh 脚本
# @system: 适用于 CentOS
# @author: Zhang Peng
# See: https://github.com/robbyrussell/oh-my-zsh
###################################################################################

EOF
printf "${RESET}"

printf "${BLUE}>>>>>>>> install zsh\n${RESET}"

command -v yum >/dev/null 2>&1 || { printf "${RED}Require yum but it's not installed.${RESET}\n"; exit 1; }

# install zsh
yum install -y zsh
# install oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# choose oh-my-zsh theme
sed -i "s/^ZSH_THEME=.*/ZSH_THEME=\"ys\"/g" ~/.zshrc
# install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
sed -i "s/^plugins=.*/plugins=(git z wd extract zsh-autosuggestions zsh-syntax-highlighting)/g" ~/.zshrc
# reload zsh
source ~/.zshrc

printf "${GREEN}<<<<<<<< install zsh finished\n${RESET}"
