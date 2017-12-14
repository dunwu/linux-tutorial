#!/usr/bin/env bash

# 次脚本适用于 Centos/RedHat


init() {
  echo "${IP} 机器环境部署开始" |tee ${DEPLOY_LOG_PATH}
  touch ${DEPLOY_LOG_PATH}
  chmod 777 ${DEPLOY_LOG_PATH}
  git clone git@github.com:dunwu/linux-notes.git ${SOURCE_PATH}/linux-notes
}

# 获取当前机器 IP
IP="127.0.0.1"
getDeviceIp() {
  IP=`ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`
  if [ "$IP" ==  "" ]; then
    IP=`ifconfig ens32 | grep "inet"|grep "broadcast" | awk '{ print $2}' | awk -F: '{print $1}'`
  fi
}

installGit() {
  echo "安装 git" |tee ${DEPLOY_LOG_PATH}
  yum install -y git
}

initEnviromentConfig() {
  echo "修改环境配置文件 profile 和 hosts" | tee ${DEPLOY_LOG_PATH}
  if [ ! -f /etc/profile.bak ]
  then
    cp /etc/profile /etc/profile.bak
  fi
  cat ${SOURCE_PATH}/linux-notes/codes/deploy/profile >> /etc/profile
  source /etc/profile
}

installJava() {
  echo "安装 jdk" | tee ${DEPLOY_LOG_PATH}
  yum -y install java-1.8.0-openjdk-devel-debug.x86_64 | tee ${DEPLOY_LOG_PATH}
}

installMaven() {
  echo "安装 maven" | tee ${DEPLOY_LOG_PATH}
  mkdir ${SOFTWARE_PATH}/maven
  cd ${SOFTWARE_PATH}/maven
  echo "解压 apache-maven-3.5.2-bin.tar.gz" | tee ${DEPLOY_LOG_PATH}
  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://mirrors.shuosc.org/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
  tar -zxvf apache-maven-3.5.2-bin.tar.gz
}

installGcc() {
  echo "安装 gcc" | tee ${DEPLOY_LOG_PATH}
  yum -y install make gcc gcc-c++ kernel-devel
}

installZlib() {
  echo "安装 zlib" | tee ${DEPLOY_LOG_PATH}
  yum -y install make zlib zlib-devel libtool openssl openssl-devel
}

installOpenssl() {
  echo "安装 openssl" | tee ${DEPLOY_LOG_PATH}
  yum -y install make openssl openssl-devel
}

installPcre() {
  echo "安装 Pcre" | tee ${DEPLOY_LOG_PATH}
  yum -y install pcre-devel.x86_64
}

installNginx() {
  echo "安装 Nginx" | tee ${DEPLOY_LOG_PATH}
  yum -y install make nginx.x86_64
  cp /etc/nginx/mime.types /usr/local/nginx/conf/
}

installNodejsAndNvm() {
  echo "安装 Nodejs" | tee ${DEPLOY_LOG_PATH}
  yum install -y nodejs npm --enablerepo=epel

  git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm
  source ~/.nvm/nvm.sh
}

shutdownFirewall() {
  echo "************************关闭防火墙************************" |tee -a /home/depoly.log
  /etc/init.d/iptables stop
  chkconfig --level 35 iptables off
}

setPrivilegeForUserIns() {
  userdel zp
  groupdel coder
  groupadd coder
  useradd -g coder zp
  chown -R coder.zp /home/zp
  chown -R coder.zp /opt/
  chown -R coder.zp /tmp/
}
##############################__MAIN__########################################
DEPLOY_LOG_PATH=/home/zp/deploy.log
SOURCE_PATH=/home/zp/source
SOFTWARE_PATH=/usr/lib

init
getDeviceIp
installGit
initEnviromentConfig
installJava
installGcc
installZlib
installOpenssl
installPcre
installNginx
installMaven
installNodejsAndNvm
shutdownFirewall
setPrivilegeForUserIns
