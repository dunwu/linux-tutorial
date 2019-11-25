# Iptables 应用

> _iptables_ 是一个配置 Linux 内核 [防火墙](https://wiki.archlinux.org/index.php/Firewall) 的命令行工具，是 [netfilter](https://en.wikipedia.org/wiki/Netfilter) 项目的一部分。 可以直接配置，也可以通过许多前端和图形界面配置。
>
> iptables 也经常代指该内核级防火墙。iptables 用于 [ipv4](https://en.wikipedia.org/wiki/Ipv4)，_ip6tables_ 用于 [ipv6](https://en.wikipedia.org/wiki/Ipv6)。
>
> [nftables](https://wiki.archlinux.org/index.php/Nftables) 已经包含在 [Linux kernel 3.13](http://www.phoronix.com/scan.php?page=news_item&px=MTQ5MDU) 中，以后会取代 iptables 成为主要的 Linux 防火墙工具。
>
> 环境：CentOS7

## 1. 简介

**iptables 可以检测、修改、转发、重定向和丢弃 IPv4 数据包**。

过滤 IPv4 数据包的代码已经内置于内核中，并且按照不同的目的被组织成 **表** 的集合。**表** 由一组预先定义的 **链** 组成，**链**包含遍历顺序规则。每一条规则包含一个谓词的潜在匹配和相应的动作（称为 **目标**），如果谓词为真，该动作会被执行。也就是说条件匹配。

## 2. 安装 iptables

（1）禁用 firewalld

CentOS 7 上默认安装了 firewalld 作为防火墙，使用 iptables 建议关闭并禁用 firewalld。

```bash
systemctl stop firewalld
systemctl disable firewalld
```

（2）安装 iptables

```
yum install -y iptables-services
```

（3）服务管理

- 查看服务状态：`systemctl status iptables`
- 启用服务：`systemctl enable iptables`
- 禁用服务：`systemctl disable iptables`
- 启动服务：`systemctl start iptables`
- 重启服务：`systemctl restart iptables`
- 关闭服务: `systemctl stop iptables`

## 3. 命令

基本语法：

```
iptables(选项)(参数)
```

基本选项说明：

| 参数        | 作用                                              |
| ----------- | ------------------------------------------------- |
| -P          | 设置默认策略:iptables -P INPUT (DROP              |
| -F          | 清空规则链                                        |
| -L          | 查看规则链                                        |
| -A          | 在规则链的末尾加入新规则                          |
| -I          | num 在规则链的头部加入新规则                      |
| -D          | num 删除某一条规则                                |
| -s          | 匹配来源地址 IP/MASK，加叹号"!"表示除这个 IP 外。 |
| -d          | 匹配目标地址                                      |
| -i          | 网卡名称 匹配从这块网卡流入的数据                 |
| -o          | 网卡名称 匹配从这块网卡流出的数据                 |
| -p          | 匹配协议,如 tcp,udp,icmp                          |
| --dport num | 匹配目标端口号                                    |
| --sport num | 匹配来源端口号                                    |

顺序：

```
iptables -t 表名 <-A/I/D/R> 规则链名 [规则号] <-i/o 网卡名> -p 协议名 <-s 源IP/源子网> --sport 源端口 <-d 目标IP/目标子网> --dport 目标端口 -j 动作
```

## 4. iptables 示例

### 4.1. 清空当前的所有规则和计数

```shell
iptables -F  # 清空所有的防火墙规则
iptables -X  # 删除用户自定义的空链
iptables -Z  # 清空计数
```

### 4.2. 配置允许 ssh 端口连接

```shell
iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 22 -j ACCEPT
# 22为你的ssh端口， -s 192.168.1.0/24表示允许这个网段的机器来连接，其它网段的ip地址是登陆不了你的机器的。 -j ACCEPT表示接受这样的请求
```

### 4.3. 允许本地回环地址可以正常使用

```shell
iptables -A INPUT -i lo -j ACCEPT
#本地圆环地址就是那个127.0.0.1，是本机上使用的,它进与出都设置为允许
iptables -A OUTPUT -o lo -j ACCEPT
```

### 4.4. 设置默认的规则

```shell
iptables -P INPUT DROP # 配置默认的不让进
iptables -P FORWARD DROP # 默认的不允许转发
iptables -P OUTPUT ACCEPT # 默认的可以出去
```

### 4.5. 配置白名单

```shell
iptables -A INPUT -p all -s 192.168.1.0/24 -j ACCEPT  # 允许机房内网机器可以访问
iptables -A INPUT -p all -s 192.168.140.0/24 -j ACCEPT  # 允许机房内网机器可以访问
iptables -A INPUT -p tcp -s 183.121.3.7 --dport 3380 -j ACCEPT # 允许183.121.3.7访问本机的3380端口
```

### 4.6. 开启相应的服务端口

```shell
iptables -A INPUT -p tcp --dport 80 -j ACCEPT # 开启80端口，因为web对外都是这个端口
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT # 允许被ping
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # 已经建立的连接得让它进来
```

### 4.7. 保存规则到配置文件中

```shell
cp /etc/sysconfig/iptables /etc/sysconfig/iptables.bak # 任何改动之前先备份，请保持这一优秀的习惯
iptables-save > /etc/sysconfig/iptables
cat /etc/sysconfig/iptables
```

### 4.8. 列出已设置的规则

> iptables -L [-t 表名][链名]

- 四个表名 `raw`，`nat`，`filter`，`mangle`
- 五个规则链名 `INPUT`、`OUTPUT`、`FORWARD`、`PREROUTING`、`POSTROUTING`
- filter 表包含`INPUT`、`OUTPUT`、`FORWARD`三个规则链

```shell
iptables -L -t nat                  # 列出 nat 上面的所有规则
#            ^ -t 参数指定，必须是 raw， nat，filter，mangle 中的一个
iptables -L -t nat  --line-numbers  # 规则带编号
iptables -L INPUT

iptables -L -nv  # 查看，这个列表看起来更详细
```

### 4.9. 清除已有规则

```shell
iptables -F INPUT  # 清空指定链 INPUT 上面的所有规则
iptables -X INPUT  # 删除指定的链，这个链必须没有被其它任何规则引用，而且这条上必须没有任何规则。
                   # 如果没有指定链名，则会删除该表中所有非内置的链。
iptables -Z INPUT  # 把指定链，或者表中的所有链上的所有计数器清零。
```

### 4.10. 删除已添加的规则

```shell
# 添加一条规则
iptables -A INPUT -s 192.168.1.5 -j DROP
```

将所有 iptables 以序号标记显示，执行：

```shell
iptables -L -n --line-numbers
```

比如要删除 INPUT 里序号为 8 的规则，执行：

```shell
iptables -D INPUT 8
```

### 4.11. 开放指定的端口

```shell
iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT               #允许本地回环接口(即运行本机访问本机)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT    #允许已建立的或相关连的通行
iptables -A OUTPUT -j ACCEPT         #允许所有本机向外的访问
iptables -A INPUT -p tcp --dport 22 -j ACCEPT    #允许访问22端口
iptables -A INPUT -p tcp --dport 80 -j ACCEPT    #允许访问80端口
iptables -A INPUT -p tcp --dport 21 -j ACCEPT    #允许ftp服务的21端口
iptables -A INPUT -p tcp --dport 20 -j ACCEPT    #允许FTP服务的20端口
iptables -A INPUT -j reject       #禁止其他未允许的规则访问
iptables -A FORWARD -j REJECT     #禁止其他未允许的规则访问
```

### 4.12. 屏蔽 IP

```shell
iptables -A INPUT -p tcp -m tcp -s 192.168.0.8 -j DROP  # 屏蔽恶意主机（比如，192.168.0.8
iptables -I INPUT -s 123.45.6.7 -j DROP       #屏蔽单个IP的命令
iptables -I INPUT -s 123.0.0.0/8 -j DROP      #封整个段即从123.0.0.1到123.255.255.254的命令
iptables -I INPUT -s 124.45.0.0/16 -j DROP    #封IP段即从123.45.0.1到123.45.255.254的命令
iptables -I INPUT -s 123.45.6.0/24 -j DROP    #封IP段即从123.45.6.1到123.45.6.254的命令是
```

### 4.13. 指定数据包出去的网络接口

只对 OUTPUT，FORWARD，POSTROUTING 三个链起作用。

```shell
iptables -A FORWARD -o eth0
```

### 4.14. 查看已添加的规则

```shell
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

### 4.15. 启动网络转发规则

公网`210.14.67.7`让内网`192.168.188.0/24`上网

```shell
iptables -t nat -A POSTROUTING -s 192.168.188.0/24 -j SNAT --to-source 210.14.67.127
```

### 4.16. 端口映射

本机的 2222 端口映射到内网 虚拟机的 22 端口

```shell
iptables -t nat -A PREROUTING -d 210.14.67.127 -p tcp --dport 2222  -j DNAT --to-dest 192.168.188.115:22
```

### 4.17. 字符串匹配

比如，我们要过滤所有 TCP 连接中的字符串`test`，一旦出现它我们就终止这个连接，我们可以这么做：

```shell
iptables -A INPUT -p tcp -m string --algo kmp --string "test" -j REJECT --reject-with tcp-reset
iptables -L

# Chain INPUT (policy ACCEPT)
# target     prot opt source               destination
# REJECT     tcp  --  anywhere             anywhere            STRING match "test" ALGO name kmp TO 65535 reject-with tcp-reset
#
# Chain FORWARD (policy ACCEPT)
# target     prot opt source               destination
#
# Chain OUTPUT (policy ACCEPT)
# target     prot opt source               destination
```

### 4.18. 阻止 Windows 蠕虫的攻击

```shell
iptables -I INPUT -j DROP -p tcp -s 0.0.0.0/0 -m string --algo kmp --string "cmd.exe"
```

### 4.19. 防止 SYN 洪水攻击

```shell
iptables -A INPUT -p tcp --syn -m limit --limit 5/second -j ACCEPT
```

## 5. 参考资料

- https://wiki.archlinux.org/index.php/iptables_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
- https://wangchujiang.com/linux-command/c/iptables.html
