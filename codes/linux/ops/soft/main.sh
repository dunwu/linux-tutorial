#!/usr/bin/env bash

cat << EOF

***********************************************************************************
* 欢迎使用 Linux CentOS 软件安装配置脚本
* Author: Zhang Peng
***********************************************************************************

EOF

path=$(cd "$(dirname "$0")"; pwd)
PS3="Please select script type: "
select item in "git" "zsh" "jdk" "maven" "nodejs" "mongodb" "redis" "tomcat" "kafka" "rocketmq" "zookeeper"
do
path=$(cd "$(dirname "$0")"; pwd)
case ${item} in
  "git") yum install -y git ;;
  "zsh") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/zsh-install.sh | bash ;;
  "jdk") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/jdk8-install.sh | bash ;;
  "maven") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash ;;
  "nodejs") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/nodejs-install.sh | bash ;;
  "mongodb") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/mongodb-install.sh | bash ;;
  "redis") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/redis-install.sh | bash ;;
  "tomcat") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/tomcat8-install.sh | bash ;;
  "kafka") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/kafka-install.sh | bash ;;
  "rocketmq") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/rocketmq-install.sh | bash ;;
  "zookeeper") curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/zookeeper-install.sh | bash ;;
  *)
    echo -e "输入项不支持！"
    main
  ;;
esac
break
done

