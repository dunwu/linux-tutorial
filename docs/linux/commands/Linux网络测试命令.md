---
title: Linux 网络测试命令
date: 2018/02/28
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 网络测试命令

> 关键词：`host`, `nslookup`, `nc`/`netcat`, `dig`, `ping`, `traceroute`, `netstat`

<!-- TOC depthFrom:2 depthTo:2 -->

- [host](#host)
- [nslookup](#nslookup)
- [nc/netcat](#ncnetcat)
- [dig](#dig)
- [ping](#ping)
- [traceroute](#traceroute)
- [netstat](#netstat)

<!-- /TOC -->

## host

> host 命令是常用的分析域名查询工具，可以用来测试域名系统工作是否正常。
>
> 参考：http://man.linuxde.net/host

示例：

```sh
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

## nslookup

> nslookup 命令是常用域名查询工具，就是查 DNS 信息用的命令。
>
> 参考：http://man.linuxde.net/nslookup

示例：

```sh
[root@localhost ~]# nslookup www.jsdig.com
Server:         202.96.104.15
Address:        202.96.104.15#53

Non-authoritative answer:
www.jsdig.com canonical name = host.1.jsdig.com.
Name:   host.1.jsdig.com
Address: 100.42.212.8
```

## nc/netcat

> nc 命令是 netcat 命令的简称，都是用来设置路由器。
>
> 参考：http://man.linuxde.net/nc_netcat

示例：

```sh
# TCP 端口扫描
[root@localhost ~]# nc -v -z -w2 192.168.0.3 1-100
192.168.0.3: inverse host lookup failed: Unknown host
(UNKNOWN) [192.168.0.3] 80 (http) open
(UNKNOWN) [192.168.0.3] 23 (telnet) open
(UNKNOWN) [192.168.0.3] 22 (ssh) open

# UDP 端口扫描
[root@localhost ~]# nc -u -z -w2 192.168.0.1 1-1000  # 扫描192.168.0.3 的端口 范围是 1-1000
```

## dig

> dig 命令是常用的域名查询工具，可以用来测试域名系统工作是否正常。
>
> 参考：http://man.linuxde.net/dig

示例：

```sh
[root@localhost ~]# dig www.jsdig.com

; <<>> DiG 9.3.6-P1-RedHat-9.3.6-20.P1.el5_8.1 <<>> www.jsdig.com
;; global options:  printcmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2115
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 0

;; QUESTION SECTION:
;www.jsdig.com.               IN      A

;; ANSWER SECTION:
www.jsdig.com.        0       IN      CNAME   host.1.jsdig.com.
host.1.jsdig.com.     0       IN      A       100.42.212.8

;; AUTHORITY SECTION:
jsdig.com.            8       IN      NS      f1g1ns2.dnspod.net.
jsdig.com.            8       IN      NS      f1g1ns1.dnspod.net.

;; Query time: 0 msec
;; SERVER: 202.96.104.15#53(202.96.104.15)
;; WHEN: Thu Dec 26 11:14:37 2013
;; MSG SIZE  rcvd: 121
```

## ping

> ping 命令用来测试主机之间网络的连通性。执行 ping 指令会使用 ICMP 传输协议，发出要求回应的信息，若远端主机的网络功能没有问题，就会回应该信息，因而得知该主机运作正常。
>
> 参考：http://man.linuxde.net/ping

示例：

```sh
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

## traceroute

> traceroute 命令用于追踪数据包在网络上的传输时的全部路径，它默认发送的数据包大小是 40 字节。
>
> 参考：http://man.linuxde.net/traceroute

示例：

```sh
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

## netstat

> netstat 命令用来打印 Linux 中网络系统的状态信息，可让你得知整个 Linux 系统的网络情况。
>
> 参考：http://man.linuxde.net/netstat

示例：

```sh
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
