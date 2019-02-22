#!/usr/bin/env bash

###################################################################################
# 彻底关闭防火墙
# 参考：https://www.cnblogs.com/moxiaoan/p/5683743.html
# Author: Zhang Peng
###################################################################################

systemctl stop firewalld
systemctl disable firewalld
