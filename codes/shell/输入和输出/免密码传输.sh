#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# 免密码传输
# @author Zhang Peng
# @since 2020/4/8
# ------------------------------------------------------------------------------

REMOTE_HOST=192.168.0.2

# 如果本机没有公私钥对，可以执行以下命令生成 ssh 公私钥对
#ssh-keygen -t rsa

# 服务器 A 上执行以下命令
scp ~/.ssh/id_rsa.pub root@${REMOTE_HOST}:~/.ssh/id_rsa.pub.tmp

# 服务器 B 上执行以下命令
cat ~/.ssh/id_rsa.pub.tmp >> ~/.ssh/authorized_keys
rm ~/.ssh/id_rsa.pub.tmp
