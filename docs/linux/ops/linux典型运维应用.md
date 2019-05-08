---
title: Linux 典型运维应用
date: 2019-03-06
---

# Linux 典型运维应用

> :bulb: 如果没有特殊说明，本文的案例都是针对 Centos 发行版本。

## 网络操作

### 无法访问外网域名

（1）在 hosts 中添加本机实际 IP 和本机实际域名的映射

```bash
echo "192.168.0.1 hostname" >> /etc/hosts
```

如果不知道本机域名，使用 `hostname` 命令查一下；如果不知道本机实际 IP，使用 `ifconfig` 查一下。

（2）配置信赖的 DNS 服务器

执行 `vi /etc/resolv.conf` ，添加以下内容：

```bash
nameserver 114.114.114.114
nameserver 8.8.8.8
```

> 114.114.114.114 是国内老牌 DNS
>
> 8.8.8.8 是 Google DNS
>
> :point_right: 参考：[公共 DNS 哪家强](https://www.zhihu.com/question/32229915)

（3）测试一下能否 ping 通 www.baidu.com

### 开启、关闭防火墙

firewalld 的基本使用

```bash
启动：systemctl start firewalld
关闭：systemctl stop firewalld
查看状态：systemctl status firewalld
开机禁用：systemctl disable firewalld
开机启用：systemctl enable firewalld
```

systemctl 是 CentOS7 的服务管理工具中主要的工具，它融合之前 service 和 chkconfig 的功能于一体。

```
启动一个服务：systemctl start firewalld.service
关闭一个服务：systemctl stop firewalld.service
重启一个服务：systemctl restart firewalld.service
显示一个服务的状态：systemctl status firewalld.service
在开机时启用一个服务：systemctl enable firewalld.service
在开机时禁用一个服务：systemctl disable firewalld.service
查看服务是否开机启动：systemctl is-enabled firewalld.service
查看已启动的服务列表：systemctl list-unit-files|grep enabled
查看启动失败的服务列表：systemctl --failed
```

配置 firewalld-cmd

```
查看版本：firewall-cmd --version
查看帮助：firewall-cmd --help
显示状态：firewall-cmd --state
查看所有打开的端口：firewall-cmd --zone=public --list-ports
更新防火墙规则：firewall-cmd --reload
查看区域信息:  firewall-cmd --get-active-zones
查看指定接口所属区域：firewall-cmd --get-zone-of-interface=eth0
拒绝所有包：firewall-cmd --panic-on
取消拒绝状态：firewall-cmd --panic-off
查看是否拒绝：firewall-cmd --query-panic
```

开启防火墙端口

```
添加：firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）
重新载入：firewall-cmd --reload
查看：firewall-cmd --zone= public --query-port=80/tcp
删除：firewall-cmd --zone= public --remove-port=80/tcp --permanent
```

> :point_right: 参考：[CentOS7 使用 firewalld 打开关闭防火墙与端口](https://www.cnblogs.com/moxiaoan/p/5683743.html)

## 系统维护

### 使用 NTP 进行时间同步

（1）先安装时钟同步工具 ntp

```
yum -y install ntp
```

ntp 的配置文件路径为： `/etc/ntp.conf`

（2）启动 NTP 服务

```bash
systemctl start ntpd.service
```

（3）放开防火墙 123 端口

NTP 服务的端口是 123,使用的是 udp 协议，所以 NTP 服务器的防火墙必须对外开放 udp 123 这个端口。

```
/sbin/iptables -A INPUT -p UDP -i eth0 -s 192.168.0.0/24 --dport 123 -j ACCEPT
```

（4）执行时间同步

```
/usr/sbin/ntpdate ntp.sjtu.edu.cn
```

ntp.sjtu.edu.cn 是上海交通大学 ntp 服务器。

（5）自动定时同步时间

执行如下命令，就可以在每天凌晨 3 点同步系统时间：

```
echo "* 3 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn" >> /etc/crontab
systemctl restart crond.service
```

> :point_right: 参考：https://www.cnblogs.com/quchunhui/p/7658853.html

## 自动化脚本

### Linux 开机自启动脚本

（1）在 `/etc/rc.local` 文件中添加命令

如果不想将脚本粘来粘去，或创建链接，可以在 `/etc/rc.local` 文件中添加启动命令

1. 先修改好脚本，使其所有模块都能在任意目录启动时正常执行;
2. 再在 `/etc/rc.local` 的末尾添加一行以绝对路径启动脚本的行;

例：

执行 `vim /etc/rc.local` 命令，输入以下内容：

```bash
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local
/opt/pjt_test/test.pl
```

（2）在 `/etc/rc.d/init.d` 目录下添加自启动脚本

Linux 在 `/etc/rc.d/init.d` 下有很多的文件，每个文件都是可以看到内容的，其实都是一些 shell 脚本或者可执行二进制文件。

Linux 开机的时候，会加载运行 `/etc/rc.d/init.d` 目录下的程序，因此我们可以把想要自动运行的脚本放到这个目录下即可。系统服务的启动就是通过这种方式实现的。

（3）运行级别设置

简单的说，运行级就是操作系统当前正在运行的功能级别。

```
不同的运行级定义如下:
# 0 - 停机（千万不能把initdefault 设置为0 ）
# 1 - 单用户模式       　　进入方法#init s = init 1
# 2 - 多用户，没有 NFS
# 3 - 完全多用户模式(标准的运行级)
# 4 - 没有用到
# 5 - X11 多用户图形模式（xwindow)
# 6 - 重新启动 （千万不要把initdefault 设置为6 ）
```

这些级别在 `/etc/inittab` 文件里指定，这个文件是 init 程序寻找的主要文件，最先运行的服务是放在/etc/rc.d 目录下的文件。

在 `/etc` 目录下面有这么几个目录值得注意：rcS.d rc0.d rc1.d ... rc6.d (0，1... 6 代表启动级别 0 代表停止，1 代表单用户模式，2-5 代表多用户模式，6 代表重启) 它们的作用就相当于 redhat 下的 rc.d ，你可以把脚本放到 rcS.d，然后修改文件名，给它一个启动序号，如: S88mysql

不过，最好的办法是放到相应的启动级别下面。具体作法:

（1）先把脚本 mysql 放到 /etc/init.d 目录下

（2）查看当前系统的启动级别

```bash
$ runlevel
N 3
```

（3）设定启动级别

```
#  98 为启动序号
#  2 是系统的运行级别，可自己调整，注意不要忘了结尾的句点
$ update-rc.d mysql start 98 2 .
```

现在我们到 /etc/rc2.d 下，就多了一个 S98mysql 这样的符号链接。

（4）重启系统，验证设置是否有效。

（5）移除符号链接

当你需要移除这个符号连接时，方法有三种：

1. 直接到 `/etc/rc2.d` 下删掉相应的链接，当然不是最好的方法；

2. 推荐做法：`update-rc.d -f s10 remove`
3. 如果 update-rc.d 命令你不熟悉，还可以试试看 rcconf 这个命令，也很方便。

> :point_right: 参考：
>
> - https://blog.csdn.net/linuxshine/article/details/50717272
> - https://www.cnblogs.com/ssooking/p/6094740.html

### 定时执行脚本

（1）安装 crontab

（2）开启 crontab 服务

开机自动启动 crond 服务：`chkconfig crond on`

或者，按以下命令手动启动：

```bash
# 启动服务
systemctl start crond.service
# 停止服务
systemctl stop crond.service
# 重启服务
systemctl restart crond.service
# 重新载入配置
systemctl reload crond.service
# 查看状态
systemctl status crond.service
```

（3）设置需要执行的脚本

有两种方法：

- 在命令行输入：`crontab -e` 然后添加相应的任务，存盘退出。
- 直接编辑 `/etc/crontab` 文件，即 `vi /etc/crontab`，添加相应的任务。

示例：

```bash
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed

# 每天早上3点时钟同步
* 3 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn

# 每两个小时以root身份执行 /home/hello.sh 脚本
0 */2 * * * root /home/hello.sh
```

> :point_right: 参考：[linux 定时执行脚本](https://blog.csdn.net/z_yong_cool/article/details/79288397)

## 配置

### 设置 Linux 启动模式

1. 停机(记得不要把 initdefault 配置为 0，因为这样会使 Linux 不能启动)
2. 单用户模式，就像 Win9X 下的安全模式
3. 多用户，但是没有 NFS
4. 完全多用户模式，准则的运行级
5. 通常不用，在一些特殊情况下可以用它来做一些事情
6. X11，即进到 X-Window 系统
7. 重新启动 (记得不要把 initdefault 配置为 6，因为这样会使 Linux 不断地重新启动)

设置方法：

```bash
$ sed -i 's/id:5:initdefault:/id:3:initdefault:/' /etc/inittab
```

## 参考资料

- [CentOS7 使用 firewalld 打开关闭防火墙与端口](https://www.cnblogs.com/moxiaoan/p/5683743.html)

- [linux 定时执行脚本](https://blog.csdn.net/z_yong_cool/article/details/79288397)
