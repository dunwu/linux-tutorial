#!/usr/bin/env bash

printHeadInfo() {
cat << EOF
###################################################################################
# Linux CentOS 环境初始化脚本（设置环境配置、安装基本的命令工具）
# Author: Zhang Peng
###################################################################################

EOF
}

# 入口函数
main() {
PS3="请选择要执行的操作："
select ITEM in "替换 yum 镜像" "安装基本的命令工具" "安装常用 libs" "系统配置" "全部执行"
do

case ${ITEM} in
  "替换 yum 镜像")
    ${filepath}/yum/change-yum-repo.sh
  ;;
  "安装基本的命令工具")
    ${filepath}/install-tools.sh
  ;;
  "安装常用 libs")
    ${filepath}/install-libs.sh
  ;;
  "系统配置")
    ${filepath}/sys-settings.sh
  ;;
  "全部执行")
    ${filepath}/yum/change-yum-repo.sh
    ${filepath}/install-tools.sh
    ${filepath}/install-libs.sh
    ${filepath}/sys-settings.sh
  ;;
  *)
    echo -e "输入项不支持！"
    main
  ;;
esac
break
done
}

######################################## MAIN ########################################
filepath=$(cd "$(dirname "$0")"; pwd)

printHeadInfo
main
