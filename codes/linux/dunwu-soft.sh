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

printf "${BLUE}\n"
cat << EOF

***********************************************************************************
* 欢迎使用 Linux CentOS 软件安装配置脚本
* @author: Zhang Peng
***********************************************************************************

EOF

# print menu
printf "${PURPLE}"
menus=(docker fastdfs gitlab jdk8 jenkins kafka maven mongodb mysql nacos nexus nginx nodejs redis rocketmq tomcat8
zookeeper zsh exit)
for i in "${!menus[@]}"; do
  index=`expr ${i} + 1`
  val=`expr ${index} % 2`
  printf "[%02d] %-20s" "${index}" "${menus[$i]}"
  if [[ ${val} -eq 0 ]]; then
    printf "\n"
  fi
done
printf "\n${RESET}请输入需要安装的软件编号：\n"

# exec shell to install soft
doInstall() {
read -t 30 index
if [[ -n ${index} ]]; then
  no=`expr ${index} - 1`
  len=${#menus[*]}
  if [[ ${index} -gt ${len} ]]; then
     echo "输入项不支持！"
     exit -1
  fi
  key=${menus[$no]}
  if [[ key == 'exit' ]]; then
    exit 0
  fi
  curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/${key}-install.sh | bash
  doInstall
else
  echo "输入项不支持！"
  exit -1
fi
}
doInstall
