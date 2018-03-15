#!/usr/bin/env bash

###################################################################################
# 本脚本用于替换 yum repo
# 要求：仅适用于 Linux Centos 发行版本，并且环境必须已支持 yum 、lsb_release 命令
# Author: Zhang Peng
###################################################################################

echo -e "\n>>>>>>>>> 替换 yum repo 源"

# 备份
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 执行 lsb_release 命令，获取系统发行版本
# version=`lsb_release -r | awk '{print substr($2,1,1)}'` # 很多机器没有 lsb_release 命令
version=`cat /etc/redhat-release | awk '{print substr($4,1,1)}'`

# 根据发型版本选择相应 yum 镜像
if [ ${version} == 5 ]; then
  # Cento5 已废弃，只能使用 http://vault.centos.org/ 替换，但由于是国外镜像，速度较慢
  wget --no-cookie --no-check-certificate -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/dunwu/linux/master/codes/deploy/sys/yum/CentOS-Base.repo

  # 根据实际发型版本情况替换
  detailVersion=`lsb_release -r | awk '{print substr($2,1,3)}'`
  sed -i 's/$releasever/'"${detailVersion}"'/g' /etc/yum.repos.d/CentOS-Base.repo

  # 不替换下面的开关，可能会出现错误：Could not open/read repomd.xml
  sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/CentOS-Media.repo
else
  # 国内 aliyun 镜像
  wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-${version}.repo

  # 国内 163 镜像（备选）
  #wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS${version}-Base-163.repo
fi

# 更新缓存
yum clean all
yum makecache

echo -e "\n>>>>>>>>> 替换 yum repo 源成功"
