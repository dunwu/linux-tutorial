#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install all tools"

./git/install-git.sh
./jdk/install-jdk8.sh
./maven/install-maven3.sh
./nginx/install-nginx.sh
./nodejs/install-nodejs.sh
./tomcat/install-tomcat8.sh
