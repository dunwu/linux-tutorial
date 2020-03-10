#!/usr/bin/env bash

path=/dir1/dir2/dir3/test.txt
echo ${path##*/}  获取文件名  test.txt
echo ${path##*.}  获取后缀  txt

#不带后缀的文件名
temp=${path##*/}
echo ${temp%.*}  test

#获取目录
echo ${path%/*} /dir1/dir2/dir3
