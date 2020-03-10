# expect shell 脚本

## expect 简介

`expect` 是一个自动化交互套件，主要应用于执行命令和程序时，系统以交互形式要求输入指定字符串，实现交互通信。

在实际工作中，我们运行命令、脚本或程序时，这些命令、脚本或程序都需要从终端输入某些继续运行的指令，而这些输入都需要人为的手工进行。而利用 `expect`，则可以根据程序的提示，模拟标准输入提供给程序，从而实现自动化交互执行。这就是 `expect` 。

expect 自动交互流程：

1. spawn 启动指定进程
2. expect 获取指定关键字
3. send 向指定程序发送指定字符
4. 执行完成退出

## expect 安装

### yum 安装

执行命令：

```shell
yum -y install expect
```

### 手动安装

expect 依赖 tcl，所以需要先安装 tcl：

```shell
wget https://nchc.dl.sourceforge.net/project/tcl/Tcl/8.6.9/tcl8.6.9-src.tar.gz
tar xf tcl8.6.9-src.tar.gz
cd tcl8.6.9/unix/
./configure && make && sudo make install
```

再安装 expect：

```shell
wget https://nchc.dl.sourceforge.net/project/expect/Expect/5.45.4/expect5.45.4.tar.gz
tar xf expect5.45.4.tar.gz
cd ./expect5.45.4
./configure && make && sudo make install
```

## expect 参数

启用选项：

- `-c` - 执行脚本前先执行的命令，可多次使用。
- `-d` - debug 模式，可以在运行时输出一些诊断信息，与在脚本开始处使用 `exp_internal 1` 相似。
- `-D` - 启用交换调式器，可设一整数参数。
- `-f` - 从文件读取命令，仅用于使用 `#!` 时。如果文件名为 `-`，则从 stdin 读取(使用 `./-` 从文件名为-的文件读取)。
- `-i` - 交互式输入命令，使用 `exit` 或 `EOF` 退出输入状态。
- `--` - 标示选项结束(如果你需要传递与 `expect` 选项相似的参数给脚本时)，可放到 `#!` 行： `#!/usr/bin/expect --` 。
- `-v` - 显示 `expect` 版本信息。

## expect 命令

- `spawn` - 命令用来启动新的进程，`spawn`后的`send`和`expect`命令都是和使用`spawn`打开的进程进行交互。
- `expect` - 获取匹配信息，匹配成功则执行 `expect` 后面的程序动作。
  - `exp_continue` - 在 `expect` 中多次匹配就需要用到。
- `send` - 命令接收一个字符串参数，并将该参数发送到进程。
  - `send exp_send` - 用于发送指定的字符串信息。
- `interact` - 命令用的其实不是很多，一般情况下使用`spawn`、`send`和`expect`命令就可以很好的完成我们的任务；但在一些特殊场合下还是需要使用`interact`命令的，`interact`命令主要用于退出自动化，进入人工交互。比如我们使用`spawn`、`send`和`expect`命令完成了 ftp 登陆主机，执行下载文件任务，但是我们希望在文件下载结束以后，仍然可以停留在 ftp 命令行状态，以便手动的执行后续命令，此时使用`interact`命令就可以很好的完成这个任务。
- `send_user` - 用来打印输出 相当于 shell 中的 echo
- `set` - 定义变量。
  - `set timeout` - 设置超时时间。
- `puts` - 输出变量。
- `exit` - 退出 expect 脚本
- `eof` - expect 执行结束，退出。

## 示例场景

远程登录

（1）ssh 登录远程主机执行命令，执行方法 `expect 1.sh` 或者 `source 1.sh`

```shell
#!/usr/bin/expect

spawn ssh saneri@192.168.56.103 df -Th
expect "*password"
send "123456\n"
expect eof
```

（2）ssh 远程登录主机执行命令，在 shell 脚本中执行 expect 命令,执行方法 sh 2.sh、bash 2.sh 或./2.sh 都可以执行.

```
#!/bin/bash

passwd='123456'

/usr/bin/expect <<-EOF

set time 30
spawn ssh saneri@192.168.56.103 df -Th
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$passwd\r" }
}
expect eof
EOF
```

（3）expect 执行多条命令

```
#!/usr/bin/expect -f

set timeout 10

spawn sudo su - root
expect "*password*"
send "123456\r"
expect "#*"
send "ls\r"
expect "#*"
send "df -Th\r"
send "exit\r"
expect eof
```

（4）创建 ssh key，将 id_rsa 和 id_rsa.pub 文件分发到各台主机上面。

```shell
#!/bin/bash

# 判断id_rsa密钥文件是否存在
if [ ! -f ~/.ssh/id_rsa ];then
 ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
else
 echo "id_rsa has created ..."
fi

#分发到各个节点,这里分发到host文件中的主机中.
while read line
  do
    user=`echo $line | cut -d " " -f 2`
    ip=`echo $line | cut -d " " -f 1`
    passwd=`echo $line | cut -d " " -f 3`

    expect <<EOF
      set timeout 10
      spawn ssh-copy-id $user@$ip
      expect {
        "yes/no" { send "yes\n";exp_continue }
        "password" { send "$passwd\n" }
      }
     expect "password" { send "$passwd\n" }
EOF
  done <  hosts
```

（5）shell 调用 expect 执行多行命令.

```
#!/bin/bash
ip=$1
user=$2
password=$3

expect <<EOF
    set timeout 10
    spawn ssh $user@$ip
    expect {
        "yes/no" { send "yes\n";exp_continue }
        "password" { send "$password\n" }
    }
    expect "]#" { send "useradd hehe\n" }
    expect "]#" { send "touch /tmp/test.txt\n" }
    expect "]#" { send "exit\n" } expect eof
 EOF
 #./ssh5.sh 192.168.1.10 root 123456
```

## 参考资料

- [linux expect 自动交互脚本用法](https://blog.csdn.net/u010820857/article/details/89925274)