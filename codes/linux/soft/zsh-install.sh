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

printf "${GREEN}>>>>>>>> install zsh begin.${RESET}\n"

command -v yum > /dev/null 2>&1 || {
	printf "${RED}Require yum but it's not installed.${RESET}\n";
	exit 1;
}
command -v git > /dev/null 2>&1 || {
	printf "${RED}Require git but it's not installed.${RESET}\n";
	exit 1;
}

# install zsh
yum install -y zsh
chsh -s /bin/zsh
# install oh-my-zsh
# 由于国内经常无法使用 sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 所以，索性将安装脚本下载下来直接使用
#curl -o- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
zsh/oh-my-zsh-install.sh
# choose oh-my-zsh theme
sed -i "s/^ZSH_THEME=.*/ZSH_THEME=\"ys\"/g" ~/.zshrc
# install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
sed -i "s/^plugins=.*/plugins=(git z wd extract zsh-autosuggestions zsh-syntax-highlighting)/g" ~/.zshrc
# reload zsh
# 注册到 /etc/shells
echo "/usr/bin/zsh" >> /etc/shells
# 切换 shell
chsh -s $(which zsh)
printf "${GREEN}<<<<<<<< install zsh finished${RESET}\n"
printf "${GREEN}Please reboot to take effect.${RESET}\n"
