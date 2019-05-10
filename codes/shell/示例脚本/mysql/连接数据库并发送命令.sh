#!/bin/bash

#连接数据库
mysql=`which mysql
`
#发送单个命令
$mysql emwjs -u test -e "show databases;"

#发送多个命令
$mysql emwjs -u test <<EOF
show tables;
select * from em_admin;
EOF
