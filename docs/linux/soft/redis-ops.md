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
    - [配置参数表](#配置参数表)
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

#### 配置参数表

| 配置项 | 说明 |
| :-- | :-- |
| `daemonize no` | Redis 默认不是以守护进程的方式运行，可以通过该配置项修改，使用 yes 启用守护进程（Windows 不支持守护线程的配置为 no ） |
| `pidfile /var/run/redis.pid` | 当 Redis 以守护进程方式运行时，Redis 默认会把 pid 写入 /var/run/redis.pid 文件，可以通过 pidfile 指定 |
| `port 6379` | 指定 Redis 监听端口，默认端口为 6379，作者在自己的一篇博文中解释了为什么选用 6379 作为默认端口，因为 6379 在手机按键上 MERZ 对应的号码，而 MERZ 取自意大利歌女 Alessia Merz 的名字 |
| `bind 127.0.0.1` | 绑定的主机地址 |
| `timeout 300` | 当客户端闲置多长时间后关闭连接，如果指定为 0，表示关闭该功能 |
| `loglevel notice` | 指定日志记录级别，Redis 总共支持四个级别：debug、verbose、notice、warning，默认为 notice |
| `logfile stdout` | 日志记录方式，默认为标准输出，如果配置 Redis 为守护进程方式运行，而这里又配置为日志记录方式为标准输出，则日志将会发送给 /dev/null |
| `databases 16` | 设置数据库的数量，默认数据库为 0，可以使用 SELECT 命令在连接上指定数据库 id |
| `save <seconds> <changes>` Redis 默认配置文件中提供了三个条件：**save 900 1**、**save 300 10**、**save 60 10000** 分别表示 900 秒（15 分钟）内有 1 个更改，300 秒（5 分钟）内有 10 个更改以及 60 秒内有 10000 个更改。 | 指定在多长时间内，有多少次更新操作，就将数据同步到数据文件，可以多个条件配合 |
| `rdbcompression yes` | 指定存储至本地数据库时是否压缩数据，默认为 yes，Redis 采用 LZF 压缩，如果为了节省 CPU 时间，可以关闭该选项，但会导致数据库文件变的巨大 |
| `dbfilename dump.rdb` | 指定本地数据库文件名，默认值为 dump.rdb |
| `dir ./` | 指定本地数据库存放目录 |
| `slaveof <masterip> <masterport>` | 设置当本机为 slav 服务时，设置 master 服务的 IP 地址及端口，在 Redis 启动时，它会自动从 master 进行数据同步 |
| `masterauth <master-password>` | 当 master 服务设置了密码保护时，slav 服务连接 master 的密码 |
| `requirepass foobared` | 设置 Redis 连接密码，如果配置了连接密码，客户端在连接 Redis 时需要通过 AUTH <password> 命令提供密码，默认关闭 |
| `maxclients 128` | 设置同一时间最大客户端连接数，默认无限制，Redis 可以同时打开的客户端连接数为 Redis 进程可以打开的最大文件描述符数，如果设置 maxclients 0，表示不作限制。当客户端连接数到达限制时，Redis 会关闭新的连接并向客户端返回 max number of clients reached 错误信息 |
| `maxmemory <bytes>` | 指定 Redis 最大内存限制，Redis 在启动时会把数据加载到内存中，达到最大内存后，Redis 会先尝试清除已到期或即将到期的 Key，当此方法处理 后，仍然到达最大内存设置，将无法再进行写入操作，但仍然可以进行读取操作。Redis 新的 vm 机制，会把 Key 存放内存，Value 会存放在 swap 区 |
| `appendonly no` | 指定是否在每次更新操作后进行日志记录，Redis 在默认情况下是异步的把数据写入磁盘，如果不开启，可能会在断电时导致一段时间内的数据丢失。因为 redis 本身同步数据文件是按上面 save 条件来同步的，所以有的数据会在一段时间内只存在于内存中。默认为 no |
| `appendfilename appendonly.aof` | 指定更新日志文件名，默认为 appendonly.aof |
| `appendfsync everysec` | 指定更新日志条件，共有 3 个可选值：**no**：表示等操作系统进行数据缓存同步到磁盘（快）**always**：表示每次更新操作后手动调用 fsync() 将数据写到磁盘（慢，安全）**everysec**：表示每秒同步一次（折中，默认值） |
| `vm-enabled no` | 指定是否启用虚拟内存机制，默认值为 no，简单的介绍一下，VM 机制将数据分页存放，由 Redis 将访问量较少的页即冷数据 swap 到磁盘上，访问多的页面由磁盘自动换出到内存中（在后面的文章我会仔细分析 Redis 的 VM 机制） |
| `vm-swap-file /tmp/redis.swap` | 虚拟内存文件路径，默认值为 /tmp/redis.swap，不可多个 Redis 实例共享 |
| `vm-max-memory 0` | 将所有大于 vm-max-memory 的数据存入虚拟内存，无论 vm-max-memory 设置多小，所有索引数据都是内存存储的(Redis 的索引数据 就是 keys)，也就是说，当 vm-max-memory 设置为 0 的时候，其实是所有 value 都存在于磁盘。默认值为 0 |
| `vm-page-size 32` | Redis swap 文件分成了很多的 page，一个对象可以保存在多个 page 上面，但一个 page 上不能被多个对象共享，vm-page-size 是要根据存储的 数据大小来设定的，作者建议如果存储很多小对象，page 大小最好设置为 32 或者 64bytes；如果存储很大大对象，则可以使用更大的 page，如果不确定，就使用默认值 |
| `vm-pages 134217728` | 设置 swap 文件中的 page 数量，由于页表（一种表示页面空闲或使用的 bitmap）是在放在内存中的，，在磁盘上每 8 个 pages 将消耗 1byte 的内存。 |
| `vm-max-threads 4` | 设置访问 swap 文件的线程数,最好不要超过机器的核数,如果设置为 0,那么所有对 swap 文件的操作都是串行的，可能会造成比较长时间的延迟。默认值为 4 |
| `glueoutputbuf yes` | 设置在向客户端应答时，是否把较小的包合并为一个包发送，默认为开启 |
| `hash-max-zipmap-entries 64 hash-max-zipmap-value 512` | 指定在超过一定的数量或者最大的元素超过某一临界值时，采用一种特殊的哈希算法 |
| `activerehashing yes` | 指定是否激活重置哈希，默认为开启（后面在介绍 Redis 的哈希算法时具体介绍） |
| `include /path/to/local.conf` | 指定包含其它的配置文件，可以在同一主机上多个 Redis 实例之间使用同一份配置文件，而同时各个实例又拥有自己的特定配置文件 |

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
