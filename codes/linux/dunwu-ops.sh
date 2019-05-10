#!/usr/bin/env bash

# 打印头部信息
printHeadInfo() {
cat << EOF

***********************************************************************************
* 欢迎使用 Linux CentOS 环境运维脚本
* @author: Zhang Peng
***********************************************************************************

EOF
}

# 打印尾部信息
printFootInfo() {
cat << EOF

***********************************************************************************
* 脚本执行结束，感谢使用！
***********************************************************************************

EOF
}

# 检查操作系统环境
checkOsVersion(){
  if(($1 == 1)); then
    echo -e "检查操作系统环境是否兼容本套脚本"

    platform=`uname -i`
    if [[ ${platform} != "x86_64" ]]; then
      echo "脚本仅支持 64 位操作系统！"
      exit 1
    fi

    version=`cat /etc/redhat-release | awk '{print substr($4,1,1)}'`
    if [[ ${version} != 7 ]]; then
      echo "脚本仅支持 CentOS 7！"
      exit 1
    fi

    echo -e "脚本可以在本环境运行！"
  fi
}

menus=("配置系统" "安装软件" "退出")
main() {
PS3="请输入命令编号："
select item in ${menus[@]}
do
case ${item} in
  "配置系统")
    ./dunwu-sys.sh
    main ;;
  "安装软件")
    ./dunwu-soft.sh
    main ;;
  "退出")
    exit 0 ;;
  *)
    printf "输入项不支持！\n"
    main ;;
esac
break
done
}

######################################## MAIN ########################################
path=$(cd "$(dirname "$0")"; pwd)
printHeadInfo
checkOsVersion 0
main
printFootInfo
