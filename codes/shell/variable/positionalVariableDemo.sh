#!/usr/bin/env bash

### 如果变量为空，赋给他们默认值
: ${VAR:='default'}
: ${1:='first'}
echo "\$1 : " $1
: ${2:='second'}
echo "\$2 : " $2

### 或者
FOO=${FOO:-'default'}
echo "FOO : " ${FOO}

# execute: ./positionalVariableDemo.sh big small
# output:
# $1 :  big
# $2 :  small
# FOO :  default
