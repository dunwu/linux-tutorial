#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install springboot"

sdk version
execode=$?
if [ "${execode}" != "0" ]; then
  echo "请先安装 sdkman"
  exit 1
fi

sdk install springboot
spring --version
