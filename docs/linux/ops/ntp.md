# 时间服务器 - NTP

## 一、NTP 简介

网络时间协议（英语：Network Time Protocol，缩写：NTP）是在数据网络潜伏时间可变的计算机系统之间通过分组交换进行时钟同步的一个网络协议，位于 OSI 模型的应用层。自 1985 年以来，NTP 是目前仍在使用的最古老的互联网协议之一。NTP 由特拉华大学的 David L. Mills（英语：David L. Mills）设计。

**NTP 意图将所有参与计算机的协调世界时（UTC）时间同步到几毫秒的误差内**。

NTP 要点：

- 地球共有 24 个时区，而以格林威治时间 (GMT) 为标准时间；
- 中国本地时间为 GMT +8 小时；
- 最准确的时间为使用原子钟 (Atomic clock) 所计算的，例如 UTC (Coordinated Universal Time) 就是一例；
- Linux 系统本来就有两种时间，一种是 Linux 以 `1970/01/01` 开始计数的系统时间，一种则是 BIOS 记载的硬件时间；
- Linux 可以透过网络校时，最常见的网络校时为使用 NTP 服务器，这个服务启动在 `udp port 123`；
- 时区档案主要放置于 `/usr/share/zoneinfo/` 目录下，而本地时区则参考 `/etc/localtime`；
- NTP 服务器为一种阶层式的服务，所以 NTP 服务器本来就会与上层时间服务器作时间的同步化， 因此 `nptd` 与 `ntpdate` 两个指令不可同时使用；
- NTP 服务器的联机状态可以使用 `ntpstat` 及 `ntpq -p` 来查询；
- NTP 提供的客户端软件为 `ntpdate` 这个指令；
- 在 Linux 下想要手动处理时间时，需以 `date` 设定时间后，以 `hwclock -w` 来写入 BIOS 所记录的时间。
- NTP 服务器之间的时间误差不可超过 1000 秒，否则 NTP 服务会自动关闭。

