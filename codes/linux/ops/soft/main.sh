#!/usr/bin/env bash

cat << EOF

***********************************************************************************
* 欢迎使用 Linux CentOS 软件安装配置脚本
* Author: Zhang Peng
***********************************************************************************

EOF

path=$(cd "$(dirname "$0")"; pwd)
PS3="Please select script type: "
select item in "git" "jdk" "maven"
do
path=$(cd "$(dirname "$0")"; pwd)
case ${item} in
  "git") yum install -y git ;;
  "jdk") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/jdk8-install.sh | bash ;;
  "maven") wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash ;;
  "nodejs") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/nodejs-install.sh | bash ;;
  "redis") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/redis-install.sh | bash ;;
  *)
    echo -e "输入项不支持！"
    main
  ;;
esac
break
done

