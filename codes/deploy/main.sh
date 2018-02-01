#!/bin/bash
###################################################################################
# 环境部署脚本
###################################################################################

function printBeginning() {
cat << EOF
***********************************************************************************
* Welcome to using the deployment script for linux.
* Author: Zhang Peng
***********************************************************************************
EOF
}

function printEnding() {
cat << EOF
***********************************************************************************
* Deployment is over.
* Thank you for using!
***********************************************************************************
EOF
}

function checkOsVersion(){
  if(($1 == 1))
  then
    platform=`uname -i`
    if [ $platform != "x86_64" ];then
    echo "this script is only for 64bit Operating System !"
    exit 1
    fi
    echo "the platform is ok"
    version=`lsb_release -r |awk '{print substr($2,1,1)}'`
    if [ $version != 6 ];then
    echo "this script is only for CentOS 6 !"
    exit 1
    fi
  fi
}


function showMenu() {
cat << EOF

=================================== Deploy Menu ===================================
【1 - System Environment】
    [1-2 | libs] install commonly libs.

【2 - Common Tools】
    [2 | tools] install all tools.
    [2-1 | git] install git.                 [2-2 | jdk8] install jdk8.
    [2-3 | maven] install maven.             [2-4 | nginx] install nginx.
    [2-5 | nodejs] install node.js.          [2-6 | tomcat] install tomcat8.

Press <CTRL-D> to exit
Please input key：
EOF
}

key=""
filepath=$(cd "$(dirname "$0")"; pwd)
function chooseOper() {
  while read key
  do
    case ${key} in
      1-2 | libs) ${filepath}/lib/install-libs.sh;;

      2 | tools) ${filepath}/tool/install-all.sh;;
      2-1 | git) ${filepath}/tool/git/install-git.sh;;
      2-2 | jdk8) ${filepath}/tool/jdk/install-jdk8.sh;;
      2-3 | maven) ${filepath}/tool/maven/install-maven.sh;;
      2-4 | nginx) ${filepath}/tool/nginx/install-nginx.sh;;
      2-5 | nodejs) ${filepath}/tool/nodejs/install-nodejs.sh;;
      2-6 | tomcat) ${filepath}/tool/tomcat/install-tomcat8.sh;;
      * ) echo "invalid key";;
    esac

    showMenu
  done
}



######################################## MAIN ########################################
printBeginning
checkOsVersion 0
showMenu
chooseOper
printEnding
