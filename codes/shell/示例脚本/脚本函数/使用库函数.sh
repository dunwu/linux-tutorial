#!/bin/bash

#using a library file the wrong way

. ./脚本库.sh

result=`addem 10 15`
echo "The result is $result"
