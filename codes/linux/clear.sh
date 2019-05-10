#!/usr/bin/env bash

path=/tmp/dunwu-ops/
printf "\n>>>>>>>>> remove ${path}"

if [[ -d ${path} ]]; then
  rm -f ${path}
  printf "清除脚本成功"
else
   printf "${path} 不存在，无法执行清除脚本操作"
fi
