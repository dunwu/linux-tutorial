#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install Node.js"

mkdir -p /opt/software/tomcat
cd /opt/software/tomcat

version=8.5.27
wget http://apache.fayea.com/tomcat/tomcat-8/v${version}/bin/apache-tomcat-${version}.tar.gz
tar -zxvf apache-tomcat-${version}.tar.gz
