#!/usr/bin/env bash

# 装载其它库
source ../lib/nodejs.sh

# ------------------------------------------------------------------------------
ROOT=$(pwd)

path=${ROOT}
if [[ $1 ]]; then
    path=$1
fi

version=10.15.0
if [[ $2 ]]; then
    version=$2
fi

buildNodejsProject ${path} ${version}
