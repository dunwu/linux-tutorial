#!/usr/bin/env bash

#######################################################################
# 启动退出开关：当执行命令返回非0（0表示成功）状态码时，脚本退出执行。
# 次脚本适用于 Centos/RedHat
#######################################################################

# 获取当前机器 IP
IP=""
getDeviceIp() {
  IP=`ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`
  if [ "$IP" ==  "" ]
  then
      IP=`ifconfig ens32 | grep "inet"|grep "broadcast" | awk '{ print $2}' | awk -F: '{print $1}'`
  fi

  echo "${IP} 机器环境部署开始" |tee ${DEPLOY_LOG_PATH}
  if [ "$IP" ==  "" ]
  then
      IP=`echo $1`
  fi

  if [ "${IP}" ==  "" ]
    then
          echo "     "
          echo " 请输入服务器IP地址................ "
          echo "     "
      exit 0
  fi
}

touch ${DEPLOY_LOG_PATH}
chmod 777 ${DEPLOY_LOG_PATH}
installGit() {
  echo "安装 git" |tee ${DEPLOY_LOG_PATH}
  yum install -y git-core
  yum install -y git
}

copyXyzdeploy() {
  echo "克隆 xyzdeploy 项目到本地" | tee ${DEPLOY_LOG_PATH}
  rm -rf ${SOFTWARE_ROOT}*
  rm -rf ${DEPLOY_ROOT}
  git clone git@github.com:dunwu/linux-notes.git ${DEPLOY_ROOT}
  chmod -R 755 ${DEPLOY_ROOT}/*
  cp -rf ${DEPLOY_ROOT}/software ${SOFTWARE_ROOT}
  cp -rf ${DEPLOY_ROOT}/config/ /home/zp/
  cp -rf ${DEPLOY_ROOT}/script/ /home/zp/

  sed -i 's/127.0.0.1/'"${IP}"'/g' /home/zp/config/nginx/vmhosts/*.conf
}

initEnviromentConfig() {
  echo "修改环境配置文件 profile 和 hosts" | tee ${DEPLOY_LOG_PATH}
  if [ ! -f /etc/profile.bak ]
  then
    cp -f /etc/profile /etc/profile.bak
  fi
  cp -f ${DEPLOY_ROOT}/config/enviroment/profile /etc/profile
  source /etc/profile

  if [ ! -f /etc/hosts.bak ]
  then
    cp -f /etc/hosts /etc/hosts.bak
  fi
  cp -f ${DEPLOY_ROOT}/config/enviroment/hosts /etc/hosts
  sed -i 's/0.0.0.0/'"${IP}"'/g' /etc/hosts
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
  echo "安装 Nvm 和 Nodejs" | tee ${DEPLOY_LOG_PATH}
  rm -rf /home/admin/.nvm
  git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm
  source ~/.nvm/nvm.sh

  # 使用 nvm 安装 Node 指定版本
  nvm install 0.10.48
}

installNtp() {
  echo "************************同步时钟************************" |tee -a /home/depoly.log
  yum install -y ntp
  vi /etc/crontab
  echo "*/30 * * * * /usr/local/bin/ntpdate 192.168.16.182" | tee /etc/crontab
}

shutdownFirewall() {
  echo "************************关闭防火墙************************" |tee -a /home/depoly.log
  /etc/init.d/iptables stop
  chkconfig --level 35 iptables off
}

setPrivilegeForUserIns() {
  userdel INS
  groupdel INS
  groupadd INS
  useradd -g INS INS
  mkdir -p /search/statistics
  mkdir -p /home/mic
  mkdir -p /home/INS/logs
  chown -R INS.INS /home/mic
  chown -R INS.INS /search/
  chown -R INS.INS /home/INS/
  chown -R INS.INS /opt/
  chown -R INS.INS /tmp/
}
##############################__MAIN__########################################
DEPLOY_LOG_PATH=/home/zp/log/deploy.log
DEPLOY_ROOT=/home/zp/source/xyzdeploy
SOFTWARE_ROOT=/opt/software

init
getDeviceIp
installGit
copyXyzdeploy
initEnviromentConfig
installJava
installGcc
installZlib
installOpenssl
installPcre
installNginx
installMaven
installNodejsAndNvm
installNtp
shutdownFirewall
setPrivilegeForUserIns
