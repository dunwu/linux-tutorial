#!/bin/bash
###################################################################################
# Linux Centos 环境部署脚本
# Author: Zhang Peng
###################################################################################

function printBeginning() {
cat << EOF
***********************************************************************************
* Welcome to using the deployment script for Centos.
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
    [sys] initial system environment
    [libs] install commonly libs

【2 - Common Tools】
    [2 | tools] install all tools.
    [git] install git                          [svn] install svn
    [jdk8] install jdk8                        [maven] install maven
    [tomcat] install tomcat8                   [nginx] install nginx
    [nodejs] install node.js                   [elk] install elk

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
      sys) ${filepath}/sys/init.sh;;
      libs) ${filepath}/lib/install-libs.sh;;

      2 | tools) ${filepath}/tool/install-all.sh;;
      git) ${filepath}/tool/git/install-git.sh;;
      svn) ${filepath}/tool/svn/install-svn.sh;;
      jdk8) ${filepath}/tool/jdk/install-jdk8.sh;;
      maven) ${filepath}/tool/maven/install-maven.sh;;
      nginx) ${filepath}/tool/nginx/install-nginx.sh;;
      nodejs) ${filepath}/tool/nodejs/install-nodejs.sh;;
      tomcat) ${filepath}/tool/tomcat/install-tomcat8.sh;;
      elk) ${filepath}/tool/elk/install-elk.sh;;
      * ) echo "${key} is invalid key";;
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
