#!/bin/bash

echo -e "\n>>>>>>>>> install jdk8"

yum -y install java-1.8.0-openjdk-devel-debug.x86_64

cat >> /etc/profile << EOF
JAVA_HOME=/usr/lib/jvm/java
PATH=${JAVA_HOME}/bin:\$PATH
CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
export JAVA_HOME
export PATH
export CLASSPATH
EOF
source /etc/profile
