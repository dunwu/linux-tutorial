# Redis 安装

> **Redis** 是一个高性能的 key-value 数据库。
>
> SET 操作每秒钟 110000 次；GET 操作每秒钟 81000 次。

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装](#安装)
  - [Window 下安装](#window-下安装)
  - [Linux 下安装](#linux-下安装)
  - [Ubuntu 下安装](#ubuntu-下安装)
  - [启动 Redis](#启动-redis)
  - [查看 redis 是否启动？](#查看-redis-是否启动)
- [脚本](#脚本)

<!-- /TOC -->

## 安装

### Window 下安装

**下载地址：**<https://github.com/MSOpenTech/redis/releases>。

Redis 支持 32 位和 64 位。这个需要根据你系统平台的实际情况选择，这里我们下载 **Redis-x64-xxx.zip**压缩包到 C 盘，解压后，将文件夹重新命名为 **redis**。

打开一个 **cmd** 窗口 使用 cd 命令切换目录到 **C:\redis** 运行 **redis-server.exe redis.windows.conf** 。

如果想方便的话，可以把 redis 的路径加到系统的环境变量里，这样就省得再输路径了，后面的那个 redis.windows.conf 可以省略，如果省略，会启用默认的。输入之后，会显示如下界面：

这时候另启一个 cmd 窗口，原来的不要关闭，不然就无法访问服务端了。

切换到 redis 目录下运行 **redis-cli.exe -h 127.0.0.1 -p 6379** 。

设置键值对 **set myKey abc**

取出键值对 **get myKey**

### Linux 下安装

**下载地址：** http://redis.io/download，下载最新文档版本。

本教程使用的最新文档版本为 2.8.17，下载并安装：

```
$ wget -O /opt/redis/redis-4.0.8.tar.gz http://download.redis.io/releases/redis-4.0.8.tar.gz
$ cd /opt/redis
$ tar zxvf redis-4.0.8.tar.gz
```

make 完后 redis-2.8.17 目录下会出现编译后的 redis 服务程序 redis-server,还有用于测试的客户端程序 redis-cli,两个程序位于安装目录 src 目录下：

下面启动 redis 服务.

```
$ cd src
$ ./redis-server
```

注意这种方式启动 redis 使用的是默认配置。也可以通过启动参数告诉 redis 使用指定配置文件使用下面命令启动。

```
$ cd src
$ ./redis-server redis.conf
```

redis.conf 是一个默认的配置文件。我们可以根据需要使用自己的配置文件。

启动 redis 服务进程后，就可以使用测试客户端程序 redis-cli 和 redis 服务交互了。 比如：

```
$ cd src
$ ./redis-cli
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

### 启动 Redis

**启动 redis 服务**

```
cd /opt/redis/redis-4.0.8/src
./redis-server
```

**启动 redis 客户端**

```
cd /opt/redis/redis-4.0.8/src
./redis-cli
```

### 查看 redis 是否启动？

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

以上说明我们已经成功安装了 redis。

## 脚本

以上两种安装方式，我都写了脚本去执行：

| [安装脚本](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft) |
