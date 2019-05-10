#!/bin/bash

#跳转到指定脚本
sed '{/first/b jump1; s/This is the/No jump on/; :jump1; s/This is the/Jump here on/}' test

#跳转到开头,删除每一个逗号，并保证删除最后一个逗号之后，跳出循环
sed -n '{:start; s/,//1p; /,/b start}' test