> 更多 NTP 详情可以参考：[鸟哥的 Linux 私房菜-- NTP 时间服务器](http://cn.linux.vbird.org/linux_server/0440ntp.php)

## 二、ntpd 服务

> 环境：CentOS

### yum 安装

CentOS 安装 NTP 很简单，执行以下命令即可：

```shell
yum -y install ntp
```

### ntpd 配置

ntp 的配置文件路径为： `/etc/ntp.conf` ，参考配置：

```shell
# 1. 先处理权限方面的问题，包括放行上层服务器以及开放区网用户来源：
# restrict default kod nomodify notrap nopeer noquery     # 拒绝 IPv4 的用户
# restrict -6 default kod nomodify notrap nopeer noquery  # 拒绝 IPv6 的用户
restrict default nomodify notrap nopeer noquery
#restrict 192.168.100.0 mask 255.255.255.0 nomodify # 放行同局域网来源（根据网关和子网掩码决定）
restrict 127.0.0.1   # 默认值，放行本机 IPv4 来源
restrict ::1         # 默认值，放行本机 IPv6 来源

# 2. 设定 NTP 主机来源
# 注释掉默认 NTP 来源
# server 0.centos.pool.ntp.org iburst
# server 1.centos.pool.ntp.org iburst
# server 2.centos.pool.ntp.org iburst
# server 3.centos.pool.ntp.org iburst
# 设置国内 NTP 来源
server cn.pool.ntp.org prefer # 以这个主机为优先
server ntp1.aliyun.com
server ntp.sjtu.edu.cn

# 3. 预设时间差异分析档案与暂不用到的 keys 等，不需要更改它：
driftfile /var/lib/ntp/drift
keys /etc/ntp/keys
includefile /etc/ntp/crypto/pw
```

> 注意：如果更改配置，必须重启 NTP 服务（`systemctl restart ntpd`）才能生效。

### 放开防火墙限制

NTP 服务的端口是 `123`，使用的是 udp 协议，所以 NTP 服务器的防火墙必须对外开放 udp 123 这个端口。

如果防火墙使用 **`iptables`**，执行以下命令：

```shell
iptables -A INPUT -p UDP -i eth0 -s 192.168.0.0/24 --dport 123 -j ACCEPT
```

如果防火墙使用 **`firewalld`**，执行以下命令：

```shell
firewall-cmd --zone=public --add-port=123/udp --permanent
```

### ntpd 服务命令

```shell
systemctl enable ntpd.service  # 开启服务（开机自动启动服务）
systemctl disable ntpd.service # 关闭服务（开机不会自动启动服务）
systemctl start ntpd.service   # 启动服务
systemctl stop ntpd.service    # 停止服务
systemctl restart ntpd.service # 重启服务
systemctl reload ntpd.service  # 重新载入配置
systemctl status ntpd.service  # 查看服务状态
```

### 查看 ntp 服务状态

#### 验证 NTP 服务正常工作

执行 `ntpstat` 可以查看 ntp 服务器有无和上层 ntp 连通，，如果成功，可以看到类似以下的内容：

```shell
$ ntpstat
synchronised to NTP server (5.79.108.34) at stratum 3
   time correct to within 1129 ms
   polling server every 64 s
```

#### 查看 ntp 服务器与上层 ntp 的状态

```shell
ntpq -p
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
*ntp1.ams1.nl.le 130.133.1.10     2 u   36   64  367  230.801    5.271   2.791
 120.25.115.20   10.137.53.7      2 u   33   64  377   25.930   15.908   3.168
 time.cloudflare 10.21.8.251      3 u   31   64  367  251.109   16.976   3.264
```

## 三、ntpdate 命令

> 注意：NTP 服务器为一种阶层式的服务，所以 NTP 服务器本来就会与上层时间服务器作时间的同步化， 因此 `nptd` 与 `ntpdate` 两个指令不可同时使用。

### 手动执行时间同步

`ntpdate` 命令是 NTP 的客户端软件，它可以用于请求时间同步。

语法：

```shell
/usr/sbin/ntpdate <ntp_server>
```

`ntp_server` 可以从 [国内 NTP 服务器](#国内 NTP 服务器) 中选择。

示例：

```shell
$ ntpdate cn.pool.ntp.org
11 Feb 10:47:12 ntpdate[30423]: step time server 84.16.73.33 offset -49.894774 sec
```

### 自动定时同步时间

如果需要自动定时同步时间，可以利用 [Crontab](#crontab) 工具。本质就是用 crontab 定时执行一次手动时间同步命令 ntp。

示例：执行如下命令，就可以在每天凌晨 3 点同步系统时间：

```shell
echo "0 3 * * * /usr/sbin/ntpdate cn.pool.ntp.org" >> /etc/crontab # 修改 crond 服务配置
systemctl restart crond # 重启 crond 服务以生效
```

## 四、国内 NTP 服务器

以下 NTP 服务器搜集自网络：

```shell
cn.pool.ntp.org  # 最常用的国内NTP服务器，参考：https://www.ntppool.org/zh/use.html
cn.ntp.org.cn    # 中国
edu.ntp.org.cn   # 中国教育网
ntp1.aliyun.com  # 阿里云
ntp2.aliyun.com  # 阿里云
ntp.sjtu.edu.cn  # 上海交通大学
s1a.time.edu.cn  # 北京邮电大学
s1b.time.edu.cn  # 清华大学
s1c.time.edu.cn  # 北京大学
s1d.time.edu.cn  # 东南大学
s1e.time.edu.cn  # 清华大学
s2a.time.edu.cn  # 清华大学
s2b.time.edu.cn  # 清华大学
s2c.time.edu.cn  # 北京邮电大学
s2d.time.edu.cn  # 西南地区网络中心
s2e.time.edu.cn  # 西北地区网络中心
s2f.time.edu.cn  # 东北地区网络中心
s2g.time.edu.cn  # 华东南地区网络中心
s2h.time.edu.cn  # 四川大学网络管理中心
s2j.time.edu.cn  # 大连理工大学网络中心
s2k.time.edu.cn  # CERNET桂林主节点
```

## 参考资料

- [鸟哥的 Linux 私房菜-- NTP 时间服务器](http://cn.linux.vbird.org/linux_server/0440ntp.php)
- [Linux 配置 ntp 时间服务器](https://www.cnblogs.com/quchunhui/p/7658853.html)
