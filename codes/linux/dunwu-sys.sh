#!/usr/bin/env bash

cat << EOF

###################################################################################
# Linux CentOS 环境初始化脚本（设置环境配置、安装基本的命令工具）
# @author: Zhang Peng
###################################################################################

EOF

menus=("替换yum镜像" "安装基本的命令工具" "安装常用libs" "系统配置" "全部执行" "退出")
main() {
PS3="请输入命令编号："
select item in ${menus[@]}
do
case ${item} in
  "替换yum镜像")
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/change-yum-repo.sh | bash
    main ;;
  "安装基本的命令工具")
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/install-tools.sh | bash
    main ;;
  "安装常用libs")
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/install-libs.sh | bash
    main ;;
  "系统配置")
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/sys-settings.sh | bash
    main ;;
  "全部执行")
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/change-yum-repo.sh | bash
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/install-tools | bash
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/install-libs.sh | bash
    curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/sys/sys-settings.sh | bash
    printf "执行完毕，退出。\n" ;;
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
main
