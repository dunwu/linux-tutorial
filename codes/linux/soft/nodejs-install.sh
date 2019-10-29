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
# 通过 nvm 安装 Nodejs 脚本
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
# @see: https://github.com/nvm-sh/nvm
###################################################################################

EOF
printf "${RESET}"

printf "${GREEN}>>>>>>>> install nodejs begin.${RESET}\n"

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	printf "${PURPLE}[Hint]\n"
	printf "\t sh nodejs-install.sh [version]\n"
	printf "\t Example: sh nodejs-install.sh 10.15.2\n"
	printf "${RESET}\n"
fi

version=10.15.2
if [[ -n $1 ]]; then
	version=$1
fi

# install info
printf "${PURPLE}[Info]\n"
printf "\t version = ${version}\n"
printf "${RESET}\n"

# install nvm
printf "${GREEN}>>>>>>>> install nvm.${RESET}\n"
rm -rf ~/.nvm
mkdir -p ~/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm --version

printf "${GREEN}>>>>>>>> install nodejs by nvm.${RESET}\n"
nvm install ${version}
nvm use ${version}
node --version

printf "${GREEN}<<<<<<<< install nodejs end.${RESET}\n"
