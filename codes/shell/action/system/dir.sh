#!/usr/bin/env bash

current_dir=$(cd `dirname $0`; pwd)
echo "当前目录是：${current_dir}"

parent_dir=$(dirname $(pwd))
echo "父目录是：${parent_dir}"
