#!/usr/bin/env bash

# 打印头部信息
printHeadInfo() {
cat << EOF

***********************************************************************************
* 欢迎使用 Linux CentOS 服务安装配置脚本
* Author: Zhang Peng
***********************************************************************************

EOF
}

main() {
PS3="Please select script type: "
select item in "git" "jdk" "maven"
do
path=$(cd "$(dirname "$0")"; pwd)
case ${item} in
  "git") yum install -y git ;;
  "jdk") ${path}/jdk/install-jdk8.sh ;;
  "maven") ${path}/maven/install-maven3.sh ;;
  *)
    echo -e "输入项不支持！"
    main
  ;;
esac
break
done
}

filepath=$(cd "$(dirname "$0")"; pwd)

######################################## MAIN ########################################
path=$(cd "$(dirname "$0")"; pwd)

printHeadInfo
main
