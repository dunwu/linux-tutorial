#!/usr/bin/env bash

if [[ -z $1 ]]; then
  echo "please input first param";
  exit
fi

if [[ -z $2 ]]; then
  echo "please input second param";
  exit
fi

if [[ $1 > $2 ]]; then
  echo "\$1 > \$2";
elif [[ $1 < $2 ]]; then
  echo "\$1 < \$2";
else
  echo "\$1 != \$2";
fi

# execute: ./ifDemo.sh abc abc
# output:
# $1 == $2

# execute: ./ifDemo.sh abc ab
# output:
# $1 != $2
