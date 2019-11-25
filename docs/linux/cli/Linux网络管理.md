# Linux 网络管理

> 关键词：`curl`, `wget`, `telnet`, `ip`, `hostname`, `ifconfig`, `route`, `ssh`, `ssh-keygen`, `firewalld`, `iptables`, `host`, `nslookup`, `nc`/`netcat`, `ping`, `traceroute`, `netstat`

## 1. Linux 网络应用要点

- 下载文件 - 使用 [curl](#curl)、[wget](#wget)
- telnet 方式登录远程主机，对远程主机进行管理 - 使用 [telnet](#telnet)
- 查看或操纵 Linux 主机的路由、网络设备、策略路由和隧道 - 使用 [ip](#ip)
- 查看和设置系统的主机名 - 使用 [hostname](#hostname)
- 查看和配置 Linux 内核中网络接口的网络参数 - 使用 [ifconfig](#ifconfig)
- 查看和设置 Linux 内核中的网络路由表 - 使用 [route](#route)
- ssh 方式连接远程主机 - 使用 ssh
- 为 ssh 生成、管理和转换认证密钥 - 使用 [ssh-keygen](#ssh-keygen)
- 查看、设置防火墙（Centos7），使用 [firewalld](#firewalld)
- 查看、设置防火墙（Centos7 以前），使用 [iptables](#iptables)
- 查看域名信息 - 使用 [host](#host), [nslookup](#nslookup)
- 设置路由 - 使用 [nc/netcat](#ncnetcat)
- 测试主机之间网络是否连通 - 使用 [ping](#ping)
- 追踪数据在网络上的传输时的全部路径 - 使用 [traceroute](#traceroute)
- 查看当前工作的端口信息 - 使用 [netstat](#netstat)

## 2. 命令常见用法

### 2.1. curl

> curl 命令是一个利用 URL 规则在命令行下工作的文件传输工具。它支持文件的上传和下载，所以是综合传输工具，但按传统，习惯称 curl 为下载工具。作为一款强力工具，curl 支持包括 HTTP、HTTPS、ftp 等众多协议，还支持 POST、cookies、认证、从指定偏移处下载部分文件、用户代理字符串、限速、文件大小、进度条等特征。做网页处理流程和数据检索自动化，curl 可以祝一臂之力。
>
> 参考：http://man.linuxde.net/curl

示例：

```bash
# 下载文件
$ curl http://man.linuxde.net/text.iso --silent

# 下载文件，指定下载路径，并查看进度
$ curl http://man.linuxde.net/test.iso -o filename.iso --progress
########################################## 100.0%
```

### 2.2. wget

> wget 命令用来从指定的 URL 下载文件。
>
> 参考：http://man.linuxde.net/wget

示例：

```bash
# 使用 wget 下载单个文件
$ wget http://www.linuxde.net/testfile.zip
```

### 2.3. telnet

> telnet 命令用于登录远程主机，对远程主机进行管理。
>
> 参考：http://man.linuxde.net/telnet

示例：

```bash
telnet 192.168.2.10
Trying 192.168.2.10...
Connected to 192.168.2.10 (192.168.2.10).
Escape character is '^]'.

    localhost (Linux release 2.6.18-274.18.1.el5 #1 SMP Thu Feb 9 12:45:44 EST 2012) (1)

login: root
Password:
Login incorrect
```

### 2.4. ip

> ip 命令用来查看或操纵 Linux 主机的路由、网络设备、策略路由和隧道，是 Linux 下较新的功能强大的网络配置工具。
>
> 参考：http://man.linuxde.net/ip

示例：

```bash
$ ip link show                     # 查看网络接口信息
$ ip link set eth0 upi             # 开启网卡
$ ip link set eth0 down            # 关闭网卡
$ ip link set eth0 promisc on      # 开启网卡的混合模式
$ ip link set eth0 promisc offi    # 关闭网卡的混个模式
$ ip link set eth0 txqueuelen 1200 # 设置网卡队列长度
$ ip link set eth0 mtu 1400        # 设置网卡最大传输单元
$ ip addr show     # 查看网卡IP信息
$ ip addr add 192.168.0.1/24 dev eth0 # 设置eth0网卡IP地址192.168.0.1
$ ip addr del 192.168.0.1/24 dev eth0 # 删除eth0网卡IP地址

$ ip route show # 查看系统路由
$ ip route add default via 192.168.1.254   # 设置系统默认路由
$ ip route list                 # 查看路由信息
$ ip route add 192.168.4.0/24  via  192.168.0.254 dev eth0 # 设置192.168.4.0网段的网关为192.168.0.254,数据走eth0接口
$ ip route add default via  192.168.0.254  dev eth0        # 设置默认网关为192.168.0.254
$ ip route del 192.168.4.0/24   # 删除192.168.4.0网段的网关
$ ip route del default          # 删除默认路由
$ ip route delete 192.168.1.0/24 dev eth0 # 删除路由
```

### 2.5. hostname

> hostname 命令用于查看和设置系统的主机名称。环境变量 HOSTNAME 也保存了当前的主机名。在使用 hostname 命令设置主机名后，系统并不会永久保存新的主机名，重新启动机器之后还是原来的主机名。如果需要永久修改主机名，需要同时修改 `/etc/hosts` 和 `/etc/sysconfig/network` 的相关内容。
>
> 参考：http://man.linuxde.net/hostname

示例：

```bash
$ hostname
AY1307311912260196fcZ
```

### 2.6. ifconfig

> ifconfig 命令被用于查看和配置 Linux 内核中网络接口的网络参数。用 ifconfig 命令配置的网卡信息，在网卡重启后机器重启后，配置就不存在。要想将上述的配置信息永远的存的电脑里，那就要修改网卡的配置文件了。
>
> 参考：http://man.linuxde.net/ifconfig

示例：

```bash
# 查看网络设备信息（激活状态的）
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

### 2.7. route

> route 命令用来查看和设置 Linux 内核中的网络路由表，route 命令设置的路由主要是静态路由。要实现两个不同的子网之间的通信，需要一台连接两个网络的路由器，或者同时位于两个网络的网关来实现。
>
> 参考：http://man.linuxde.net/route

示例：

```bash
# 查看当前路由
route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
112.124.12.0    *               255.255.252.0   U     0      0        0 eth1
10.160.0.0      *               255.255.240.0   U     0      0        0 eth0
192.168.0.0     10.160.15.247   255.255.0.0     UG    0      0        0 eth0
172.16.0.0      10.160.15.247   255.240.0.0     UG    0      0        0 eth0
10.0.0.0        10.160.15.247   255.0.0.0       UG    0      0        0 eth0
default         112.124.15.247  0.0.0.0         UG    0      0        0 eth1

route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0    # 添加网关/设置网关
route add -net 224.0.0.0 netmask 240.0.0.0 reject      # 屏蔽一条路由
route del -net 224.0.0.0 netmask 240.0.0.0             # 删除路由记录
route add default gw 192.168.120.240                   # 添加默认网关
route del default gw 192.168.120.240                   # 删除默认网关
```

### 2.8. ssh

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

### 2.9. ssh-keygen

> ssh-keygen 命令用于为 ssh 生成、管理和转换认证密钥，它支持 RSA 和 DSA 两种认证密钥。
>
> 参考：http://man.linuxde.net/ssh-keygen

### 2.10. firewalld

> firewalld 命令是 Linux 上的防火墙软件（Centos7 默认防火墙）。
>
> 参考：https://www.cnblogs.com/moxiaoan/p/5683743.html

#### 2.10.1. firewalld 的基本使用

- 启动 - systemctl start firewalld
- 关闭 - systemctl stop firewalld
- 查看状态 - systemctl status firewalld
- 开机禁用 - systemctl disable firewalld
- 开机启用 - systemctl enable firewalld

#### 2.10.2. 使用 systemctl 管理 firewalld 服务

systemctl 是 CentOS7 的服务管理工具中主要的工具，它融合之前 service 和 chkconfig 的功能于一体。

- 启动一个服务 - systemctl start firewalld.service
- 关闭一个服务 - systemctl stop firewalld.service
- 重启一个服务 - systemctl restart firewalld.service
- 显示一个服务的状态 - systemctl status firewalld.service
- 在开机时启用一个服务 - systemctl enable firewalld.service
- 在开机时禁用一个服务 - systemctl disable firewalld.service
- 查看服务是否开机启动 - systemctl is-enabled firewalld.service
- 查看已启动的服务列表 - systemctl list-unit-files|grep enabled
- 查看启动失败的服务列表 - systemctl --failed

#### 2.10.3. 配置 firewalld-cmd

- 查看版本 - firewall-cmd --version
- 查看帮助 - firewall-cmd --help
- 显示状态 - firewall-cmd --state
- 查看所有打开的端口 - firewall-cmd --zone=public --list-ports
- 更新防火墙规则 - firewall-cmd --reload
- 查看区域信息: firewall-cmd --get-active-zones
- 查看指定接口所属区域 - firewall-cmd --get-zone-of-interface=eth0
- 拒绝所有包：firewall-cmd --panic-on
- 取消拒绝状态 - firewall-cmd --panic-off
- 查看是否拒绝 - firewall-cmd --query-panic

#### 2.10.4. 在防火墙中开放一个端口

- 添加（--permanent 永久生效，没有此参数重启后失效） - firewall-cmd --zone=public --add-port=80/tcp --permanent
- 重新载入 - firewall-cmd --reload
- 查看 - firewall-cmd --zone= public --query-port=80/tcp
- 删除 - firewall-cmd --zone= public --remove-port=80/tcp --permanent

### 2.11. iptables

> iptables 命令是 Linux 上常用的防火墙软件，是 netfilter 项目的一部分。可以直接配置，也可以通过许多前端和图形界面配置。
>
> 参考：http://man.linuxde.net/iptables

示例：

```bash
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

### 2.12. host

> host 命令是常用的分析域名查询工具，可以用来测试域名系统工作是否正常。
>
> 参考：http://man.linuxde.net/host

示例：

```bash
[root@localhost ~]# host www.jsdig.com
www.jsdig.com is an alias for host.1.jsdig.com.
host.1.jsdig.com has address 100.42.212.8

[root@localhost ~]# host -a www.jsdig.com
Trying "www.jsdig.com"
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 34671
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;www.jsdig.com.               IN      ANY

;; ANSWER SECTION:
www.jsdig.com.        463     IN      CNAME   host.1.jsdig.com.

Received 54 bytes from 202.96.104.15#53 in 0 ms
```

### 2.13. nslookup

> nslookup 命令是常用域名查询工具，就是查 DNS 信息用的命令。
>
> 参考：http://man.linuxde.net/nslookup

示例：

```bash
[root@localhost ~]# nslookup www.jsdig.com
Server:         202.96.104.15
Address:        202.96.104.15#53

Non-authoritative answer:
www.jsdig.com canonical name = host.1.jsdig.com.
Name:   host.1.jsdig.com
Address: 100.42.212.8
```

### 2.14. nc/netcat

> nc 命令是 netcat 命令的简称，都是用来设置路由器。
>
> 参考：http://man.linuxde.net/nc_netcat

示例：

```bash
# TCP 端口扫描
[root@localhost ~]# nc -v -z -w2 192.168.0.3 1-100
192.168.0.3: inverse host lookup failed: Unknown host
(UNKNOWN) [192.168.0.3] 80 (http) open
(UNKNOWN) [192.168.0.3] 23 (telnet) open
(UNKNOWN) [192.168.0.3] 22 (ssh) open

# UDP 端口扫描
[root@localhost ~]# nc -u -z -w2 192.168.0.1 1-1000  # 扫描192.168.0.3 的端口 范围是 1-1000
```

### 2.15. ping

> ping 命令用来测试主机之间网络的连通性。执行 ping 指令会使用 ICMP 传输协议，发出要求回应的信息，若远端主机的网络功能没有问题，就会回应该信息，因而得知该主机运作正常。
>
> 参考：http://man.linuxde.net/ping

示例：

```bash
[root@AY1307311912260196fcZ ~]# ping www.jsdig.com
PING host.1.jsdig.com (100.42.212.8) 56(84) bytes of data.
64 bytes from 100-42-212-8.static.webnx.com (100.42.212.8): icmp_seq=1 ttl=50 time=177 ms
64 bytes from 100-42-212-8.static.webnx.com (100.42.212.8): icmp_seq=2 ttl=50 time=178 ms
64 bytes from 100-42-212-8.static.webnx.com (100.42.212.8): icmp_seq=3 ttl=50 time=174 ms
64 bytes from 100-42-212-8.static.webnx.com (100.42.212.8): icmp_seq=4 ttl=50 time=177 ms
...按Ctrl+C结束

--- host.1.jsdig.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 2998ms
rtt min/avg/max/mdev = 174.068/176.916/178.182/1.683 ms
```

### 2.16. traceroute

> traceroute 命令用于追踪数据包在网络上的传输时的全部路径，它默认发送的数据包大小是 40 字节。
>
> 参考：http://man.linuxde.net/traceroute

示例：

```bash
traceroute www.58.com
traceroute to www.58.com (211.151.111.30), 30 hops max, 40 byte packets
 1  unknown (192.168.2.1)  3.453 ms  3.801 ms  3.937 ms
 2  221.6.45.33 (221.6.45.33)  7.768 ms  7.816 ms  7.840 ms
 3  221.6.0.233 (221.6.0.233)  13.784 ms  13.827 ms 221.6.9.81 (221.6.9.81)  9.758 ms
 4  221.6.2.169 (221.6.2.169)  11.777 ms 122.96.66.13 (122.96.66.13)  34.952 ms 221.6.2.53 (221.6.2.53)  41.372 ms
 5  219.158.96.149 (219.158.96.149)  39.167 ms  39.210 ms  39.238 ms
 6  123.126.0.194 (123.126.0.194)  37.270 ms 123.126.0.66 (123.126.0.66)  37.163 ms  37.441 ms
 7  124.65.57.26 (124.65.57.26)  42.787 ms  42.799 ms  42.809 ms
 8  61.148.146.210 (61.148.146.210)  30.176 ms 61.148.154.98 (61.148.154.98)  32.613 ms  32.675 ms
 9  202.106.42.102 (202.106.42.102)  44.563 ms  44.600 ms  44.627 ms
10  210.77.139.150 (210.77.139.150)  53.302 ms  53.233 ms  53.032 ms
11  211.151.104.6 (211.151.104.6)  39.585 ms  39.502 ms  39.598 ms
12  211.151.111.30 (211.151.111.30)  35.161 ms  35.938 ms  36.005 ms
```

### 2.17. netstat

> netstat 命令用来打印 Linux 中网络系统的状态信息，可让你得知整个 Linux 系统的网络情况。
>
> 参考：http://man.linuxde.net/netstat

示例：

```bash
# 列出所有端口 (包括监听和未监听的)
netstat -a     #列出所有端口
netstat -at    #列出所有tcp端口
netstat -au    #列出所有udp端口

# 列出所有处于监听状态的 Sockets
netstat -l        #只显示监听端口
netstat -lt       #只列出所有监听 tcp 端口
netstat -lu       #只列出所有监听 udp 端口
netstat -lx       #只列出所有监听 UNIX 端口

# 显示每个协议的统计信息
netstat -s   显示所有端口的统计信息
netstat -st   显示TCP端口的统计信息
netstat -su   显示UDP端口的统计信息
```
