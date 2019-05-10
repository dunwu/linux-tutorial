#!/usr/bin/env bash

cat << EOF

***********************************************************************************
* 欢迎使用 Linux CentOS 软件安装配置脚本
* @author: Zhang Peng
***********************************************************************************

EOF

menus=("git" "zsh" "jdk8" "maven" "nodejs" "mongodb" "redis" "tomcat8" "kafka" "rocketmq" "zookeeper")
printMenu() {
for i in "${!menus[@]}"; do
  index=`expr ${i} + 1`
  val=`expr ${index} % 2`
  printf "(%02d) %-20s" "${index}" "${menus[$i]}"
  if [[ ${val} -eq 0 ]]; then
    printf "\n"
  fi
done
printf "\n请输入需要安装的软件编号：\n"
}


main() {
read -t 30 index
if [[ -n $index ]]; then
  no=`expr ${index} - 1`
  len=${#menus[*]}
  if [[ ${index} -gt ${len} ]]; then
     echo "输入项不支持！"
     exit -1
  fi
  key=${menus[$no]}
  curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/soft/${key}-install.sh | bash
else
  echo "输入项不支持！"
  exit -1
fi

}

######################################## MAIN ########################################
printMenu
main
