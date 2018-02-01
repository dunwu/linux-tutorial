#!/bin/bash

echo -e "\n>>>>>>>>> install jdk8"

wget http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm?AuthParam=1471671456_14c9442ffc64438c1b8fc83587ecdf47
path = './jdk-7u79-linux-x64.rpm'

echo '正在安装JDK...'
#update java
for installedJava in $(rpm -qa |grep java);do
rpm -e --nodeps $installedJava
done
rpm -ivh $path
sunJava=$(ls /usr/java |grep jdk)
if [ "$sunJava" != "" ];then
cat >/etc/profile.d/java.sh<<EOF
JAVA_HOME=/usr/java/$sunJava
PATH=$JAVA_HOME/bin:\$PATH
CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
export JAVA_HOME
export PATH
export CLASSPATH
EOF
chown root.root /etc/profile.d/java.sh
fi
