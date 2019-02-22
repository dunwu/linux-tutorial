#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install all tools"

filepath=$(cd "$(dirname "$0")"; pwd)

${filepath}/git/install-git.sh
${filepath}/git/install-svn.sh
${filepath}/jdk/install-jdk8.sh
${filepath}/maven/install-maven.sh
${filepath}/nginx/install-nginx.sh
${filepath}/nodejs/install-nodejs.sh
${filepath}/tomcat/install-tomcat8.sh
${filepath}/elk/install-elk.sh

