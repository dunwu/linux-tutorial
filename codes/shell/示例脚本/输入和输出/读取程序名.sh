#!/bin/bash
# testing the $0 parameter

echo The command entered is $0

#当传给$0变量的真实字符串是整个脚本的路径是，程序中就会使用整个路径，而不仅仅是程序名

name=`basename $0`
echo The command entered is $name
