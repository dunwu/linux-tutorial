---
title: Linux 网络应用命令
date: 2018/02/27
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 网络应用命令

> 关键词：`curl`, `wget`, `telnet`, `ip`, `hostname`, `ifconfig`, `route`, `ssh`, `ssh-keygen`, `iptables`

<!-- TOC depthFrom:2 depthTo:2 -->

- [curl](#curl)
- [wget](#wget)
- [telnet](#telnet)
- [ip](#ip)
- [hostname](#hostname)
- [ifconfig](#ifconfig)
- [route](#route)
- [ssh](#ssh)
- [ssh-keygen](#ssh-keygen)
- [iptables](#iptables)

<!-- /TOC -->

## curl

> curl 命令是一个利用 URL 规则在命令行下工作的文件传输工具。
>
> 参考：http://man.linuxde.net/curl

curl 命令支持文件的上传和下载，所以是综合传输工具，但按传统，习惯称 curl 为下载工具。作为一款强力工具，curl 支持包括 HTTP、HTTPS、ftp 等众多协议，还支持 POST、cookies、认证、从指定偏移处下载部分文件、用户代理字符串、限速、文件大小、进度条等特征。做网页处理流程和数据检索自动化，curl 可以祝一臂之力。

示例：

下载文件

```sh
curl http://man.linuxde.net/text.iso --silent
```

下载文件，指定下载路径，并显示进度

```sh
curl http://man.linuxde.net/test.iso -o filename.iso --progress
######################################### 100.0%
```

## wget

> wget 命令用来从指定的 URL 下载文件。
>
> 参考：http://man.linuxde.net/wget

示例：

```sh
# 使用 wget 下载单个文件
wget http://www.linuxde.net/testfile.zip
```

## telnet

> telnet 命令用于登录远程主机，对远程主机进行管理。
>
> 参考：http://man.linuxde.net/telnet

示例：

```sh
telnet 192.168.2.10
Trying 192.168.2.10...
Connected to 192.168.2.10 (192.168.2.10).
Escape character is '^]'.

    localhost (Linux release 2.6.18-274.18.1.el5 #1 SMP Thu Feb 9 12:45:44 EST 2012) (1)

login: root
Password:
Login incorrect
```

## ip

> ip 命令用来显示或操纵 Linux 主机的路由、网络设备、策略路由和隧道，是 Linux 下较新的功能强大的网络配置工具。
>
> 参考：http://man.linuxde.net/ip

示例：

```sh
ip link show                     # 显示网络接口信息
ip link set eth0 upi             # 开启网卡
ip link set eth0 down            # 关闭网卡
ip link set eth0 promisc on      # 开启网卡的混合模式
ip link set eth0 promisc offi    # 关闭网卡的混个模式
ip link set eth0 txqueuelen 1200 # 设置网卡队列长度
ip link set eth0 mtu 1400        # 设置网卡最大传输单元
ip addr show     # 显示网卡IP信息
ip addr add 192.168.0.1/24 dev eth0 # 设置eth0网卡IP地址192.168.0.1
ip addr del 192.168.0.1/24 dev eth0 # 删除eth0网卡IP地址

ip route show # 显示系统路由
ip route add default via 192.168.1.254   # 设置系统默认路由
ip route list                 # 查看路由信息
ip route add 192.168.4.0/24  via  192.168.0.254 dev eth0 # 设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口
ip route add default via  192.168.0.254  dev eth0        # 设置默认网关为192.168.0.254
ip route del 192.168.4.0/24   # 删除192.168.4.0网段的网关
ip route del default          # 删除默认路由
ip route delete 192.168.1.0/24 dev eth0 # 删除路由
```

## hostname

> hostname 命令用于显示和设置系统的主机名称。环境变量 HOSTNAME 也保存了当前的主机名。在使用 hostname 命令设置主机名后，系统并不会永久保存新的主机名，重新启动机器之后还是原来的主机名。如果需要永久修改主机名，需要同时修改 `/etc/hosts` 和 `/etc/sysconfig/network` 的相关内容。
>
> 参考：http://man.linuxde.net/hostname

示例：

```sh
[root@AY1307311912260196fcZ ~]# hostname
AY1307311912260196fcZ
```

## ifconfig

> ifconfig 命令被用于配置和显示 Linux 内核中网络接口的网络参数。用 ifconfig 命令配置的网卡信息，在网卡重启后机器重启后，配置就不存在。要想将上述的配置信息永远的存的电脑里，那就要修改网卡的配置文件了。
>
> 参考：http://man.linuxde.net/ifconfig

示例：

```sh
# 显示网络设备信息（激活状态的）
[root@localhost ~]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:16:3E:00:1E:51
          inet addr:10.160.7.81  Bcast:10.160.15.255  Mask:255.255.240.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:61430830 errors:0 dropped:0 overruns:0 frame:0
          TX packets:88534 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:3607197869 (3.3 GiB)  TX bytes:6115042 (5.8 MiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:56103 errors:0 dropped:0 overruns:0 frame:0
          TX packets:56103 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:5079451 (4.8 MiB)  TX bytes:5079451 (4.8 MiB)
```

## route

> route 命令用来显示并设置 Linux 内核中的网络路由表，route 命令设置的路由主要是静态路由。要实现两个不同的子网之间的通信，需要一台连接两个网络的路由器，或者同时位于两个网络的网关来实现。
>
> 参考：http://man.linuxde.net/route

示例：

```sh
# 显示当前路由
route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
112.124.12.0    *               255.255.252.0   U     0      0        0 eth1
10.160.0.0      *               255.255.240.0   U     0      0        0 eth0
192.168.0.0     10.160.15.247   255.255.0.0     UG    0      0        0 eth0
172.16.0.0      10.160.15.247   255.240.0.0     UG    0      0        0 eth0
10.0.0.0        10.160.15.247   255.0.0.0       UG    0      0        0 eth0
default         112.124.15.247  0.0.0.0         UG    0      0        0 eth1

route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0    # 添加网关/设置网关
route add -net 224.0.0.0 netmask 240.0.0.0 reject      # 屏蔽一条路由
route del -net 224.0.0.0 netmask 240.0.0.0             # 删除路由记录
route add default gw 192.168.120.240                   # 添加默认网关
route del default gw 192.168.120.240                   # 删除默认网关
```

## ssh

> ssh 命令是 openssh 套件中的客户端连接工具，可以给予 ssh 加密协议实现安全的远程登录服务器。
>
> 参考：http://man.linuxde.net/ssh

示例：

```bash
# ssh 用户名@远程服务器地址
ssh user1@172.24.210.101
# 指定端口
ssh -p 2211 root@140.206.185.170
```

引申阅读：[ssh 背后的故事](https://linux.cn/article-8476-1.html)

## ssh-keygen

> ssh-keygen 命令用于为 ssh 生成、管理和转换认证密钥，它支持 RSA 和 DSA 两种认证密钥。
>
> 参考：http://man.linuxde.net/ssh-keygen

为 ssh 生成、管理和转换认证密钥

## iptables

> iptables 命令是 Linux 上常用的防火墙软件，是 netfilter 项目的一部分。可以直接配置，也可以通过许多前端和图形界面配置。
>
> 参考：http://man.linuxde.net/iptables

为 ssh 生成、管理和转换认证密钥

示例：

```sh
# 开放指定的端口
iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT               #允许本地回环接口(即运行本机访问本机)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT    #允许已建立的或相关连的通行
iptables -A OUTPUT -j ACCEPT         #允许所有本机向外的访问
iptables -A INPUT -p tcp --dport 22 -j ACCEPT    #允许访问22端口
iptables -A INPUT -p tcp --dport 80 -j ACCEPT    #允许访问80端口
iptables -A INPUT -p tcp --dport 21 -j ACCEPT    #允许ftp服务的21端口
iptables -A INPUT -p tcp --dport 20 -j ACCEPT    #允许FTP服务的20端口
iptables -A INPUT -j reject       #禁止其他未允许的规则访问
iptables -A FORWARD -j REJECT     #禁止其他未允许的规则访问

# 屏蔽IP
iptables -I INPUT -s 123.45.6.7 -j DROP       #屏蔽单个IP的命令
iptables -I INPUT -s 123.0.0.0/8 -j DROP      #封整个段即从123.0.0.1到123.255.255.254的命令
iptables -I INPUT -s 124.45.0.0/16 -j DROP    #封IP段即从123.45.0.1到123.45.255.254的命令
iptables -I INPUT -s 123.45.6.0/24 -j DROP    #封IP段即从123.45.6.1到123.45.6.254的命令是

# 查看已添加的iptables规则
iptables -L -n -v
Chain INPUT (policy DROP 48106 packets, 2690K bytes)
 pkts bytes target     prot opt in     out     source               destination
 5075  589K ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
 191K   90M ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpt:22
1499K  133M ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpt:80
4364K 6351M ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0           state RELATED,ESTABLISHED
 6256  327K ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 3382K packets, 1819M bytes)
 pkts bytes target     prot opt in     out     source               destination
 5075  589K ACCEPT     all  --  *      lo      0.0.0.0/0            0.0.0.0/0
```
