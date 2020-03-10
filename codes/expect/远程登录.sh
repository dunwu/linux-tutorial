#!/usr/bin/expect -f

# -----------------------------------------------------------------------------------------------------
# expect 交互式脚本示例 - 自动远程登录，并在其他机器上创建一个文件
# @author Zhang Peng
# -----------------------------------------------------------------------------------------------------

# 设置变量
set USER "root"
set PWD "XXXXXX"
set HOST "127.0.0.2"
# 设置超时时间
set timeout 400

# 远程登录
spawn ssh -p 22 $USER@$HOST
expect {
  "yes/no" { send "yes\r"; exp_continue }
  "password:" { send "$PWD\r" }
}

# 在其他机器上创建
expect "#"
send "touch /home/demo.txt\r"
expect "#"
send "echo hello world >> /home/demo.txt\r"
expect "#"
# 退出
send "exit\r"
