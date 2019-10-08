# Redis 运维

> **Redis** 是一个高性能的 key-value 数据库。
>
> SET 操作每秒钟 110000 次；GET 操作每秒钟 81000 次。

<!-- TOC depthfrom:2 depthto:3 -->

- [安装](#安装)
  - [Window 下安装](#window-下安装)
  - [Linux 下安装](#linux-下安装)
  - [Ubuntu 下安装](#ubuntu-下安装)
  - [开机启动](#开机启动)
  - [开放防火墙端口](#开放防火墙端口)
- [Redis 使用和配置](#redis-使用和配置)
  - [启动](#启动)
  - [常见配置](#常见配置)
  - [设为守护进程](#设为守护进程)
    - [远程访问](#远程访问)
    - [设置密码](#设置密码)
- [Redis 集群使用和配置](#redis-集群使用和配置)
  - [集群规划](#集群规划)
  - [部署](#部署)
- [Redis 命令](#redis-命令)
- [压力测试](#压力测试)
- [客户端](#客户端)
- [脚本](#脚本)
- [参考资料](#参考资料)

<!-- /TOC -->

## 安装

### Window 下安装

**下载地址：**<https://github.com/MSOpenTech/redis/releases>。

Redis 支持 32 位和 64 位。这个需要根据你系统平台的实际情况选择，这里我们下载 **Redis-x64-xxx.zip**压缩包到 C 盘，解压后，将文件夹重新命名为 **redis**。

打开一个 **cmd** 窗口 使用 cd 命令切换目录到 **C:\redis** 运行 **redis-server.exe redis.windows.conf** 。

如果想方便的话，可以把 redis 的路径加到系统的环境变量里，这样就省得再输路径了，后面的那个 redis.windows.conf 可以省略，如果省略，会启用默认的。

这时候另启一个 cmd 窗口，原来的不要关闭，不然就无法访问服务端了。

切换到 redis 目录下运行 **redis-cli.exe -h 127.0.0.1 -p 6379** 。

### Linux 下安装

**下载地址：** http://redis.io/download，下载最新文档版本。

下载、解压、编译 Redis

```
$ wget http://download.redis.io/releases/redis-5.0.4.tar.gz
$ tar xzf redis-5.0.4.tar.gz
$ cd redis-5.0.4
$ make
```

为了编译 Redis 源码，你需要 gcc-c++和 tcl。如果你的系统是 CentOS，可以直接执行命令：`yum install -y gcc-c++ tcl` 来安装。

进入到解压后的 `src` 目录，通过如下命令启动 Redis:

```
$ src/redis-server
```

您可以使用内置的客户端与 Redis 进行交互:

```
$ src/redis-cli
redis> set foo bar
OK
redis> get foo
"bar"
```

### Ubuntu 下安装

在 Ubuntu 系统安装 Redi 可以使用以下命令:

```
$sudo apt-get update
$sudo apt-get install redis-server
```

### 开机启动

- 开机启动配置：`echo "/usr/local/bin/redis-server /etc/redis.conf" >> /etc/rc.local`

### 开放防火墙端口

- 添加规则：`iptables -I INPUT -p tcp -m tcp --dport 6379 -j ACCEPT`
- 保存规则：`service iptables save`
- 重启 iptables：`service iptables restart`

## Redis 使用和配置

### 启动

**启动 redis 服务**

```
cd /opt/redis/redis-5.0.4/src
./redis-server
```

**启动 redis 客户端**

```
cd /opt/redis/redis-5.0.4/src
./redis-cli
```

**查看 redis 是否启动**

```
$ redis-cli
```

以上命令将打开以下终端：

```
redis 127.0.0.1:6379>
```

127.0.0.1 是本机 IP ，6379 是 redis 服务端口。现在我们输入 PING 命令。

```
redis 127.0.0.1:6379> ping
PONG
```

以上说明我们已经成功启动了 redis。

### 常见配置

> Redis 默认的配置文件是根目录下的 `redis.conf` 文件。
>
> 如果需要指定特定文件作为配置文件，需要使用命令： `./redis-server -c xxx.conf`
>
> 每次修改配置后，需要重启才能生效。
>
> Redis 官方默认配置：
>
> - 自描述文档 [redis.conf for Redis 2.8](https://raw.githubusercontent.com/antirez/redis/2.8/redis.conf)
> - 自描述文档 [redis.conf for Redis 2.6](https://raw.githubusercontent.com/antirez/redis/2.6/redis.conf).
> - 自描述文档 [redis.conf for Redis 2.4](https://raw.githubusercontent.com/antirez/redis/2.4/redis.conf).
>
> 自 Redis2.6 起就可以直接通过命令行传递 Redis 配置参数。这种方法可以用于测试。自 Redis2.6 起就可以直接通过命令行传递 Redis 配置参数。这种方法可以用于测试。

### 设为守护进程

Redis 默认以非守护进程方式启动，而通常我们会将 Redis 设为守护进程启动方式，配置：`daemonize yes`

#### 远程访问

Redis 默认绑定 127.0.0.1，这样就只能本机才能访问，若要 Redis 允许远程访问，需要配置：`bind 0.0.0.0`

#### 设置密码

Redis 默认访问不需要密码，如果需要设置密码，需要如下配置：

- `protected-mode yes`
- `requirepass <密码>`

## Redis 集群使用和配置

Redis 3.0 后支持集群模式。

### 集群规划

`Redis` 集群一般由 **多个节点** 组成，节点数量至少为 `6` 个，才能保证组成 **完整高可用** 的集群。

<div align="center"><img src="http://dunwu.test.upcdn.net/cs/database/redis/redis-cluster-architecture.png!zp"/></div>

理想情况当然是所有节点各自在不同的机器上，首先于资源，本人在部署 Redis 集群时，只得到 3 台服务器。所以，我的基本规划是满足两个条件：

- 每台服务器上部署一个主节点、一个从节点。
- 每个主节点所对应的从节点，必须在另外一台服务器上。

<div align="center"><img src="http://dunwu.test.upcdn.net/cs/database/redis/redis-cluster-example.png!zp"/></div>

> 为集群内 **所有节点** 统一目录，一般划分三个目录：`conf`、`data`、`log`，分别存放 **配置**、**数据** 和 **日志** 相关文件。把 `6` 个节点配置统一放在 `conf` 目录下。

### 部署

Redis 集群节点的安装与单节点服务相同，差异仅在于部署方式。

假设三台服务器地址如下：

- 服务 A：127.0.0.1
- 服务 B：127.0.0.2
- 服务 C：127.0.0.3

分配如下：

| 服务器 | 127.0.0.1      | 127.0.0.2      | 127.0.0.3      |
| ------ | -------------- | -------------- | -------------- |
| 主节点 | 127.0.0.1:6380 | 127.0.0.2:6381 | 127.0.0.3:6382 |
| 从节点 | 127.0.0.1:6382 | 127.0.0.2:6380 | 127.0.0.3:6381 |

## Redis 命令

> 命令详细用法，请参考 [**Redis 命令官方文档**](https://redis.io/commands)
>
> 搬迁两张 cheat sheet 图，原址：https://www.cheatography.com/tasjaevan/cheat-sheets/redis/

<div align="center"><img src="http://dunwu.test.upcdn.net/cs/database/redis/redis-cheat-sheets-01.png!zp"/></div>

<div align="center"><img src="http://dunwu.test.upcdn.net/cs/database/redis/redis-cheat-sheets-02.png!zp"/></div>

## 压力测试

> 参考官方文档：[How fast is Redis?](https://redis.io/topics/benchmarks)

Redis 自带了一个性能测试工具：`redis-benchmark`

**（1）基本测试**

```
$ redis-benchmark -q -n 100000
```

- `-q` 表示静默（quiet）执行
- `-n 100000` 请求 10 万次

**（2）测试指定读写指令**

```
$ redis-benchmark -t set,lpush -n 100000 -q
SET: 74239.05 requests per second
LPUSH: 79239.30 requests per second
```

**（3）测试 pipeline 模式下指定读写指令**

```
redis-benchmark -n 1000000 -t set,get -P 16 -q
SET: 403063.28 requests per second
GET: 508388.41 requests per second
```

## 客户端

推荐使用 [**RedisDesktopManager**](https://github.com/uglide/RedisDesktopManager)

## 脚本

以上两种安装方式，我都写了脚本去执行：

| [安装脚本](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft) |

## 参考资料

- [Redis 官方文档](https://redis.io)
- [深入剖析 Redis 系列(三) - Redis 集群模式搭建与原理详解](https://juejin.im/post/5b8fc5536fb9a05d2d01fb11)
